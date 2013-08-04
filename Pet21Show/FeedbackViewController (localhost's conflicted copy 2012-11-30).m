//
//  FeedbackViewController.m
//  Artvotary
//
//  Created by zeng on 12-11-27.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "FeedbackViewController.h"
#import "Common.h"
#import "ASINetworkQueue.h"
#import "ASIFormDataRequest.h"


@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)failSelector:(id)sender
{
    
}
- (IBAction)FinishSelector:(id)sender
{
    
}

- (IBAction)sendFeedBack:(id)sender
{
//    username
//    content

    [_feedBackTextView resignFirstResponder  ];
    
    NSString *feedBack = [EscopeString escope: _feedBackTextView  .text];
    NSString *userName = [userDict objectForKey:Kusername];
    
    
    
    ASINetworkQueue *networkQueue = [[ASINetworkQueue queue] retain];

    [networkQueue cancelAllOperations];
    [networkQueue setDownloadProgressDelegate:nil];
    [networkQueue setRequestDidFailSelector:@selector(failSelector:)];
    [networkQueue setRequestDidFinishSelector:@selector(FinishSelector:)];
    [networkQueue setDelegate:self];
    
    
    ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:[NSURL URLWithString:@"http://127.0.0.1:8000/contact/"]];
    [request setPostValue:feedBack forKey:@"feedback"];
    [request setPostValue:userName forKey:@"username"];
    
    
    
    [networkQueue addOperation:request];
    
    
    
    [networkQueue go];    
    [networkQueue release];
    
//    dispatch_queue_t postQueue = dispatch_queue_create("post feedback", NULL);
//    
//    dispatch_async(postQueue, ^{
//
//        dispatch_async(dispatch_get_main_queue(), ^{
//            
//        });
//    });
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.rightBarButtonItem = BARBUTTON(NSLocalizedString( @"好了，发送吧", @""), @selector(sendFeedBack:));

    _feedBackTextView.text = NSLocalizedString( @"说点什么呢？", @"");;
    [_feedBackTextView selectAll:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_feedBackTextView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setFeedBackTextView:nil];
    [super viewDidUnload];
}
@end
