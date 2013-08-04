//
//  Model.m
//  Artvotary
//
//  Created by zeng on 12-11-1.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "Model.h"

@implementation Model
@synthesize myDB;
@synthesize isTmp;

-(id)init
{
    self = [super init];
    if(self)
    {
        if (isTmp) {
            self.myDB = [FMDatabase  databaseWithPath:[EIPhoneDBCommand getTmpDatabasePath]];
        }
        else {
            self.myDB = [FMDatabase  databaseWithPath:[EIPhoneDBCommand getDatabasePath]];
        }
        [self.myDB open];
    }
    
    return self;
}

-(void)dealloc
{
    [self.myDB close];
    [self.myDB release];
    [super dealloc];
}
@end
