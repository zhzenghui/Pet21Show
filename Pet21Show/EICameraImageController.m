    //
	//  CameraImageController.m
	//  PhotoUploader
	//
	//  Created by 张 增超 on 10-9-15.
	//  Copyright 2010 __MyCompanyName__. All rights reserved.
	//

#import "ImageUploader.h"
#import "Common.h"
#import "Session.h"
#import "ImageUploaderUtil.h"

#import "EICameraImageController.h"
//#import "EIImageController.h"
//#import "EIImageInfoController.h"

@implementation EICameraImageController

@synthesize toolBar;
@synthesize imageView;

@synthesize imagePickerController;
@synthesize descriptionBarButton;
@synthesize deleteBarButton;
@synthesize newImageButton;

@synthesize showCamera;
@synthesize viewType;
@synthesize surveyAnswerId;
@synthesize curImageInfoDict;
@synthesize taskID;
@synthesize customerID;

- (void)dealloc {
	
	[[NSNotificationCenter defaultCenter] removeObserver:self];
	
	[surveyAnswerId release];
	[toolBar release];
	[imageView release];
	[imagePickerController release];
	[descriptionBarButton release];
	[deleteBarButton release];
	[newImageButton release];
	[curImageInfoDict release];
	[taskID release];
	[customerID release];
    [super dealloc];
}

- (void)viewDidLoad {
	
	[super viewDidLoad];
	[self.view setBackgroundColor:[UIColor blackColor]];
	
//	if(viewType != ViewType_Survey && viewType != ViewType_Task){
//		UIBarButtonItem *albumButton = [[UIBarButtonItem alloc]initWithTitle:EILocalizedString(@"Album") style:UIBarButtonItemStyleBordered target:self action:@selector(backToThumbImage:)];
//		self.navigationItem.leftBarButtonItem = albumButton;
//		[albumButton release];
//	}
	
	UIBarButtonItem *backBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStyleBordered target:self action:@selector(back:)];
	self.navigationItem.rightBarButtonItem = backBarButtonItem;
	[backBarButtonItem release];
	
	
	if (heldhand == EIHeldHandLeft ) {
		UIBarButtonItem *rightBarButtonItem = [self.navigationItem.rightBarButtonItem retain];
		self.navigationItem.rightBarButtonItem = self.navigationItem.leftBarButtonItem;
		self.navigationItem.leftBarButtonItem = rightBarButtonItem;
		[rightBarButtonItem release];
	}
	/* Create Image Folder */
	[ImageUploaderUtil createImageFolderIfNotExsit];
	
	if (viewType != ViewType_Task) {
		descriptionBarButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Memo", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(addDescription:)];
		deleteBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemTrash target:self action:@selector(deleteCurrentImage:)];
		newImageButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Save/New", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(newPhoto:)];
		UIBarButtonItem *fixedSpaceBarLeft = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
		UIBarButtonItem *fixedSpaceBarRight = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:self action:nil];
		
		[self.toolBar setItems:[NSMutableArray arrayWithObjects:descriptionBarButton,fixedSpaceBarLeft,newImageButton,fixedSpaceBarRight,deleteBarButton,nil]];
		[fixedSpaceBarLeft release];
		[fixedSpaceBarRight release];
	}
	
	if (self.imagePickerController == nil) {
		self.imagePickerController = [[[UIImagePickerController alloc] init] autorelease];
		self.imagePickerController.delegate = self;
		self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
		self.imagePickerController.videoQuality = UIImagePickerControllerQualityTypeLow;
		self.imagePickerController.showsCameraControls = NO;
		self.imagePickerController.allowsEditing = YES; 
		
		UIToolbar* overlayViewToolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0.0, 426, 320, 54)];
		overlayViewToolBar.barStyle = UIBarStyleDefault;
		[overlayViewToolBar setTranslucent:YES];
		
		
		UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc]initWithTitle:NSLocalizedString(@"Cancel", @"") style:UIBarButtonItemStyleBordered target:self action:@selector(cancelCamera:)];
		
		UIBarButtonItem *fixedBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
		fixedBarButton.width = 65 ;
		UIBarButtonItem* takeBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto:)];	
		[overlayViewToolBar setItems:[NSMutableArray arrayWithObjects:cancelBarButton,fixedBarButton,takeBarItem,nil]];
		
		[self.imagePickerController.cameraOverlayView addSubview:overlayViewToolBar];
		[overlayViewToolBar release];
		[takeBarItem release];
		[cancelBarButton release];
		[fixedBarButton release];
	}
	
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(cancelCamera:) name:UIApplicationWillResignActiveNotification object:nil];
}

