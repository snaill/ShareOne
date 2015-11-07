# ShareOne

[![CI Status](http://img.shields.io/travis/snaill/ShareOne.svg?style=flat)](https://travis-ci.org/snaill/ShareOne)
[![Version](https://img.shields.io/cocoapods/v/ShareOne.svg?style=flat)](http://cocoapods.org/pods/ShareOne)
[![License](https://img.shields.io/cocoapods/l/ShareOne.svg?style=flat)](http://cocoapods.org/pods/ShareOne)
[![Platform](https://img.shields.io/cocoapods/p/ShareOne.svg?style=flat)](http://cocoapods.org/pods/ShareOne)

ShareOne是一款用于分享到微信/QQ的库，相对于已有的分享库，ShareOne的特点是

* 采用自定义UIActivity
* 接口简单

注：分享到微信的代码来源于[WeixinActivity](https://github.com/iDay/WeixinActivity)，本来ShareOne是依赖于WeixinActivity，但由于XCode 7增加BITCODE的设置，而WxApi和QQ API都没有跟随更新，导致部署时编译错误。在WeixinActivity未更新前，暂时将代码并入ShareOne中，以方便使用。

## Installation

* 通过[CocoaPods](http://cocoapods.org)安装.

```ruby
pod "ShareOne"
```
* 在AppDelegate.m中注册APP ID

```ruby
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [ShareOne registerWX:@"wx11111"];
    [ShareOne registerQQ:@"22222"];
```
* 此外，您还需要调用handle函数

```ruby
- (BOOL)application:(UIApplication *)application handleOpenURL:(NSURL *)url {
    return [ShareOne handleOpenURL:url];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    return [ShareOne handleOpenURL:url];
}
```

* 调用UIActivityViewController实现分享

```ruby
NSArray * activity = [ShareOne activitysWithTypes:@[@(ShareOneTypeWeixin), @(ShareOneTypeWeixinTimeline), @(ShareOneTypeQQ), @(ShareOneTypeQZone)]];
    
NSMutableArray * activityItems = @[title, image, url];    
UIActivityViewController *activityView = [[UIActivityViewController alloc] initWithActivityItems:activityItems applicationActivities:activity];
[self presentViewController:activityView animated:YES completion:nil];
```
    
## Requirements
* iOS 8
* ARC

## License

ShareOne is available under the MIT license. See the LICENSE file for more info.
