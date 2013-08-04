//
//  P2CommonMethod.m
//  LifeLine
//
//  Created by zeng on 12-8-22.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2CommonMethod.h"

#import <CommonCrypto/CommonDigest.h>

@implementation P2CommonMethod

+(NSString *)randFileName
{
    // 获取系统时间
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyMMddHHmmssSSSSSS"];
    
    // 时间字符串
    NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    // 随机5位字符串
    NSMutableString *randstr = [[NSMutableString alloc]init];
    for(int i = 0 ; i < 5 ; i++)
    {
        int val= arc4random()%10;
        [randstr appendString:[NSString stringWithFormat:@"%d",val]];
    }
    
    // 生成文件名
    NSString *string = [NSString stringWithFormat:@"F%@%@",datestr,randstr];
    [randstr release];
    
    NSLog(@"Date:::::::::%@", string);
    
    return string;
}


+(NSString *) md5TimeIDToRandFileName
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateStyle:NSDateFormatterMediumStyle];
    [dateFormatter setTimeStyle:NSDateFormatterShortStyle];
    [dateFormatter setDateFormat:@"yyMMddHHmmssSSSSSS"];
    
    // 时间字符串
    NSString *datestr = [dateFormatter stringFromDate:[NSDate date]];
    [dateFormatter release];
    
    
    const char *original_str = [datestr UTF8String];
    unsigned char result[CC_MD5_DIGEST_LENGTH];
    CC_MD5(original_str, strlen(original_str), result);
    NSMutableString *hash = [NSMutableString string];
    for (int i = 0; i < 8; i++)
        [hash appendFormat:@"%02X", result[i]];
    return [hash lowercaseString];
}

+ (void)setTabBarItemBadge:(UIViewController *)viewController :(NSString *)badgeValue
{
    [[viewController tabBarItem] setBadgeValue:badgeValue];
}

+ (CGRect)returnInputRectCopySize:(CGRect)rect
{
    return CGRectMake(0, 0, rect.size.width, rect.size.height);
}
@end
