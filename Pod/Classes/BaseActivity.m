//
//  BaseActivity.m
//  Editor
//
//  Created by Snaill on 15/8/2.
//  Copyright (c) 2015年 Snaill. All rights reserved.
//

#import "BaseActivity.h"

@implementation BaseActivity

+ (UIActivityCategory)activityCategory
{
    return UIActivityCategoryShare;
}

- (NSString *)activityType
{
    return NSStringFromClass([self class]);
}

- (UIImage *)activityImage
{
    return [UIImage imageNamed:[NSString stringWithFormat:@"Frameworks/ShareOne.framework/ShareOne.bundle/%@", [self activityType]]];
}

- (NSString *)activityTitle
{
    return NSLocalizedString([self activityType], nil);
}

- (BOOL)canPerformWithActivityItems:(NSArray *)activityItems
{
    return YES;
}

@end
