//
//  ImageUploaderUtil.m
//  PhotoUploader
//
//  Created by 张 增超 on 10-9-8.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ImageUploaderUtil.h"


@implementation ImageUploaderUtil

+ (float)thumbWidth{

	return 75.0f;
}

+ (float)thumb2Width{

	return 320.0f;
}

+ (float)thumb2Height{
	
	return 416.0f;
}

+ (float)thumb2Height2{

	return 246.0f;
}

+ (NSString *)bigThumb{

	NSMutableString *path = [NSMutableString string];
	[path appendString:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ImagesForUpload"]];
	return [path stringByAppendingString:@"/"];
}

+ (NSString *)thumbPath{
	
	NSMutableString *path = [NSMutableString string];
	[path appendString:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/ImagesForUpload/thumbs/"]];
	return [path stringByAppendingString:@"/"];
}



+ (void)createImageFolderIfNotExsit{
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	/*
	if (![fileManager fileExistsAtPath:[ImageUploaderUtil sourcePath]]) {
		[fileManager createDirectoryAtPath:[ImageUploaderUtil sourcePath] withIntermediateDirectories:YES attributes:nil error:nil];
	}*/
	
	if (![fileManager fileExistsAtPath:[ImageUploaderUtil thumbPath]]) {
		[fileManager createDirectoryAtPath:[ImageUploaderUtil thumbPath] withIntermediateDirectories:YES attributes:nil error:nil];
	}
	
	if (![fileManager fileExistsAtPath:[ImageUploaderUtil bigThumb]]) {
		[fileManager createDirectoryAtPath:[ImageUploaderUtil bigThumb] withIntermediateDirectories:YES attributes:nil error:nil];
	}
}

+ (void)createThumbImage:(UIImage *)image size:(CGSize )thumbSize percent:(float)percent toPath:(NSString *)thumbPath{

	CGSize imageSize = image.size;
	CGFloat width = imageSize.width;
	CGFloat height = imageSize.height;

	CGFloat scaleFactor = 0.0;
	CGPoint thumbPoint = CGPointMake(0.0,0.0); 
	
	CGFloat widthFactor = thumbSize.width / width;  
	CGFloat heightFactor = thumbSize.height / height;  
	if (widthFactor > heightFactor)  { 
		scaleFactor = widthFactor;
	} 
	else {
		scaleFactor = heightFactor; 
	}
	CGFloat scaledWidth  = width * scaleFactor;  
	CGFloat scaledHeight = height * scaleFactor;
	if (widthFactor > heightFactor)  
	{  
		thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;   
	}  
	else if (widthFactor < heightFactor)  
	{  
		thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;  
	}  

	UIGraphicsBeginImageContext(thumbSize);  
	CGRect thumbRect = CGRectZero;  
	thumbRect.origin = thumbPoint;
	thumbRect.size.width  = scaledWidth;  
	thumbRect.size.height = scaledHeight;
	[image drawInRect:thumbRect]; 
	
	UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	 
	NSData *thumbImageData = UIImageJPEGRepresentation(thumbImage, percent);
	[thumbImageData writeToFile:thumbPath atomically:NO];
}


@end
