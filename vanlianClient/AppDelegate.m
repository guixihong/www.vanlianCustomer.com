//
//  AppDelegate.m
//  vanlianClient
//
//  Created by SU on 2017/4/5.
//  Copyright © 2017年 VKLJ_SU. All rights reserved.
//

#import "AppDelegate.h"
NSString *STATUSSTRING = @"";
@interface AppDelegate ()
/** 网络状态检查者 */
@property(nonatomic, strong) AFNetworkReachabilityManager *networkMonitorManager;
@end

@implementation AppDelegate

#pragma mark -
- (AFNetworkReachabilityManager *)networkMonitorManager {
    
    if (!_networkMonitorManager) {
        _networkMonitorManager = [AFNetworkReachabilityManager sharedManager];
        [_networkMonitorManager startMonitoring];  //开始监听
    }
    return _networkMonitorManager;
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                STATUSSTRING = @"未知网络";
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                STATUSSTRING = @"没有网络";
                
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机自带网络");
                STATUSSTRING = @"手机自带网络";
                
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                STATUSSTRING = @"WIFI";
                
                break;
        }
    }];
    
    //开始监控
    [manager startMonitoring];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];

    //数据库
    //    [MagicalRecord setupCoreDataStackWithStoreNamed:@"SU2.sqlite"];
    //    NSLog(@"%@",NSHomeDirectory());
    
//    NSString *str = [[NSUserDefaults standardUserDefaults] objectForKey:@"ISLOGIN"];
    
    //    if([str isEqualToString:@"登录"]){
    
    CustomTabBarViewController *tbvc = [[CustomTabBarViewController alloc]init];
    self.window.rootViewController = [tbvc createUI];

    
    //    }else{
    //
    //        LoginController *lc = [[LoginController alloc]init];
    //        UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:lc];
    //        self.window.rootViewController = nav;
    //    }
    
    [self.window makeKeyAndVisible];

      return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}


- (void)applicationDidEnterBackground:(UIApplication *)application {

}


- (void)applicationWillEnterForeground:(UIApplication *)application {

}


- (void)applicationDidBecomeActive:(UIApplication *)application {

}


- (void)applicationWillTerminate:(UIApplication *)application {
 
    //数据库
    //    [MagicalRecord cleanUp];
}


@end
