//
//  Date.h
//  LifeLine
//
//  Created by zeng on 12-9-1.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Date : NSObject
+ (NSString *)now;
+ (NSDate *)dateAfterDay:(int)day;
+ (NSString *)currentdateToDate:(NSDate *)endDate;
@end
