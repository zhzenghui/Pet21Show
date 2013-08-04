//
//  ArtOnline.h
//  Artvotary
//
//  Created by zeng on 12-11-1.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Model.h"

@interface ArtOnline : Model


- (BOOL)addArtOnline:(NSDictionary *)artOnline;
- (NSMutableArray *)getArtOnlineArr;
@end
