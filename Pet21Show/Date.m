//
//  Date.m
//  LifeLine
//
//  Created by zeng on 12-9-1.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "Date.h"

@implementation Date

+ (NSString *)now
{
    NSDate* date = [NSDate date];
    NSDateFormatter* formatter = [[[NSDateFormatter alloc] init] autorelease];
    [formatter setDateFormat:@"yyyy-MM-dd HH:MM:SS"];

    NSString* now = [formatter stringFromDate:date];
    return now;
}
//+ (NSDate *)lastDate
//{
//    NSDate *curDate = [NSDate date];
//    NSCalendar* calendar = [NSCalendar currentCalendar];
//    NSDateComponents* comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:curDate]; // Get necessary date components
//    
//    comps = [calendar components:NSYearCalendarUnit|NSMonthCalendarUnit|NSWeekCalendarUnit|NSWeekdayCalendarUnit fromDate:curDate]; // Get necessary date components
//    // set last of month
////    [comps setMonth:[comps month]];
//    [comps setDay:1];
//    
//    NSDate *tDateMonth = [calendar dateFromComponents:comps];
//    return tDateMonth;
//}

+ (NSDate *)dateAfterDay :(NSDate *)curDate  :(int)day
{
//    NSDate *curDate = [NSDate date];
    NSLog(@"%@", curDate);
    
    NSCalendar *calendar = [NSCalendar currentCalendar];

    NSDateComponents *componentsToAdd = [[NSDateComponents alloc] init];
    [componentsToAdd setDay:day];
    
    
    NSDate *dateAfterDay = [calendar dateByAddingComponents:componentsToAdd toDate:curDate options:0];
    
    [componentsToAdd release];
    
    
    return dateAfterDay;
}

+ (NSString *)currentdateToDate:(NSDate *)endDate
{

    NSDate *currentDate = [self dateAfterDay:endDate:1];
    
    NSTimeInterval time=[currentDate timeIntervalSinceDate:[NSDate date]];
    
    NSLog(@"%@\n%@  ", currentDate, endDate);
    int days=((int)time)/(3600*24);
    int hours=((int)time)%(3600*24)/3600;
    int minute=((int)time)%(3600*24)/3600/60;
    int second=((int)time)%(3600*24)/3600/3660;
    NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时%i分%i秒",days,hours,minute,second];
    
    return dateContent;
}

@end