-(void)viewWillAppear:(BOOL)animated{
	[super viewWillAppear:animated];
	if (viewType != ViewType_Task) {
		
		self.navigationController.navigationBar.barStyle = UIStatusBarStyleDefault;
		[self.navigationController.navigationBar setTranslucent:YES];
		[[UIApplication sharedApplication] setStatusBarHidden:NO 
												withAnimation:UIStatusBarAnimationNone];
	}
	else {
		[self.toolBar setHidden:YES];
		self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
		[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
		[self.navigationController.navigationBar setTranslucent:NO];
		[[UIApplication sharedApplication] setStatusBarHidden:NO 
												withAnimation:UIStatusBarAnimationNone];
		
		[self.imageView setFrame:CGRectMake(0, 0, 320, 416)];
	}
}

-(void)viewDidAppear:(BOOL)animated{
	
//	if(viewType == ViewType_ImageNav || viewType == ViewType_Survey || viewType == ViewType_Task){
//		
//		if ([[Session getSession:@"EICameraImageViewAutoBackToRoot"] isEqualToString:@"cancelCamera"]) {
//			[self.navigationController popViewControllerAnimated:YES];
//			[Session setSession:@"EICameraImageViewAutoBackToRoot" value:@""];
//		}
//		
//		if([[Session getSession:@"ImageControllerAutoBackToRootNav"]isEqualToString:@"backAtLayerFive"]){
//			
//			[self.navigationController popViewControllerAnimated:YES];
//			[Session setSession:@"ImageControllerAutoBackToRootNav" value:@""];
//		}
//		
//		
//		if (showCamera) {
//			[self showImagePicker];
//			showCamera = NO;
//		}
//		else {
//			/* after take pic */
//			[[[UIApplication sharedApplication] keyWindow] setRootViewController:self];
//		}
//	}
//	else if(viewType == ViewType_NewSurvey){
//		
//		[Session setSession:@"ImageControllerAutoBackToRootNav" value:@""];
//		[Session setSession:@"EICameraImageViewAutoBackToRoot" value:@""];
//		if (showCamera) {
//			[self showImagePicker];
//			showCamera = NO;
//		}
//		else {
//			/* after take pic */
//			[[[UIApplication sharedApplication] keyWindow] setRootViewController:self];
//		}
//	}
}

#pragma mark -
#pragma mark BarButtonMethods

- (void)takePhoto:(id)sender {
	[self.imagePickerController takePicture];
}

- (void)cancelCamera:(id)sender{
	
	[self.imagePickerController dismissModalViewControllerAnimated:YES];
	[Session setSession:@"TaskDetailContent" value:@""];
	[self.navigationController popViewControllerAnimated:YES];
}

- (void)showImagePicker{
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera])
    {
		[self.navigationController presentModalViewController:self.imagePickerController animated:YES];
		
		/*
		 [self.cameraController setupCamera];
		 self.cameraController.delegate = self;
		 [[[UIApplication sharedApplication] keyWindow] setRootViewController:self.cameraController.imagePickerController];
		 [self presentModalViewController:self.cameraController.imagePickerController animated:YES];
		 */
	}
}

-(void)backToThumbImage:(id)sender{
	
	[Session setSession:@"ImageControllerAutoBackToRootNav" value:@"enterAtFour"];
//	EIImageController *imageController = [[EIImageController alloc] initWithNibName:@"EIImageView" bundle:nil];
//	imageController.viewType = self.viewType;
//	imageController.surveyAnswerId = self.surveyAnswerId;
//	[self.navigationController pushViewController:imageController animated:YES];
//	[imageController release];
}

-(void)addDescription:(id)sender{
	
//	EIImageInfoController *imageInfo = [[EIImageInfoController alloc] initWithNibName:@"EIImageInfoView" bundle:nil];
//	imageInfo.imageInfoDict = curImageInfoDict;
//	UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:imageInfo];
//	[self presentModalViewController:navController animated:YES];
//	[imageInfo release];
//	[navController release];
	
}

