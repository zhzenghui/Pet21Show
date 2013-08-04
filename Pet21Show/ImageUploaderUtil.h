//
//  ImageUploaderUtil.h
//  PhotoUploader
//
//  Created by 张 增超 on 10-9-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ImageUploaderUtil : NSObject {

}

+ (float)thumbWidth;

+ (float)thumb2Width;
+ (float)thumb2Height;
+ (float)thumb2Height2;//--used when ImageOrientationLeft or ImageOrientationRight 

+ (NSString *)thumbPath; //images for upload
+ (NSString *)bigThumb;//thumbnails

+ (void)createImageFolderIfNotExsit;
+ (void)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath;


@end
