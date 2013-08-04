//
//  P2TabBarViewController.h
//  Artvotary
//
//  Created by zeng on 12-11-29.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "P2CustomTabBar.h"

@interface P2TabBarViewController : UIViewController<P2CustomTabBarDelegate>
{
    P2CustomTabBar* tabBar;
}

@property (nonatomic, retain) P2CustomTabBar* tabBar;
@end
