//
//  QQApiActivity.m
//  Editor
//
//  Created by Snaill on 15/8/2.
//  Copyright (c) 2015年 Snaill. All rights reserved.
//

#import "QQApiActivity.h"
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>

@interface QQApiActivity()<TencentSessionDelegate, QQApiInterfaceDelegate>

@property (nonatomic, strong) TencentOAuth * tencentOAuth;
@end

@implementation QQApiActivity

+ (QQApiActivity *)sharedQQApi {
    static QQApiActivity * sharedQQApi;
    
    @synchronized(self) {
        if ( nil == sharedQQApi ) {
            sharedQQApi = [[QQApiActivity alloc]init];
        }
        return sharedQQApi;
    }
}

+ (void) registerApp:(NSString *)appid {
    [QQApiActivity sharedQQApi].tencentOAuth = [[TencentOAuth alloc] initWithAppId:appid andDelegate:[QQApiActivity sharedQQApi]];
}

+ (BOOL) handleOpenURL:(NSURL *) url {
    return [QQApiInterface handleOpenURL:url delegate:[QQApiActivity sharedQQApi]];
}

- (void)tencentLogin
{
    NSArray *permissions = [NSArray arrayWithObjects:@"get_user_info", @"add_t", nil];
    if ([TencentOAuth iphoneQQInstalled] && [TencentOAuth iphoneQQSupportSSOLogin]) {
        [self.tencentOAuth authorize:permissions inSafari:NO];
    } else {
        [self.tencentOAuth authorize:permissions inSafari:YES];
    }
}

- (NSData *)thumbImageData
{
    if (nil == self.image)
        return nil;
    
    CGFloat width = 100.0f;
    CGFloat height = self.image.size.height * 100.0f / self.image.size.width;
    UIGraphicsBeginImageContext(CGSizeMake(width, height));
    [self.image drawInRect:CGRectMake(0, 0, width, height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return UIImageJPEGRepresentation(scaledImage, 1.0);
}

- (void)handleSendResult:(QQApiSendResultCode)sendResult
{
    if (sendResult == EQQAPISENDSUCESS || sendResult == EQQAPIAPPSHAREASYNC) {
        return;
    }
    
    NSString *errorMessage = @"";
    switch (sendResult) {
        case EQQAPIQQNOTINSTALLED:
        {
            errorMessage = @"手机QQ没有安装";
            break;
        }
        case EQQAPIAPPNOTREGISTED:
        {
            errorMessage = @"没有注册";
            break;
        }
        case EQQAPIMESSAGECONTENTINVALID:
        {
            errorMessage = @"内容非法";
            break;
        }
        case EQQAPIMESSAGECONTENTNULL:
        {
            errorMessage = @"空内容";
            break;
        }
        case EQQAPIMESSAGETYPEINVALID:
        {
            errorMessage = @"message type invalid";
            break;
        }
        case EQQAPIQQNOTSUPPORTAPI:
        {
            errorMessage = @"不支持这个api";
            break;
        }
        case EQQAPISENDFAILD:
        {
            errorMessage = @"分享失败";
            break;
        }
        default:
        {
            errorMessage = @"未知错误";
            break;
        }
    }
    
    NSLog(@"%@", errorMessage);
}

#pragma mark -

- (void)tencentDidLogin
{
    NSLog(@"登录成功");
}

- (void)tencentDidNotLogin:(BOOL)cancelled
{
    NSLog(@"登录失败");
}

- (void)tencentDidNotNetWork {
    NSLog(@"没有网络");
}

#pragma mark - QQApiInterfaceDelegate

/**
 * 处理来至QQ的请求
 */
- (void)onReq:(QQBaseReq *)req {
     NSLog(@"QQApiInterfaceDelegate::onReq");
}

/**
 * 处理来至QQ的响应
 */
- (void)onResp:(QQBaseResp *)resp {
    NSLog(@"QQApiInterfaceDelegate::onResp");
}

/**
 * 处理QQ在线状态的回调
 */
- (void)isOnlineResponse:(NSDictionary *)response {
    NSLog(@"QQApiInterfaceDelegate::isOnlineResponse");
}

#pragma mark - BaseActivity

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    if ([QQApiInterface isQQInstalled] && [QQApiInterface isQQSupportApi]) {
        for (id activityItem in activityItems) {
            if ([activityItem isKindOfClass:[UIImage class]]) {
                return YES;
            }
            if ([activityItem isKindOfClass:[NSURL class]]) {
                return YES;
            }
        }
    }
    return NO;
}

- (void)prepareWithActivityItems:(NSArray *)activityItems
{
    for (id activityItem in activityItems) {
        if ([activityItem isKindOfClass:[UIImage class]]) {
            self.image = activityItem;
        }
        if ([activityItem isKindOfClass:[NSURL class]]) {
            self.url = activityItem;
        }
        if ([activityItem isKindOfClass:[NSString class]]) {
            self.title = activityItem;
        }
    }
}

- (void)performActivity
{
    if ([QQApiActivity sharedQQApi].tencentOAuth.isSessionValid) {
        [self tencentLogin];
        [self activityDidFinish:YES];
        return;
    }
    
    NSString * title = [NSString stringWithFormat:NSLocalizedString(@"%@ Share",nil), NSLocalizedStringFromTable(@"CFBundleDisplayName", @"InfoPlist", nil)];
    NSString * description = self.title;
    QQApiObject * object = nil;
    if (self.url) {
        object = [QQApiNewsObject objectWithURL:self.url
                        title: title
                        description:description
                        previewImageData:[self thumbImageData]];
        
    } else if (self.image) {
        object = [QQApiImageObject objectWithData:UIImageJPEGRepresentation(self.image, 1)
                        previewImageData:[self thumbImageData]
                        title:title
                        description:description];
    }
    
    SendMessageToQQReq *req = [SendMessageToQQReq reqWithContent:object];
    QQApiSendResultCode code;
    if (!self.useQZone) {
        //将内容分享到qq
        code = [QQApiInterface sendReq:req];
    } else {
        //将内容分享到qzone
        code = [QQApiInterface SendReqToQZone:req];
    }
    
    [self handleSendResult:code];
    [self activityDidFinish:YES];
}

@end
