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
@synthesize titleLable;


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
   
    UIView *v = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    UILabel *tLable = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 200, 44)];
    tLable.textAlignment = UITextAlignmentCenter;
    tLable.font = [UIFont systemFontOfSize:20];
    tLable.textColor = color(64, 124, 9, 1);
    tLable.backgroundColor = [UIColor clearColor];
    [v addSubview:tLable];
    titleLable = tLable;

    self.navigationItem.titleView = v;
    [v release];
    
    userDict = [Session getSession:@"userInfo"];
    
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Background"]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [userDict release];
    [titleLable release];

    [super dealloc];
}

@end
