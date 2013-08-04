//
//  P2CustomTabBar.h
//  Artvotary
//
//  Created by zeng on 12-11-29.
//  Copyright (c) 2012年 zeng. All rights reserved.
//


@class P2CustomTabBar;
@protocol P2CustomTabBarDelegate

- (UIImage*) imageFor:(P2CustomTabBar*)tabBar atIndex:(NSUInteger)itemIndex;
- (UIImage*) backgroundImage;
- (UIImage*) selectedItemBackgroundImage :(NSUInteger)itemIndex;;
//- (UIImage*) glowImage;
- (UIImage*) selectedItemImage;
//- (UIImage*) tabBarArrowImage;

@optional
- (void) touchUpInsideItemAtIndex:(NSUInteger)itemIndex;
- (void) touchDownAtItemAtIndex:(NSUInteger)itemIndex;
@end


#import <UIKit/UIKit.h>

@interface P2CustomTabBar : UIView
{
    NSObject <P2CustomTabBarDelegate> *delegate;
    NSMutableArray* buttons;
}

@property (nonatomic, retain) NSMutableArray* buttons;

- (id) initWithItemCount:(NSUInteger)itemCount itemSize:(CGSize)itemSize tag:(NSInteger)objectTag delegate:(NSObject <P2CustomTabBarDelegate>*)customTabBarDelegate;

- (void) selectItemAtIndex:(NSInteger)index;
//- (void) glowItemAtIndex:(NSInteger)index;
//- (void) removeGlowAtIndex:(NSInteger)index;

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration;

@end