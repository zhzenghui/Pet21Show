//
//  ImageUploader.m
//  EiPhone
//
//  Created by zhang xu on 10-9-10.
//  Copyright 2010 encompass. All rights reserved.
//

#import "ImageUploader.h"
#import "Session.h"

#import "EIPhoneDBCommand.h"

@implementation ImageUploader

@synthesize myDB;

- (id)init{
	
	if(self = [super init])
	{
		self.myDB = [FMDatabase databaseWithPath:[EIPhoneDBCommand getDatabasePath]]; 
		[self.myDB open];
	}
	
	return self;
}

- (void)dealloc{
	
	[self.myDB close];
	[self.myDB release];
	[super dealloc];
}

#pragma mark -

- (NSString *)addImage:(NSDictionary *)dict{
	
	NSString *fileName = [dict valueForKey:@"FileName"];
	NSString *desc = [dict valueForKey:@"DocumentDescription"];
	NSString *type = @"";//[dict valueForKey:@"ImageType"];
	NSString *subDir = @"Images";//[dict valueForKey:@"SubDir"];
	NSString *height = [dict valueForKey:@"Height"];
	NSString *width = [dict valueForKey:@"Width"];
	NSString *customerId = [dict valueForKey:@"CustomerID"];
	NSString *surveyAnswerID = [dict valueForKey:@"SurveyAnswerID"];
	NSString *taskID = [dict valueForKey:@"TaskID"];
	//need validate here
	//⋯⋯
	desc = [BC_Fmt FormatData:desc DataType:@"text" Length:50];
	desc = [desc stringByReplacingOccurrencesOfString:@"'" withString:@""];
	
	if ([desc length] > 50) {
		desc = [desc substringToIndex:50];
	}
	
	NSMutableString *SQL = [NSMutableString	string];
	
	[SQL appendString:@"INSERT INTO "];
	[SQL appendString:@"Documents "];
	
	if(surveyAnswerID != nil 
	   && ![surveyAnswerID isEqualToString:@""]){
		
		[SQL appendString:@"(FileName,DocumentDescription,DocumentType,SubDir,Height,Width,CustomerID,SurveyAnswerID) "];
		[SQL appendString:@"values "];
		[SQL appendFormat:@"('%@','%@','%@','%@', ", fileName, desc, type, subDir];
		[SQL appendFormat:@" %@ , %@ ,'%@','%d') ", height, width, customerId,[surveyAnswerID intValue]];
		
	}
	else if(taskID != nil && ![taskID isEqualToString:@""]){
		[SQL appendString:@"(FileName,DocumentDescription,DocumentType,SubDir,Height,Width,CustomerID,TaskID) "];
		[SQL appendString:@"values "];
		[SQL appendFormat:@"('%@','%@','%@','%@', ", fileName, desc, type, subDir];
		[SQL appendFormat:@" %@ , %@ ,'%@','%@') ", height, width, customerId,taskID];
		
	}
	else {
		
		[SQL appendString:@"(FileName,DocumentDescription,DocumentType,SubDir,Height,Width,CustomerID) "];
		[SQL appendString:@"values "];
		[SQL appendFormat:@"('%@','%@','%@','%@', ", fileName, desc, type, subDir];
		[SQL appendFormat:@" %@ , %@ ,'%@') ", height, width, customerId];
	}

	[myDB executeUpdate:SQL];
	
	NSString *reImageID = @"";
	[SQL setString:@"SELECT max(DocumentID) as NewDocumentID from Documents "];
	FMResultSet *rs = [myDB executeQuery:SQL];
	while ([rs next]) {
		
		reImageID = [rs stringForColumn:@"NewDocumentID"];
	}
	[rs close];
	
	if(taskID != nil && ![taskID isEqualToString:@""]){
		
		[Session setSession:@"TaskDetailContent" value:fileName];
	}
	
	return reImageID;
}

