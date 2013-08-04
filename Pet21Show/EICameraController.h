//
//  CameraController.h
//  PhotoUploader
//
//  Created by 张 增超 on 10-9-2.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//
#import <QuartzCore/QuartzCore.h>
#import <CoreGraphics/CoreGraphics.h>

@protocol EICameraControllerDelegate;

@interface EICameraController : UIViewController <UIImagePickerControllerDelegate,UINavigationControllerDelegate>{

	id <EICameraControllerDelegate> delegate;
	
	UIImagePickerController *imagePickerController;
	UIToolbar *toolBar;
	
	UIBarButtonItem *takeBarItem;
}

@property (nonatomic, assign) id <EICameraControllerDelegate> delegate;
@property (nonatomic, retain) UIImagePickerController *imagePickerController;
@property (nonatomic, retain) UIToolbar *toolBar;
@property (nonatomic, retain) UIBarButtonItem *takeBarItem;

- (IBAction)takePhoto:(id)sender;
- (IBAction)cancelCamera:(id)sender;
- (void)setupCamera;
@end

@protocol EICameraControllerDelegate

- (void)didTakePicture:(UIImage *)image orientation:(UIDeviceOrientation)orientation;
- (void)didFinishWithCamera;
- (void)showImagePicker;

@end

