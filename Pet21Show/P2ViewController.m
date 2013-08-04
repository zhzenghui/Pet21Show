//
//  P2ViewController.m
//  Pet21Show
//
//  Created by zeng on 12-8-10.
//  Copyright (c) 2012年 zeng. All rights reserved.
//


#define FONT_SIZE 14.0f
#define CELL_CONTENT_WIDTH 320.0f
#define CELL_CONTENT_MARGIN 10.0f


#define CELLIMAGEHEITH 60


#define KcellImageview 100

#import "P2ViewController.h"
#import "P2AddUserViewController.h"
#import "P2AddStatusesViewController.h"
#import "P2SettingViewController.h"
#import "everyday/P2EveryDayViewController.h"
#import "SinaWeiBoSDKDemoViewController.h"
#import "P2StatusesDetailViewController.h"

#import "P2GuideViewController.h"

#import "KeychainItemWrapper.h"
#import "JSONKit.h"


#import "untitl/DataProcess.h"
#import "untitl/P2PetShow_Utility.h"
#import "AppRecord.h"
#import "ImageDownloader.h"

@interface P2ViewController ()

@end

@implementation P2ViewController
@synthesize myTableView;
@synthesize imageDownloadsInProgress;
- (void)addUser
{
    P2AddUserViewController *addUser = [[P2AddUserViewController alloc] initWithNibName:@"P2AddUserViewController" bundle:nil];
    
    [self.navigationController pushViewController:addUser animated:YES];
    [addUser release];
}

- (IBAction)openAddStatuses:(id)sender {
    
    P2AddStatusesViewController *addStatues = [[P2AddStatusesViewController alloc] init];
    
    [self.navigationController pushViewController:addStatues animated:YES];
    [addStatues release];
}

