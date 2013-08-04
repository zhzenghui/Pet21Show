//
//  Directory.h
//  LifeLine
//
//  Created by zeng on 12-9-1.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Directory : NSObject

+ (NSString *)Documents;

+ (NSString *)createDcumentDic:(NSString *)dictName;

+ (BOOL)fileExistsAtPath: (NSString *)fileName;
@end