-(void)deleteCurrentImage:(id)sender{
	
	UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil 
												   message:NSLocalizedString(@"This picture will be deleted.", @"")
												  delegate:self 
										 cancelButtonTitle:@"cancle"
										 otherButtonTitles:@"continue",nil];
	[alert show];
	[alert release];
	
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
		//--delete logical code here
	if (buttonIndex == 1) {
		
		ImageUploader *myImageUploader = [[ImageUploader alloc] init];
		
		[myImageUploader deleteImageInImageID:[curImageInfoDict valueForKey:@"DocumentID"] 
							AndSurveyAnswerId:[curImageInfoDict valueForKey:@"SurveyAnswerID"]];
		
		[myImageUploader release];
		
		NSString *thumbPath = [curImageInfoDict valueForKey:@"thumbPath"];
		NSString *bigThumbPath = [curImageInfoDict valueForKey:@"bigThumb"];
		NSFileManager *fileManager = [NSFileManager defaultManager];
		[fileManager setDelegate:self];
		
		if([fileManager fileExistsAtPath:thumbPath]) {
			[fileManager removeItemAtPath:thumbPath 
									error:nil];
		}
		
		if([fileManager fileExistsAtPath:bigThumbPath]){
			[fileManager removeItemAtPath:bigThumbPath 
									error:nil];
		}
		
		[fileManager setDelegate:nil];
		self.curImageInfoDict = [NSMutableDictionary dictionary];
		self.imageView.image = nil;
		
			//--take new pic
		[self performSelector:@selector(showImagePicker) 
				   withObject:nil 
				   afterDelay:0.2];
	}
}

-(void)newPhoto:(id)sender{
	
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSArray *fileNum = [fileManager subpathsAtPath:[ImageUploaderUtil thumbPath]];
	
	if ([fileNum count] <= 99) {
		
		[self showImagePicker];
	}
	else {
		UIAlertView *alert = [[UIAlertView alloc]initWithTitle:nil 
													   message:NSLocalizedString(@"You have taken 100 pictures,please sync with server.", @"")
													  delegate:self 
											 cancelButtonTitle:@"OK"
											 otherButtonTitles:nil];
		[alert show];
		[alert release];
		
	}
}

-(void)back:(id)sender{
	
	[self.navigationController popViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark UIImagePickerControllerDelegate Method

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	
	UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
	
	[self didTakePicture:image imageOrientation:image.imageOrientation deviceOrientation:[[UIDevice currentDevice]orientation]];
	[self didFinishWithCamera];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissModalViewControllerAnimated:YES];
}


#pragma mark -
#pragma mark NSFileManagerDelegate Methods

- (BOOL)fileManager:(NSFileManager *)fileManager shouldRemoveItemAtPath:(NSString *)path{
	return YES;
}

#pragma mark -
#pragma mark CameraControllerDelegate Methods

- (void)didTakePicture:(UIImage *)image imageOrientation:(UIImageOrientation)imgOrientation deviceOrientation:(UIDeviceOrientation)devOrientation{
		//	self.imageView.image = image;
	
	float originWidth = 320.0f;
	float originHeight = 416.0f;
	
	/*
	 orientation = UIDeviceOrientationPortrait;
	 self.imageView.frame = CGRectMake(0.0, 0.0, originWidth, 416.0f);
	 */
	
	if (imgOrientation == UIImageOrientationLeft
		|| imgOrientation == UIImageOrientationRight 
		|| devOrientation == UIDeviceOrientationUnknown 
		|| devOrientation == UIDeviceOrientationPortrait
		|| devOrientation == UIDeviceOrientationPortraitUpsideDown
		|| devOrientation == UIDeviceOrientationFaceDown) {
		
		self.imageView.frame = CGRectMake(0.0, 0.0, originWidth, 416.0f);
	}
	else {
		
		self.imageView.frame = CGRectMake(0.0f,
										  (originHeight - [ImageUploaderUtil thumb2Height2]) / 2,
										  originWidth, 
										  [ImageUploaderUtil thumb2Height2]);
	}
	
	
		//image name
	NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSTimeInterval a =[date timeIntervalSince1970]*1000;
    NSString *name = [NSString stringWithFormat:@"%f", a];
	NSString *fileName = [[name substringToIndex:13] stringByAppendingString:@".jpg"];
	
	NSString *bigThumb = [[ImageUploaderUtil bigThumb] stringByAppendingString:fileName];
	if (imgOrientation == UIImageOrientationLeft
		|| imgOrientation == UIImageOrientationRight 
		|| devOrientation == UIDeviceOrientationUnknown 
		|| devOrientation == UIDeviceOrientationPortrait
		|| devOrientation == UIDeviceOrientationPortraitUpsideDown
		|| devOrientation == UIDeviceOrientationFaceDown) {
		
		[ImageUploaderUtil createThumbImage:image size:CGSizeMake([ImageUploaderUtil thumb2Width], [ImageUploaderUtil thumb2Height]) percent:0.8 toPath:bigThumb];
	}
	else {
		[ImageUploaderUtil createThumbImage:image size:CGSizeMake([ImageUploaderUtil thumb2Width], [ImageUploaderUtil thumb2Height2]) percent:0.8 toPath:bigThumb];
	}
	
	self.imageView.image = [[[UIImage alloc] initWithContentsOfFile:bigThumb] autorelease];
	
	NSMutableDictionary *dict = [NSMutableDictionary dictionary];
	[dict setObject:[NSString stringWithFormat:@"%@",bigThumb] forKey:@"ImagePath"];
	[dict setValue:fileName forKey:@"FileName"];
	[dict setObject:[NSString stringWithFormat:@"%d",imgOrientation] forKey:@"imgOrientation"];
	[dict setObject:[NSString stringWithFormat:@"%d",devOrientation] forKey:@"devOrientation"];
	
		//	[self performSelector:@selector(savePhoto:) withObject:dict afterDelay:1.0];
	[self savePhoto:dict];
	
}