- (IBAction)openSettingView:(id)sender
{
    P2SettingViewController *vc = [[P2SettingViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (IBAction)openEveryDayOnes:(id)sender
{
    P2EveryDayViewController *vc = [[P2EveryDayViewController alloc] init];
    
    [self.navigationController pushViewController:vc animated:YES];
    [vc release];
}

- (void)getUserInfo
{
    NSMutableDictionary  *dict = [[NSMutableDictionary alloc] init];
    [dict setValue:@"name" forKey:@"name"];
    [dict setValue:@"desc" forKey:@"desc"];
    [dict setValue:@"19" forKey:@"id"];
    
//    提醒
//    信
//    礼物
//    好友请求
//    好友发布消息
//    评论
//    心情
    [dict setValue:@"message" forKey:@"message"];
    
//    地理位置
    
    [Session setSession:@"userInfo" value:dict];
    
    [dict release];
}

- (void)isLogin {

    KeychainItemWrapper *wrapper  = [[KeychainItemWrapper alloc] initWithIdentifier:@"Account Number"accessGroup:@"boniu.com.boli.AppIdentifier"];
    
    if ([wrapper objectForKey:(id)kSecAttrAccount]) {
        
        
    }
    else {
        
    }
}

- (void)getDBListFail_CallBack
{
    NSLog(@"%@", @"error");
}

- (void)initAppcord
{
    if ([statuses count] == 0) {
        return;
    }
    
    for (int i =0;i <[statuses count]; i++) {
        NSDictionary *status_fileds = [[statuses objectAtIndex:i] objectForKey:@"fields"];
        
        AppRecord *appRecord = [[AppRecord alloc] init];
        appRecord.imageURLString = [status_fileds objectForKey:@"thumbnail_pic"];
        [appRecords addObject:appRecord];
    }

}

# pragma mark init UI
- (void)initToolBar {
    
    
}

- (void)reFresh
{
    
    if (connectionMark == 0) {
        [statuses removeAllObjects];
        [appRecords removeAllObjects];
    }
	struct _SYNC_SERVER_PACKET_RECORD *P_SYNC_SERVER_PACKET_RECORD = (struct _SYNC_SERVER_PACKET_RECORD *)malloc(sizeof(struct _SYNC_SERVER_PACKET_RECORD));
	
	P_SYNC_SERVER_PACKET_RECORD -> delegate = self;
	P_SYNC_SERVER_PACKET_RECORD -> progressIndicator = nil;
	P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFinishSelector = @selector(getDBList_CallBack:);
	P_SYNC_SERVER_PACKET_RECORD -> action = SERVER_ACTIONS_STATUES;
	P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFailSelector = @selector(getDBListFail_CallBack:);
    
    
    DataProcess *myDataProcess = [[DataProcess alloc] init];
    
    [myDataProcess SyncServer:SERVER_ACTIONS_STATUES syncServerPackedRecord:P_SYNC_SERVER_PACKET_RECORD];
}

#pragma mark - view cyle
- (void)loadView {
    [super loadView];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
//    self.title = @"statuses";}

//    是否登陆    
    [self isLogin];
    
    [self getUserInfo];
    
    self.imageDownloadsInProgress = [NSMutableDictionary dictionary];
    appRecords = [[NSMutableArray alloc] init];
    [Session setSession:@"id" value:@"19"];
    

    
//    UIBarButtonItem* editButton = [[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)] autorelease];
//    [self setToolbarItems:[NSArray arrayWithObject:editButton]];

//    UIBarButtonItem* settingButton = [[[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editAction)] autorelease];
//    [self setToolbarItems:[NSArray arrayWithObject:settingButton]];

    
    self.navigationItem.leftBarButtonItem = BARBUTTON(@"新发现", @selector(openAddStatuses:));
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"设置", @selector(reFresh));
    /*
// 微博验证 weibo
    SinaWeiBoSDKDemoViewController *sinaViewController =  [[SinaWeiBoSDKDemoViewController alloc] init];
    [self.navigationController pushViewController:sinaViewController animated:YES];
    [sinaViewController release];
*/
    
    
//    [self addUser];
    
//    NSMutableDictionary *userDict = [NSMutableDictionary dictionary];
//
//
//    [userDict setValue:@"xiaolin" forKey:@"screen_name"] ;
//    [userDict setValue:@"0" forKey:@"gender"] ;
//    [userDict setValue:@"lalalallaallal" forKey:@"description"];
//    [userDict setValue:@"2010-1-1" forKey:@"birth"];
//    [userDict setValue:@"2010" forKey:@"phone"];
//    [userDict setValue:@"/webhp?hl=zh" forKey:@"profile_image_url"];
//    
//    [userDict setValue:@"xiaowei" forKey:@"name"];
//    [userDict setValue:@"zhzenghui@gmail.com" forKey:@"email"];
//    [userDict setValue:@"zenghui" forKey:@"pwd"];
//    
//    
//    [Session setSession:@"user" value:userDict];

    connectionMark = 0;
    [self reFresh] ;
    
    if (0) {
        P2GuideViewController *guideViewcontroller = [[P2GuideViewController alloc] init];
        [self presentModalViewController:guideViewcontroller animated:YES];
        
        [guideViewcontroller release];
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    NSArray *allDownloads = [self.imageDownloadsInProgress allValues];
    
    [allDownloads makeObjectsPerformSelector:@selector(cancelDownload)];
}

- (void)dealloc {
    
    [statuses release];
    [appRecords release];
    
	[imageDownloadsInProgress release];
    [super dealloc];
}

#pragma mark - _SYNC_SERVER_PACKET_RECORD

- (void)getDBList_CallBack:(ASIFormDataRequest *)request
{
    if (request.responseStatusCode == 200) {

        statuses = (NSMutableArray *)[request.responseString objectFromJSONString];
        [statuses retain];
        
        [self initAppcord];
        [myTableView reloadData];
        NSLog(@"%@", statuses);
    }
    else {
        NSLog(@"%@", request.responseString);
        UIWebView *webV = [[UIWebView alloc]initWithFrame:screenSize];
        
        [webV loadHTMLString:request.responseString baseURL:nil];
        [self.view addSubview:webV];
        [webV release];
    }
}
- (IBAction)getDBListFail_CallBack:(id)sender
{
    
}

#pragma mark - Table view data source



- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSLog(@"%d", indexPath.row);
    NSDictionary *statusInfo = [statuses objectAtIndex:indexPath.row];
    
    NSDictionary *statusFieldInfo = [statusInfo objectForKey:@"fields"];
    
    NSString *text = [statusFieldInfo objectForKey:@"text"];
    
    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    
    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    
    CGFloat height = MAX(size.height, 44.0f);
    
    if (YES) {
        height += CELLIMAGEHEITH;
    }
    
    return height + (CELL_CONTENT_MARGIN * 2) ;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [statuses count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(50, 20, 200, 100);
        imageView.tag = KcellImageview;
        
        [cell.contentView addSubview:imageView];
    }
    
    
    UIImageView *iv = (UIImageView *)[cell.contentView viewWithTag:KcellImageview];
    
    
    // Configure the cell...
    NSDictionary *statusInfo = [statuses objectAtIndex:indexPath.row];
    NSDictionary *statusFieldInfo = [statusInfo objectForKey:@"fields"];
    
    NSString *text = [statusFieldInfo objectForKey:@"text"];
    NSString *create_at = [statusFieldInfo objectForKey:@"created_at"];

    
    AppRecord *appRecord = [appRecords objectAtIndex:indexPath.row];
    
    if (!appRecord.appIcon)
    {
        if (self.myTableView.dragging == NO && self.myTableView.decelerating == NO)
        {
            [self startIconDownload:appRecord forIndexPath:indexPath];
        }
        
        iv.image = [UIImage imageNamed:@"Placeholder.png"];

        // if a download is deferred or in progress, return a placeholder image
        cell.imageView.image = [UIImage imageNamed:@"Placeholder.png"];
    }
    else
    {
        iv.image =  appRecord.appIcon;

        cell.imageView.image = appRecord.appIcon;
    }

    
    return cell;
}

/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */

/*
 // Override to support editing the table view.
 - (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
 {
 if (editingStyle == UITableViewCellEditingStyleDelete) {
 // Delete the row from the data source
 [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
 }
 else if (editingStyle == UITableViewCellEditingStyleInsert) {
 // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
 }
 }
 */

/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
 {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
 {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{

    UIView *footView = [[[UIView alloc] init] autorelease];
    return footView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here. Create and push another view controller.
    
     P2StatusesDetailViewController *detailViewController = [[P2StatusesDetailViewController alloc] initWithNibName:@"P2StatusesDetailViewController" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     
}

#pragma mark -
#pragma mark Table cell image support

- (void)startIconDownload:(AppRecord *)appRecord forIndexPath:(NSIndexPath *)indexPath
{
    ImageDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader == nil)
    {
        NSLog(@"%d", indexPath.row);
        iconDownloader = [[ImageDownloader alloc] init];
        iconDownloader.appRecord = appRecord;
        iconDownloader.indexPathInTableView = indexPath;
        iconDownloader.delegate = self;
        [imageDownloadsInProgress setObject:iconDownloader forKey:indexPath];
        [iconDownloader startDownload];
        [iconDownloader release];
    }
}

- (void)appImageDidLoad:(NSIndexPath *)indexPath
{
    ImageDownloader *iconDownloader = [imageDownloadsInProgress objectForKey:indexPath];
    if (iconDownloader != nil)
    {
        UITableViewCell *cell = [self.myTableView cellForRowAtIndexPath:iconDownloader.indexPathInTableView];
        
        // Display the newly loaded image
            UIImageView *iv = (UIImageView *)[cell.contentView viewWithTag:KcellImageview];
        iv.image = iconDownloader. appRecord.appIcon;

        cell.imageView.image = iconDownloader.appRecord.appIcon;
    }
}


// this method is used in case the user scrolled into a set of cells that don't have their app icons yet
- (void)loadImagesForOnscreenRows
{
    if ([appRecords count] > 0)
    {
        NSArray *visiblePaths = [self.myTableView indexPathsForVisibleRows];
        for (NSIndexPath *indexPath in visiblePaths)
        {
            AppRecord *appRecord = [appRecords objectAtIndex:indexPath.row];
            
            if (!appRecord.appIcon) // avoid the app icon download if the app already has an icon
            {
                [self startIconDownload:appRecord forIndexPath:indexPath];
            }
        }
    }
}


#pragma mark -
#pragma mark Deferred image loading (UIScrollViewDelegate)

// Load images for all onscreen rows when scrolling is finished
- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    if (decelerate && [statuses count] != 0)
	{
        NSArray *visiblePaths = [self.myTableView indexPathsForVisibleRows];
       
        NSIndexPath *index = [visiblePaths objectAtIndex:[visiblePaths count]-3];
        if (index.row == [statuses count]-3) {
            
            UIView *footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, screenWidth, 45)];
            UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.frame = CGRectMake(0, 0, screenWidth, 45);
//            button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"webhp"]];
//            [button setTitle:@"loading" forState:UIControlStateNormal];
//            [button setTintColor:<#(UIColor *)#>]
            [footView addSubview:button];
            
            UIImageView *animationView = [[UIImageView alloc] initWithFrame:CGRectMake((screenWidth-32)/2-16, 50-32-16, 32, 32)];
            animationView.animationImages = [NSArray arrayWithObjects:[UIImage imageNamed:@"loading1"],
                                             [UIImage imageNamed:@"loading1"],
                                             [UIImage imageNamed:@"loading2"],
                                             [UIImage imageNamed:@"loading3"],
                                             [UIImage imageNamed:@"loading4"],
                                             [UIImage imageNamed:@"loading5"],
                                             [UIImage imageNamed:@"loading6"],
                                             [UIImage imageNamed:@"loading7"],
                                             [UIImage imageNamed:@"loading8"],
                                             nil];

            animationView.animationDuration = .6;
            animationView.animationRepeatCount = 0;
            
            [footView addSubview:animationView];
            [animationView startAnimating];
            
            
            myTableView.tableFooterView = footView;
            [footView release];
        }
                    NSLog(@"-%d", index.row);
        if (index.row == [statuses count]-1) {
            NSLog(@"%d : %d", index.row, [statuses count]);
            NSLog(@"-%d", index.row);
        }
        
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self loadImagesForOnscreenRows];
}

@end
