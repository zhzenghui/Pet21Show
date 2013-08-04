//
//  ImageCache.m
//  EiPhone
//
//  Created by zhang xu on 11-1-11.
//  Copyright 2011 encompass. All rights reserved.
//

#import "ImageCache.h"


@implementation ImageCache

static NSMutableDictionary *imageCacheDict;

+ (UIImage*)loadImage:(NSString*)imageName {
	
	if (!imageCacheDict) imageCacheDict = [[NSMutableDictionary dictionary] retain];
	
	UIImage* image = [imageCacheDict objectForKey:imageName]; 
	if (!image) {
		NSString* imagePath = [[NSBundle mainBundle] pathForResource:imageName ofType:@"png"];
		image = [UIImage imageWithContentsOfFile:imagePath]; 
		if (image) {
			[imageCacheDict setObject:image forKey:imageName];
		}
	}
	
	return image;
}
+ (void)releaseCache { 
	
	if (imageCacheDict) {
		[imageCacheDict removeAllObjects];
	}
}
@end
