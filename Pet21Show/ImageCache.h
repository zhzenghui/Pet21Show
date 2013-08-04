//
//  ImageCache.h
//  EiPhone
//
//  Created by zhang xu on 11-1-11.
//  Copyright 2011 encompass. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageCache : NSObject {

}

+ (UIImage*)loadImage:(NSString*)imageName;

+ (void)releaseCache;

@end
