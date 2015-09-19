//
//  WeixinTimelineActivity.m
//  WeixinActivity
//
//  Created by Johnny iDay on 13-12-2.
//  Copyright (c) 2013年 Johnny iDay. All rights reserved.
//

#import "WeixinTimelineActivity.h"
#import "BaseActivity.h"

@implementation WeixinTimelineActivity

- (id)init
{
    self = [super init];
    if (self) {
        scene = WXSceneTimeline;
    }
    return self;
}

- (UIImage *)activityImage
{
    return [[[UIDevice currentDevice] systemVersion] intValue] >= 8 ? [BaseActivity imageNamed:@"icon_timeline-8.png"] : [BaseActivity imageNamed:@"icon_timeline.png"];
}

- (NSString *)activityTitle
{
    return NSLocalizedString(@"WeChat Timeline", nil);
}


@end
