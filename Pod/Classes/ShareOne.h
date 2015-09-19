//
//  ShareOne.h
//  ShareOne
//
//  Created by Snaill on 15/9/19.
//
//

#import <Foundation/Foundation.h>

typedef enum {
    ShareOneTypeWeixin,
    ShareOneTypeWeixinTimeline,
    ShareOneTypeQQ,
    ShareOneTypeQZone,
    
} ShareOneType;

@interface ShareOne : NSObject

+ (void) registerWX:(NSString *)appid;
+ (void) registerQQ:(NSString *)appid;

+ (BOOL) handleOpenURL:(NSURL *) url;
+ (NSArray *) activitysWithTypes:(NSArray *)types;

@end
