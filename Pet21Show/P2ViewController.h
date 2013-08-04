//
//  P2ViewController.h
//  Pet21Show
//
//  Created by zeng on 12-8-10.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "ImageDownloader.h"

@interface P2ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,ImageDownloaderDelegate>
{
    UITableView *myTableView;
    NSMutableArray *statuses;
    NSMutableArray *appRecords;
    
    NSMutableDictionary *imageDownloadsInProgress;  // the set of IconDownloader objects for each app
    
    int connectionMark;
}

@property(nonatomic, retain) IBOutlet UITableView *myTableView;

@property(nonatomic, retain) IBOutlet UIView *mView;

@property (nonatomic, retain) NSMutableDictionary *imageDownloadsInProgress;
@end
