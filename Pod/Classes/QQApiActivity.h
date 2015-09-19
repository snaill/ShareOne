//
//  QQApiActivity.h
//  Editor
//
//  Created by Snaill on 15/8/2.
//  Copyright (c) 2015年 Snaill. All rights reserved.
//

#import "BaseActivity.h"

@interface QQApiActivity : BaseActivity

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) UIImage *image;
@property (nonatomic, strong) NSURL *url;

@property (nonatomic) BOOL useQZone;

+ (void) registerApp:(NSString *)appid;
+ (BOOL) handleOpenURL:(NSURL *) url;
@end
