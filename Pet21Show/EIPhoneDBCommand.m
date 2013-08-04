//
//  EIPhoneDBCommand.m
//  EiPhone
//
//  Created by zeus on 11/2/09.
//  Copyright 2009 __MyCompanyName__. All rights reserved.
//

#import "EIPhoneDBCommand.h"
#import "Common.h"

@implementation EIPhoneDBCommand

+ (FMDatabase *)eIphoneDB
{
	FMDatabase *myDB = [FMDatabase databaseWithPath:[EIPhoneDBCommand getDatabasePath]];
	return myDB; 
}

+(NSString *)getDatabasePath
{
	return [EIPhoneDBCommand getPath:@"art.db"];
}

+(NSString *)getTmpDatabasePath
{
	return [EIPhoneDBCommand getPath:@"art_tmp.db"];
}

+(NSString *)getCompressedDatabasePath
{
	return [EIPhoneDBCommand getPath:@"artCompressed.db"];
}

+(NSString *)getSettingsDatabasePath
{	
	return [EIPhoneDBCommand getPath:@"EiPhoneDB.SQL"];
}

+(NSString *)getPath:(NSString *)dbName
{
	NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
	NSString *documentsDirectory = [paths objectAtIndex:0]; 
	//--memory's delete
	//NSString *dbPath = [[NSString alloc] initWithFormat:@"%@/%@", documentsDirectory, dbName];
	//--memory's change
	NSString *dbPath = [[[NSString alloc] initWithFormat:@"%@/%@", documentsDirectory, dbName] autorelease];
	return dbPath;
}

+(NSString *)getRecordsetStr:(NSString *)tableName SQL:(NSString *)SQL
{
	NSMutableString *resultVal = [[[NSMutableString alloc] init] autorelease];
	FMDatabase *myDB = [EIPhoneDBCommand eIphoneDB];
	int recordCount = 0;
	
	if([myDB open])
	{
		FMResultSet *rs = [myDB executeQuery:SQL];
		int columnCount = [rs count];
		[resultVal appendString: tableName];
		[resultVal appendString: strSplitRow];		
		
		if(columnCount > 0)
		{
			NSMutableDictionary *columns = [rs columns];		
			NSArray *arrKeys = [columns allKeys];
			
			for(int i = [arrKeys count] - 1; i > -1 ; i--)
			{
				if(i != [arrKeys count] - 1)
				{
					[resultVal appendString: strSplitCol];
					//resultVal = [resultVal stringByAppendingString: [[arrKeys objectAtIndex:i] stringValue]];
					resultVal = [NSMutableString stringWithFormat:@"%@%@", resultVal, [arrKeys objectAtIndex:i]];
				}
				else
				{
					resultVal = [NSMutableString stringWithFormat:@"%@%@", resultVal, [arrKeys objectAtIndex:i]];
				}				
			}
			
			[resultVal appendString: strSplitRow];			
			
			while([rs next])
			{
				for(int i = [arrKeys count] - 1; i > -1 ; i--)
				{
					if(i != [arrKeys count] - 1)
					{
						[resultVal appendString: strSplitCol];
						[resultVal appendString: [rs stringForColumn:[arrKeys objectAtIndex:i]]];
					}
					else
					{
						[resultVal appendString: [rs stringForColumn:[arrKeys objectAtIndex:i]]];
					}					
				}				
				[resultVal appendString: strSplitRow];
				
				recordCount ++;
			}
			[resultVal appendString: strSplitTable];
		}
		[rs close];
		[myDB close];
	}
	else
	{
		[resultVal setString: @""];
	}
	
	if(recordCount < 1)
	{
		[resultVal setString: @""];
	}	
	
	return resultVal;
}

/*
 
 +(NSString *)getRecordsetStr:(NSString *)tableName SQL:(NSString *)SQL
 {
 NSString *resultVal = @"";
 FMDatabase *myDB = [EIPhoneDBCommand eIphoneDB];
 int recordCount = 0;
 
 if([myDB open])
 {
 FMResultSet *rs = [myDB executeQuery:SQL];
 int columnCount = [rs count];
 resultVal = tableName;
 resultVal = [resultVal stringByAppendingString: strSplitRow];		
 
 if(columnCount > 0)
 {
 NSMutableDictionary *columns = [rs columns];		
 NSArray *arrKeys = [columns allKeys];
 
 for(int i = [arrKeys count] - 1; i > -1 ; i--)
 {
 if(i != [arrKeys count] - 1)
 {
 resultVal = [resultVal stringByAppendingString: strSplitCol];
 //resultVal = [resultVal stringByAppendingString: [[arrKeys objectAtIndex:i] stringValue]];
 resultVal = [NSString stringWithFormat:@"%@%@", resultVal, [arrKeys objectAtIndex:i]];
 }
 else
 {
 resultVal = [NSString stringWithFormat:@"%@%@", resultVal, [arrKeys objectAtIndex:i]];
 }				
 }
 
 resultVal = [resultVal stringByAppendingString: strSplitRow];			
 
 while([rs next])
 {
 for(int i = [arrKeys count] - 1; i > -1 ; i--)
 {
 if(i != [arrKeys count] - 1)
 {
 resultVal = [resultVal stringByAppendingString: strSplitCol];
 resultVal = [resultVal stringByAppendingString: [rs stringForColumn:[arrKeys objectAtIndex:i]]];
 }
 else
 {
 resultVal = [resultVal stringByAppendingString: [rs stringForColumn:[arrKeys objectAtIndex:i]]];
 }					
 }				
 resultVal = [resultVal stringByAppendingString: strSplitRow];
 
 recordCount ++;
 }
 resultVal = [resultVal stringByAppendingString: strSplitTable];
 }
 [rs close];
 [myDB close];
 }
 else
 {
 resultVal = @"";
 }
 
 if(recordCount < 1)
 {
 resultVal = @"";
 }	
 
 return resultVal;
 }
 
 
 */

+(NSString *)GetLocalTableIDList:(NSString *)tableName fieldName:(NSString *)fieldName
{
	NSString *SQL = @"";
	NSString *result = [NSString stringWithFormat:@"%@%@",tableName, strSplitCol];
	
	FMDatabase *myDB = [EIPhoneDBCommand eIphoneDB];	
	if([myDB open])
	{
		SQL = [NSString stringWithFormat:@"SELECT %@ FROM %@", fieldName, tableName];	
		FMResultSet *rs = [myDB executeQuery:SQL];
		
		while([rs next])
		{
			result = [NSString stringWithFormat:@"%@%@%@", result , [rs stringForColumn:fieldName], strSplitCol];
		}
		
		[rs close];
		[myDB close];
	}
	return result;
}

@end
