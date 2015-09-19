//
//  ShareOne.m
//  ShareOne
//
//  Created by Snaill on 15/9/19.
//
//

#import "ShareOne.h"
#import "WeixinActivity.h"
#import "QQActivity.h"
#import "QZoneActivity.h"
#import <TencentOpenAPI/QQApiInterface.h>

@implementation ShareOne

+ (void) registerWX:(NSString *)appid {
    [WXApi registerApp:appid];
}

+ (void) registerQQ:(NSString *)appid {
    [QQApiActivity registerApp:appid];
}

+ (BOOL) handleOpenURL:(NSURL *) url {
    
    if ([url.absoluteString hasPrefix:@"wx"]) {
        return [WXApi handleOpenURL:url delegate:nil];
    } else {
        return [QQApiInterface handleOpenURL:url delegate:nil];
    }
}

+ (NSArray *) activitysWithTypes:(NSArray *)types {
    
    NSMutableArray * activitys = [NSMutableArray array];
    for (NSNumber * type in types) {
        switch ([type integerValue]) {
            case ShareOneTypeWeixin:
                [activitys addObject:[WeixinSessionActivity new]];
                break;
            case ShareOneTypeWeixinTimeline:
                [activitys addObject:[WeixinTimelineActivity new]];
                break;
            case ShareOneTypeQQ:
                [activitys addObject:[QQActivity new]];
                break;
            case ShareOneTypeQZone:
                [activitys addObject:[QZoneActivity new]];
                break;
            default:
                break;
        }
    }
    
    return activitys;
}
@end
