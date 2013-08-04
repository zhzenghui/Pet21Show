    //
//  CameraController.m
//  PhotoUploader
//
//  Created by 张 增超 on 10-9-2.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "EICameraController.h"

#import "Session.h"
#import "Common.h"

@implementation EICameraController
@synthesize delegate;
@synthesize imagePickerController;
@synthesize toolBar;
@synthesize takeBarItem;


- (void)dealloc {
	
	[toolBar release];
	[imagePickerController release];
	[takeBarItem release];
    [super dealloc];
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil{

	if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		
		CGFloat width =  self.view.frame.size.width;
		CGFloat height = self.view.frame.size.height;
		toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, width, height)];
		toolBar.barStyle = UIBarStyleDefault;
		[self.toolBar setTranslucent:YES];
		[toolBar sizeToFit];
		toolBar.autoresizingMask = UIViewAutoresizingFlexibleWidth;
		if (self.imagePickerController == nil) {
			self.imagePickerController = [[[UIImagePickerController alloc] init] autorelease];
			self.imagePickerController.delegate = self;
			self.imagePickerController.sourceType = UIImagePickerControllerSourceTypeCamera;
			self.imagePickerController.videoQuality =  UIImagePickerControllerQualityTypeLow;
			self.imagePickerController.showsCameraControls = NO;
			self.imagePickerController.allowsEditing = YES;
		}
				
		UIBarButtonItem *cancelBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelCamera:)];
		[cancelBarButton setTitle: NSLocalizedString(@"Cancel", @"")];
		
		UIBarButtonItem *fixedBarButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace target:self action:nil];
		fixedBarButton.width = 65;
		takeBarItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(takePhoto:)];	
		[self.takeBarItem setEnabled:YES];
		[toolBar setItems:[NSMutableArray arrayWithObjects:cancelBarButton,fixedBarButton,takeBarItem,nil]];
		[self.view addSubview:toolBar];
		[cancelBarButton release];
		[fixedBarButton release];
	}
	
	return self;
}

- (void)setupCamera{
    /* Delay Action */
	[self.takeBarItem setEnabled:NO];
	
	if (self.imagePickerController.cameraOverlayView != self.view){
		
		CGRect overlayViewFrame = self.imagePickerController.cameraOverlayView.frame;
		CGRect newFrame = CGRectMake(0.0, 
									 CGRectGetHeight(overlayViewFrame) - self.view.frame.size.height - 10.0f,
									 CGRectGetWidth(overlayViewFrame),
									 self.view.frame.size.height + 10.0f) ;
		self.view.frame = newFrame;
		self.toolBar.frame = CGRectMake(0, 0, newFrame.size.width, newFrame.size.height);
		
		self.imagePickerController.cameraOverlayView = self.view;
	}
	
	[self performSelector:@selector(buttonEnable) 
			   withObject:nil 
			   afterDelay:1.5];
}


- (void)viewDidLoad {
	
    [super viewDidLoad];
}

- (void)viewDidAppear:(BOOL)animated{

	self.navigationController.navigationBar.barStyle = UIBarStyleBlackOpaque;
	[[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleBlackOpaque];

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	
	UIInterfaceOrientation orientation = [[UIDevice currentDevice] orientation];
	if ((orientation == UIDeviceOrientationPortraitUpsideDown)
		|| (orientation == UIDeviceOrientationLandscapeLeft)
		|| (orientation == UIDeviceOrientationLandscapeRight)) {
		return YES;
	}
	else {
		return NO;
	}
}

#pragma mark -
#pragma mark BarItem Events

- (void)buttonEnable {
	[self.takeBarItem setEnabled:YES];
}

- (IBAction)takePhoto:(id)sender
{
	[self.imagePickerController takePicture];

}

- (IBAction)cancelCamera:(id)sender{
	
	[Session setSession:@"EICameraImageViewAutoBackToRoot" value:@"cancelCamera"];
	[self.imagePickerController dismissModalViewControllerAnimated:NO];

}

#pragma mark -
#pragma mark saveImageData Methods

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
	
	UIImage *image = [info valueForKey:UIImagePickerControllerOriginalImage];
	[self.takeBarItem setEnabled:NO];
	[self.delegate didTakePicture:image orientation:[[UIDevice currentDevice] orientation]];
	[self.delegate didFinishWithCamera];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
	[picker dismissModalViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

@end
