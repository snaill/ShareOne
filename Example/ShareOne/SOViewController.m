//
//  SOViewController.m
//  ShareOne
//
//  Created by snaill on 09/19/2015.
//  Copyright (c) 2015 snaill. All rights reserved.
//

#import "SOViewController.h"
#import <ShareOne/ShareOne.h>

@interface SOViewController ()

@property (nonatomic, weak) IBOutlet UIImageView * imageView;
@end

@implementation SOViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onShare:(id)sender {

    NSArray * activityItems = @[@"ShareOne", self.imageView.image, [NSURL URLWithString:@"http://baidu.com"]];
    NSArray * activitys = [ShareOne activitysWithTypes:@[@(ShareOneTypeWeixin), @(ShareOneTypeWeixinTimeline), @(ShareOneTypeQQ), @(ShareOneTypeQZone)]];
    UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activitys];
    [self presentViewController:activityView animated:YES completion:nil];
}
@end
