//
//  Directory.m
//  LifeLine
//
//  Created by zeng on 12-9-1.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "Directory.h"

@implementation Directory

+ (NSString *)Documents
{
    
    NSMutableString *dir = [NSMutableString string];
	[dir appendString:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/"]];
    return dir;
}

+ (NSString *)createDcumentDic:(NSString *)dictName
{
    NSString *path = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:dictName];
    BOOL bo = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:nil];
    NSAssert(bo,@"创建目录失败");
    
    NSString *result = [path stringByAppendingPathComponent:dictName];
    
    return result;
}


+ (BOOL)fileExistsAtPath: (NSString *)fileName
{
    
    NSFileManager *file_manager = [NSFileManager defaultManager];
    return [file_manager fileExistsAtPath:fileName];
}
@end
