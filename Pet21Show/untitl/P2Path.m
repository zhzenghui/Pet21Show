//
//  P2Path.m
//  Pet21Show
//
//  Created by zeng on 12-8-13.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2Path.h"

@implementation P2Path


+(NSString *)getDocumentPath:(NSString *)fileName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDirectory = [paths objectAtIndex:0];
	//--memory's delete
	//NSString *dbPath = [[NSString alloc] initWithFormat:@"%@/%@", documentsDirectory, dbName];
	//--memory's change
	NSString *dbPath = [[[NSString alloc] initWithFormat:@"%@/%@", documentsDirectory, fileName] autorelease];
	return dbPath;
}

+(NSString *)getPath:(NSString *)fileName
{
	return [[NSBundle mainBundle] pathForResource:fileName ofType:@""];;
}

@end
