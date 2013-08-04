//
//  EICrashHandler.h
//  EiPhone
//
//  Created by 张 增超 on 10-12-7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EICrashHandler : NSObject{
	
	NSMutableArray *crashFiles;
	NSMutableString *crashesDir;
}

+ (EICrashHandler *)crashHandler;
- (void)saveCrashesData;
 
@end
