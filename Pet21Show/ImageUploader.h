//
//  ImageUploader.h
//  EiPhone
//
//  Created by zhang xu on 10-9-10.
//  Copyright 2010 encompass. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDatabase.h"
#import "FMResultSet.h"
#import "Fmt.h"

@interface ImageUploader : NSObject {

	FMDatabase *myDB;
}

@property (nonatomic,retain) FMDatabase *myDB;

- (NSString *)addImage:(NSDictionary *)dict;

- (NSMutableArray *)getImagesByCustomerID:(NSString *)customerId AndSurveyAnswerID:(NSString*)surveyAnswerID;

- (void)deleteImageInImageID:(NSString *)imageId AndSurveyAnswerId:(NSString *)surveyAnswerId;

- (void)deleteImageInImageArray:(NSArray *)imageArray;

- (void)updateImage:(NSString *)imageId desc:(NSString *)desc;

@end
