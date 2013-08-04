//
//  P2AppDelegate.m
//  Pet21Show
//
//  Created by zeng on 12-8-10.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2AppDelegate.h"

#import "EICrashHandler.h"
#import "KeychainItemWrapper.h"
#import "P2PetShow_Utility.h"
#import "EIPhoneDBCommand.h"


#import "P2OnLineViewController.h"
#import "P2GruopViewController.h"
#import "P2UserViewController.h"
#import "P2RoomViewController.h"


@implementation P2AppDelegate

- (void)dealloc
{
    [_window release];
//    [_viewController release];
    [super dealloc];
}


- (void)getUserInfo
{
    
        [Session setSession:@"id" value:@"19"];
    
    NSMutableDictionary  *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"name" forKey:@"name"];
    [dict setValue:@"username" forKey:@"username"];
    [dict setValue:@"desc" forKey:@"desc"];
    [dict setValue:@"19" forKey:@"id"];
    
    //    提醒
    //    信
    //    礼物
    //    好友请求
    //    好友发布消息
    //    评论
    //    心情
    [dict setValue:@"message" forKey:@"message"];
    
    //    地理位置
    
    [Session setSession:@"userInfo" value:dict];
    
    [dict release];
}



- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [[NSNotificationCenter defaultCenter] postNotificationName:KDidReceiveRemoteNotification object:nil];
    
}


- (void)application:(UIApplication *)app didFailToRegisterForRemoteNotificationsWithError:(NSError *)err
{
    NSLog(@"%@", err);
    UIAlertView *av = [[UIAlertView alloc]initWithTitle:@"error" message:@"授权失败" delegate:self cancelButtonTitle:@"OK" otherButtonTitles: nil];
    
    [av show];
    [av release];
}

- (void)application:(UIApplication*)application
didRegisterForRemoteNotificationsWithDeviceToken:(NSData*)deviceToken {
    
    NSString *tokenStr = [deviceToken description];
    NSString *pushToken = [[[[tokenStr
                              stringByReplacingOccurrencesOfString:@"<" withString:@""]
                             stringByReplacingOccurrencesOfString:@">" withString:@""]
                            stringByReplacingOccurrencesOfString:@" " withString:@""] retain];
    
    // Save the token to server
    
    //  NSString *urlStr = [NSString stringWithFormat:@"https://%@/push_token", RINGFULDOMAIN];
    //  NSURL *url = [NSURL URLWithString:urlStr];
    //  NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:url];
    //
    //  [req setHTTPMethod:@"POST"];
    //  [req setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"Content-type"];
    //  NSMutableData *postBody = [NSMutableData data];
    //  [postBody appendData:[[NSString stringWithFormat:@"username=%@", username]
    //                        dataUsingEncoding:NSUTF8StringEncoding]];
    //  [postBody appendData:[[NSString stringWithFormat:@"&token=%@",
    //                         pushToken] dataUsingEncoding:NSUTF8StringEncoding]];
    //
    //  [req setHTTPBody:postBody];
    //  [[NSURLConnection alloc] initWithRequest:req delegate:nil];
}

- (void)copyDB
{
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
//    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//    NSString *documentsDirectory = [paths objectAtIndex:0];
    
//    NSString *txtPath = [documentsDirectory stringByAppendingPathComponent:@"txtFile.txt"];
    
    NSString *dbpath = [EIPhoneDBCommand getPath:@"art.db"];
    NSString *dbpathTmp = [EIPhoneDBCommand getPath:@"art_tmp.db"];
    
    
    NSString *resourcePath = [[NSBundle mainBundle] pathForResource:@"art" ofType:@"db"];
    
    if ([fileManager fileExistsAtPath:dbpath] == NO) {
        [fileManager copyItemAtPath:resourcePath toPath:dbpath error:&error];
    }
    
    if ([fileManager fileExistsAtPath:dbpathTmp] == NO) {
        
        [fileManager copyItemAtPath:resourcePath toPath:dbpathTmp error:&error];
    }
    
}