- (void)didFinishWithCamera{
	
    [self dismissModalViewControllerAnimated:YES];
}

#pragma mark Customer Methods

- (void)savePhoto:(id)sender{
	
	NSMutableDictionary *dict = (NSMutableDictionary *)sender;
	UIImage *image = self.imageView.image;
	NSString *fileName = [dict valueForKey:@"FileName"];
	UIImageOrientation imgOrientation = [[dict objectForKey:@"imgOrientation"] intValue];
	UIDeviceOrientation devOrientation = [[dict objectForKey:@"devOrientation"] intValue];
	
		//thumb
	NSString *thumbPath = [[ImageUploaderUtil thumbPath] stringByAppendingString:fileName];
	[ImageUploaderUtil createThumbImage:image size:CGSizeMake([ImageUploaderUtil thumbWidth], [ImageUploaderUtil thumbWidth]) percent:0.5 toPath:thumbPath];
	
		//save info to db
	NSMutableDictionary *saveDataDict = [NSMutableDictionary dictionary];
	[saveDataDict setValue:fileName forKey:@"FileName"];
	[saveDataDict setValue:@"" forKey:@"DocumentDescription"];
	
	if (imgOrientation == UIImageOrientationLeft
		|| imgOrientation == UIImageOrientationRight 
		|| devOrientation == UIDeviceOrientationUnknown 
		|| devOrientation == UIDeviceOrientationPortrait
		|| devOrientation == UIDeviceOrientationPortraitUpsideDown
		|| devOrientation == UIDeviceOrientationFaceDown) {
		
		[saveDataDict setValue:[NSString stringWithFormat:@"%.0f",320.0] forKey:@"Width"];
		[saveDataDict setValue:[NSString stringWithFormat:@"%.0f",416.0] forKey:@"Height"];
	}
	else{
		[saveDataDict setValue:[NSString stringWithFormat:@"%.0f",320.0] forKey:@"Width"];
		[saveDataDict setValue:[NSString stringWithFormat:@"%.0f",246.0] forKey:@"Height"];
	}
	[saveDataDict setValue:[Session getSession:@"CustomerID"] forKey:@"CustomerID"];
	
	if(surveyAnswerId == nil 
	   || [surveyAnswerId isEqualToString:@""]){
		surveyAnswerId = @"";
	}
	
	if (taskID == nil || [taskID isEqualToString:@""]) {
		taskID = @"";
	}
	
	[saveDataDict setValue:surveyAnswerId forKey:@"SurveyAnswerID"];
	[saveDataDict setValue:taskID forKey:@"TaskID"];
	if (taskID != nil && ![taskID isEqualToString:@""]) {
		[saveDataDict setValue:customerID forKey:@"CustomerID"];
	}
	ImageUploader *myImageUploader = [[ImageUploader alloc] init];
	NSString *curImageID = [myImageUploader addImage:saveDataDict];
	[myImageUploader release];
	
	NSMutableDictionary *dictionary = [NSMutableDictionary dictionary];
	[dictionary setValue:curImageID forKey:@"DocumentID"];
		//[dictionary setObject:image forKey:@"Image"];
	[dictionary setValue:surveyAnswerId forKey:@"SurveyAnswerID"];
	[dictionary setValue:taskID forKey:@"TaskID"];
	[dictionary setValue:fileName forKey:@"FileName"];
	[dictionary setValue:[[ImageUploaderUtil thumbPath] stringByAppendingString:fileName] forKey:@"thumbPath"];
	[dictionary setValue:[[ImageUploaderUtil bigThumb] stringByAppendingString:fileName] forKey:@"bigThumb"];
	self.curImageInfoDict = dictionary;
	
}

-(void)didReceiveMemoryWarning{
	[super didReceiveMemoryWarning];
		//	[self.imageView.image release];
}

@end
