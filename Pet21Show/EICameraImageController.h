	//
	//  CameraImageController.h
	//  PhotoUploader
	//
	//  Created by 张 增超 on 10-9-15.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import <UIKit/UIKit.h>
#import "EICameraController.h"



#define ViewType_Task 1004

@interface EICameraImageController : UIViewController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate,EICameraControllerDelegate>{
	
	IBOutlet UIToolbar *toolBar;
	IBOutlet UIImageView *imageView;
	UIBarButtonItem *descriptionBarButton;
	UIBarButtonItem *deleteBarButton;
	UIBarButtonItem *newImageButton;
	
	UIImagePickerController *imagePickerController;
	
	BOOL showCamera;
	NSUInteger viewType;
	NSString *surveyAnswerId;
	NSMutableDictionary *curImageInfoDict;
	NSString *taskID;
	NSString *customerID;
}

@property (nonatomic,retain) UIToolbar *toolBar;
@property (nonatomic,retain) UIImageView *imageView;
@property (nonatomic,retain) UIImagePickerController *imagePickerController;


@property (nonatomic,retain) UIBarButtonItem *descriptionBarButton;
@property (nonatomic,retain) UIBarButtonItem *deleteBarButton;
@property (nonatomic,retain) UIBarButtonItem *newImageButton;

@property (nonatomic) BOOL showCamera;
@property (nonatomic) NSUInteger viewType;
@property (nonatomic ,retain) NSString *surveyAnswerId;
@property (nonatomic,retain) NSMutableDictionary *curImageInfoDict;
@property (nonatomic,retain) NSString *taskID;
@property (nonatomic,retain) NSString *customerID;


-(void)backToThumbImage:(id)sender;
-(void)addDescription:(id)sender;
-(void)deleteCurrentImage:(id)sender;
-(void)newPhoto:(id)sender;
-(void)savePhoto:(id)sender;
- (void)takePhoto:(id)sender;
- (void)cancelCamera:(id)sender;

@end
