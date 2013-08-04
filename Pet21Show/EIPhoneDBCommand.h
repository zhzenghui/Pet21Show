//
//  EIPhoneDBCommand.h
//  EiPhone
//
//  Created by zeus on 11/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"


@interface EIPhoneDBCommand : NSObject {

}
+ (FMDatabase *)eIphoneDB;
+ (NSString *)getDatabasePath;
+ (NSString *)getCompressedDatabasePath;
+ (NSString *)getSettingsDatabasePath;
+ (NSString *)getPath:(NSString *)dbName;
+ (NSString *)getRecordsetStr:(NSString *)tableName SQL:(NSString *)SQL;
+ (NSString *)getTmpDatabasePath;
+ (NSString *)GetLocalTableIDList:(NSString *)tableName fieldName:(NSString *)fieldName;

@end
