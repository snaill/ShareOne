//
//  BaseActivity.m
//  Editor
//
//  Created by Snaill on 15/8/2.
//  Copyright (c) 2015年 Snaill. All rights reserved.
//

#import "BaseActivity.h"

@implementation BaseActivity

+ (UIImage *)imageNamed:(NSString *)imageNamed {
    
    UIImage * image = [UIImage imageNamed:imageNamed];
    if (nil == image) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"ShareOne.bundle/%@", imageNamed]];
    }
    if (nil == image) {
        image = [UIImage imageNamed:[NSString stringWithFormat:@"Frameworks/ShareOne.framework/%@", imageNamed]];
    }
    
    return image;
}

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
    return [BaseActivity imageNamed:[self activityType]];
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