- (NSMutableArray *)getImagesByCustomerID:(NSString *)customerId AndSurveyAnswerID:(NSString*)surveyAnswerID{
	
	NSMutableString *SQL = [NSMutableString string];
	[SQL appendString:@"SELECT "];
	[SQL appendString:@"DocumentID,FileName,DocumentDescription,DocumentType,SubDir,Height,Width,CustomerID,SurveyAnswerID,TaskID "];
	[SQL appendString:@"FROM "];
	[SQL appendString:@"Documents "];
	[SQL appendFormat:@"WHERE CustomerID = %@ ",customerId];
	[SQL appendString:@" AND (TaskID is null OR TaskID = '')"];
	
	if(surveyAnswerID != nil 
	   && ![surveyAnswerID isEqualToString:@""]){

		[SQL appendString:@" AND SurveyAnswerID = "];
		[SQL appendFormat:@" '%@' ",surveyAnswerID];
	}
	else {
		[SQL appendString:@" AND (SurveyAnswerID is null OR SurveyAnswerID = '')"];
	}

	
	FMResultSet *rs = [myDB executeQuery:SQL];
	NSMutableArray *imgArr = [NSMutableArray array];
	while ([rs next]) 
	{
		NSMutableDictionary *dict = [NSMutableDictionary dictionary];
		[dict setValue:[rs stringForColumn:@"DocumentID"] forKey:@"DocumentID"];
		[dict setValue:[rs stringForColumn:@"FileName"] forKey:@"FileName"];
		[dict setValue:[rs stringForColumn:@"DocumentDescription"] forKey:@"DocumentDescription"];
		[dict setValue:[rs stringForColumn:@"DocumentType"] forKey:@"DocumentType"];
		[dict setValue:[rs stringForColumn:@"SubDir"] forKey:@"SubDir"];
		[dict setValue:[rs stringForColumn:@"Height"] forKey:@"Height"];
		[dict setValue:[rs stringForColumn:@"Width"] forKey:@"Width"];
		[dict setValue:[rs stringForColumn:@"CustomerID"] forKey:@"CustomerID"];
		[dict setValue:[rs stringForColumn:@"SurveyAnswerID"] forKey:@"SurveyAnswerID"];
		
		[imgArr addObject:dict];
	}
	[rs close];
	
	return imgArr;
}

- (void)deleteImageInImageArray:(NSArray *)imageArray {
	
	if([imageArray count] <= 0){
		return;
	}
	
	NSString *imageID = @"";
	NSString *surveyAnswerID = @"";
	
	for(NSDictionary *dict in imageArray){
		imageID = [dict valueForKey:@"DocumentID"];
		surveyAnswerID = [dict valueForKey:@"SurveyAnswerID"];
		
		[self deleteImageInImageID:imageID 
				 AndSurveyAnswerId:surveyAnswerID];
	}
}

- (void)deleteImageInImageID:(NSString *)imageId AndSurveyAnswerId:(NSString *)surveyAnswerId{
	
	if (imageId == nil || [imageId isEqualToString:@""]) {
		return;
	}
	
	NSMutableString *SQL = [[NSMutableString alloc] init];
	
	[SQL setString:@""];
	[SQL appendString:@"DELETE FROM Documents "];
	[SQL appendFormat:@"WHERE DocumentID = '%@'",imageId];
	[myDB executeUpdate:SQL];
	
	if(surveyAnswerId != nil 
	   && ![surveyAnswerId isEqualToString:@""]){
		[SQL setString:@""];
		[SQL appendString:@"UPDATE SurveyAnswers "];
		[SQL appendString:@"SET Answer = ( "];
		[SQL appendString:@"CASE WHEN "];
		[SQL appendString:@" Answer > 0 "];
		[SQL appendString:@"THEN Answer-1 "];
		[SQL appendString:@"ELSE 0 "];
		[SQL appendString:@"END "];
		[SQL appendFormat:@") "];
		[SQL appendString:@",Edited = -1 "];
		[SQL appendString:@"WHERE "];
		[SQL appendFormat:@"SurveyAnswerID = '%@'",surveyAnswerId];
		[myDB executeUpdate:SQL];
	}
	
	[SQL release];
}

- (void)updateImage:(NSString *)imageId desc:(NSString *)desc{

/*	if ([desc length] > 50) {
		desc = [desc substringToIndex:50];
	}
*/	

	desc = [BC_Fmt FormatData:desc DataType:@"text" Length:50];
	desc = [desc stringByReplacingOccurrencesOfString:@"'" withString:@""];
	
	if ([desc length] > 50) {
		desc = [desc substringToIndex:50];
	}
	
	NSMutableString *SQL = [NSMutableString string];
	[SQL appendString:@"UPDATE Documents "];
	[SQL appendFormat:@"SET DocumentDescription = '%@' ",desc];
	[SQL appendString:@"WHERE "];
	[SQL appendFormat:@"DocumentID = %@ ",imageId];
	
	[myDB executeUpdate:SQL];
}


@end
