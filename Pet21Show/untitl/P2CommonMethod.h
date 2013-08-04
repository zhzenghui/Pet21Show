//
//  P2CommonMethod.h
//  LifeLine
//
//  Created by zeng on 12-8-22.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface P2CommonMethod : NSObject

+(NSString *) randFileName;
+(NSString *) md5TimeIDToRandFileName;

+ (void)setTabBarItemBadge:(UIViewController *)viewController :(NSString *)badgeValue;

+ (CGRect)returnInputRectCopySize:(CGRect)rect;

@end
