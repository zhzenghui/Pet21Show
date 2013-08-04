//
//  P2FeedbackViewController.m
//  Artvotary
//
//  Created by zeng on 12-11-27.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2FeedbackViewController.h"
#import "Common.h"


@interface P2FeedbackViewController ()

@end

@implementation P2FeedbackViewController

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

    self.navigationItem.rightBarButtonItem  = BARBUTTON(NSLocalizedString(@"好了", @""), @selector(newOnline:));
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
