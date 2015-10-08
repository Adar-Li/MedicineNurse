//
//  AppDelegate.m
//  MedicineNurse
//
//  Created by lanou3g on 15/10/6.
//  Copyright © 2015年 Adar-Li. All rights reserved.
//

#import "AppDelegate.h"
#import "CommonController.h"
#import "SufferTableViewController.h"
#import "NearbyViewController.h"
#import "UserListController.h"
#import "HomeController.h"
#import "SufferViewController.h"

#import <UIKit/UIKit.h>
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
   
    self.window = [[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor cyanColor];
    
    [self.window makeKeyAndVisible];
    
    
    UITabBarController *HomeBar = [[UITabBarController alloc]init];
    UINavigationController *HomeNC = [[UINavigationController alloc]initWithRootViewController:[HomeController new]];
    HomeNC.tabBarItem.title = @"首页";
    HomeNC.title = @"首页";
    
    UINavigationController *common = [[UINavigationController alloc]initWithRootViewController:[CommonController new]];
    
    common.tabBarItem.title = @"常见病症";
    common.title = @"常见病症";
   
    UINavigationController *suffer = [[UINavigationController alloc]initWithRootViewController:[SufferViewController new]];
    suffer.tabBarItem.title = @"用药咨询";
    suffer.title = @"用药咨询";
    
    
    UINavigationController *Nearby = [[UINavigationController alloc]initWithRootViewController:[NearbyViewController new]];
    Nearby.tabBarItem.title = @"附近";
    
    
    UINavigationController *User = [[UINavigationController alloc]initWithRootViewController:[UserListController new]];
    User.tabBarItem.title = @"用户";
    
    HomeBar.viewControllers = @[HomeNC ,common ,suffer,Nearby ,User];
    
    [HomeBar parentViewController];

    
    self.window.rootViewController = HomeBar;
    //临时测试
//    HomeController * homeVC = [[HomeController alloc]init];
//    self.window.rootViewController = homeVC;

//    //临时测试
//    HomeController * homeVC = [[HomeController alloc]init];
//    self.window.rootViewController = homeVC;

    
 
    return YES;
    
}


- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
