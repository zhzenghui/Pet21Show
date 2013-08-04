//
//  Model.h
//  Artvotary
//
//  Created by zeng on 12-11-1.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "Common.h"

@interface Model : NSObject
{
    FMDatabase *myDB;
}


@property (nonatomic,assign) int *isTmp;
@property (nonatomic,retain) FMDatabase *myDB;
@end