//前台 or 后台
- (void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo
{
    
    NSLog(@" 收到推送消息 ： %@",[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]);
    if ([[userInfo objectForKey:@"aps"] objectForKey:@"alert"]!=NULL) {
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"推送通知"
                                                        message:[[userInfo objectForKey:@"aps"] objectForKey:@"alert"]
                                                       delegate:self
                                              cancelButtonTitle:@" 关闭"
                                              otherButtonTitles:@" 更新状态",nil];
        [alert show];
        [alert release];
    }
    
    
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    [[EICrashHandler crashHandler] saveCrashesData ];

    [self copyDB];
    [self getUserInfo];
    

    
    
    self.window = [[[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] autorelease];
    // Override point for customization after application launch.
    UIViewController *onlineViewController=nil;
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        onlineViewController = [[[P2OnLineViewController alloc] initWithNibName:@"P2OnLineViewController" bundle:nil] autorelease];
    } else {
        onlineViewController = [[[P2OnLineViewController alloc] initWithNibName:@"P2OnLineViewController" bundle:nil] autorelease];
    }

//    UIViewController *groupViewController=nil;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        groupViewController = [[[P2GruopViewController alloc] initWithNibName:@"P2GruopViewController" bundle:nil] autorelease];
//    } else {
//        groupViewController = [[[P2GruopViewController alloc] initWithNibName:@"P2GruopViewController_iPad" bundle:nil] autorelease];
//    }
//    
//    UIViewController *roomViewController=nil;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        roomViewController = [[[P2RoomViewController alloc] initWithNibName:@"P2RoomViewController" bundle:nil] autorelease];
//    } else {
//        roomViewController = [[[P2RoomViewController alloc] initWithNibName:@"P2RoomViewController_iPad" bundle:nil] autorelease];
//    }
//    
//    UIViewController *userViewController=nil;
//    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
//        userViewController = [[[P2UserViewController alloc] initWithNibName:@"P2UserViewController" bundle:nil] autorelease];
//    } else {
//        userViewController = [[[P2OnLineViewController alloc] initWithNibName:@"P2UserViewController_iPad" bundle:nil] autorelease];
//    }

//    UITabBarItem *tabBarItem1 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"活动", @"") image:nil tag:0];
//    tabBarItem1.
//    UITabBarItem *tabBarItem2 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"小组", @"") image:nil tag:1];
//    UITabBarItem *tabBarItem3 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"一对一", @"") image:nil tag:2];
//    UITabBarItem *tabBarItem4 = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"我的Art", @"") image:nil tag:3];
    

    
//    UINavigationController *onlineNavCV = [[UINavigationController alloc] initWithRootViewController:onlineViewController];
//    onlineNavCV.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"NavBar"]];
//    
//    navCV.navigationBar.tintColor = [UIColor redColor];
//    onlineNavCV.tabBarItem = tabBarItem1  ;

    
//    UINavigationController *groupNavCV = [[UINavigationController alloc] initWithRootViewController:groupViewController];
//    groupNavCV.navigationItem.title = NSLocalizedString(@"一对一", @"");
//    groupNavCV.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nagationBackgroundColor"]];
//    //    navCV.navigationBar.tintColor = [UIColor redColor];
//    groupNavCV.tabBarItem = tabBarItem2;
//    
//    
//    UINavigationController *roomNavCV = [[UINavigationController alloc] initWithRootViewController:roomViewController];
//    roomNavCV.navigationItem.title = NSLocalizedString(@"小组", @"");
//    roomNavCV.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nagationBackgroundColor"]];
////    navCV.navigationBar.tintColor = [UIColor redColor];
//    roomNavCV.tabBarItem = tabBarItem3;
//    
//    
//    UINavigationController *userNavCV = [[UINavigationController alloc] initWithRootViewController:userViewController];
//    userNavCV.navigationBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"nagationBackgroundColor"]];
//    onlineNavCV.navigationItem.title = NSLocalizedString(@"我的Art", @"");    
//    //    navCV.navigationBar.tintColor = [UIColor redColor];
//    userNavCV.tabBarItem = tabBarItem4;
    

    
//    UITabBarController *tbController = [[UITabBarController alloc] init];
//    tbController.delegate = self;
////    tbController.tabBar.tintColor = [UIColor yellowColor];
//    tbController.viewControllers = [NSArray arrayWithObjects:                                    
//                                    onlineNavCV,
//                                    userNavCV,
////                                    groupNavCV,
////                                    roomNavCV,
//                                    nil];
//    tbController.tabBar.tintColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"navBackgroupColor"]];


    
//    self.window.rootViewController = onlineNavCV;
//    
//    [onlineNavCV release];
//    [groupNavCV release];
//    [roomNavCV release];
//    [userNavCV release];
//    [tbController release];
   
    
    [self.window makeKeyAndVisible];

    
    

#if !(TARGET_IPHONE_SIMULATOR)
    NSLog(@"Running on device!");

    [[UIApplication sharedApplication]  registerForRemoteNotificationTypes:
     (UIRemoteNotificationTypeBadge | UIRemoteNotificationTypeSound |  UIRemoteNotificationTypeAlert)];
#endif
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.

}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    	    
}

@end
