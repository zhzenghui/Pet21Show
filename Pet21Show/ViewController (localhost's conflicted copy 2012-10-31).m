//
//  ViewController.m
//  LifeLine
//
//  Created by zeng on 12-9-27.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "ViewController.h"
#import "Common.h"
#import "P2PaysViewController.h"


@interface ViewController ()

@end

@implementation ViewController
@synthesize userDict;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)payGold:(id)sender
{
    P2PaysViewController *payVC = [[P2PaysViewController alloc] init];
    [self.navigationController pushViewController:payVC animated:YES];
    
    [payVC release];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
    userDict = [Session getSession:@"user"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [super dealloc];
    [userDict release];
    
}

@end
