//
//  ImageDownloader.h
//  LifeLine
//
//  Created by zeng on 12-8-20.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppRecord.h"

@protocol ImageDownloaderDelegate

- (void)appImageDidLoad:(NSIndexPath *)indexPath;

@end

@interface ImageDownloader : NSObject
{
    AppRecord *appRecord;
    NSIndexPath *indexPathInTableView;
    id <ImageDownloaderDelegate> delegate;
    
    NSMutableData *activeDownload;
    NSURLConnection *imageConnection;
}

@property (nonatomic, retain) AppRecord *appRecord;
@property (nonatomic, retain) NSIndexPath *indexPathInTableView;
@property (nonatomic, assign) id <ImageDownloaderDelegate> delegate;

@property (nonatomic, retain) NSMutableData *activeDownload;
@property (nonatomic, retain) NSURLConnection *imageConnection;

- (void)startDownload;
- (void)cancelDownload;
@end
