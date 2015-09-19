//
//  WeixinSessionActivity.m
//  WeixinActivity
//
//  Created by Johnny iDay on 13-12-2.
//  Copyright (c) 2013年 Johnny iDay. All rights reserved.
//

#import "WeixinSessionActivity.h"

@implementation WeixinSessionActivity

- (UIImage *)activityImage
{
    return [[[UIDevice currentDevice] systemVersion] intValue] >= 8 ? [UIImage imageNamed:@"Frameworks/ShareOne.framework/ShareOne.bundle/icon_session-8.png"] : [UIImage imageNamed:@"Frameworks/ShareOne.framework/ShareOne.bundle/icon_session.png"];
}

- (NSString *)activityTitle
{
    return NSLocalizedString(@"WeChat Session", nil);
}

@end
