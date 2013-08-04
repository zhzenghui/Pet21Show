//
//  PhoneLibraryViewController.m
//  Artvotary
//
//  Created by zeng on 12-11-1.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "PhoneLibraryViewController.h"

@interface PhoneLibraryViewController ()

@end

@implementation PhoneLibraryViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    UIImagePickerController *aImagePickerController = [[UIImagePickerController alloc] init];
    aImagePickerController.delegate = self;
    aImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:aImagePickerController animated:YES];
    [aImagePickerController release];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
