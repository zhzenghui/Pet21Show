//
//  P2OnLineViewController.m
//  LifeLine
//
//  Created by zeng on 12-8-26.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#define kNumberOfPages 3
#define kScrollWidth 320

#define KlistWidth 61.5
#import "P2OnLineViewController.h"
#import "P2DetailOLViewController.h"
#import "MessageViewController.h"
#import "P2UserSettingViewController.h"
#import "P2SettingViewController.h"
#import "P2NewOnLineViewController.h"
#import "P2PaysViewController.h"
#import "P2UserViewController.h"
#import "P2UserHomeViewController.h"


#import <SDWebImage/UIButton+WebCache.h>
#import <SDWebImage/UIImageView+WebCache.h>




#import "ArtOnlineCell.h"
#import "ArtOnline.h"



@interface P2OnLineViewController ()

@end

@implementation P2OnLineViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

#pragma mark    view show Controll

- (IBAction)hiddenMenu:(id)sender
{
    _mainView.alpha = 0;
}

- (IBAction)showMenu:(id)sender
{
    [self.view bringSubviewToFront:_mainView];
    if (_mainView.alpha == 1) {
        _mainView.alpha = 0;
    }
    else {
        _mainView.alpha = 1;
    }

}

- (IBAction)switchMenu:(id)sender
{
    UIButton *button = (UIButton *) sender;
    
    switch (button.tag) {
        case 21:
        {
            [_contentScrollView setContentOffset:CGPointMake(0, 0)];
            break;
        }
        case 22:
        {
            [_contentScrollView setContentOffset:CGPointMake(kScrollWidth, 0)];
            break;
        }
        case 23:
        {
            [_contentScrollView setContentOffset:CGPointMake(kScrollWidth*2, 0)];
            break;
        }
        default:
            break;
    }
}


#pragma mark network
- (void)getNewDataOnDate:(NSString *)dateString
{
    struct _SYNC_SERVER_PACKET_RECORD *P_SYNC_SERVER_PACKET_RECORD = (struct _SYNC_SERVER_PACKET_RECORD *)malloc(sizeof(struct _SYNC_SERVER_PACKET_RECORD));
    
    P_SYNC_SERVER_PACKET_RECORD -> delegate = self;
    P_SYNC_SERVER_PACKET_RECORD -> progressIndicator = nil;
    P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFinishSelector = @selector(getDBList_CallBack:);
    P_SYNC_SERVER_PACKET_RECORD -> action = SERVER_ACTIONS_GETONLINE;
    P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFailSelector = @selector(getDBListFail_CallBack:);
    P_SYNC_SERVER_PACKET_RECORD -> dataDict = nil;
    
    DataProcess *myDataProcess = [[DataProcess alloc] init];
    
    [myDataProcess SyncServer:nil syncServerPackedRecord:P_SYNC_SERVER_PACKET_RECORD];
    
}

- (IBAction)refresh:(id)sender
{
    //    NSString *lastDate = [[onlineInfoArray objectAtIndex:0] objectForKey:KonlineLastDate];
    
    
}


#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 70;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{


    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if ([tableView isEqual:_iTableView]) {
        return [_objects count];
    }

    return [onlineInfoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
   if ([tableView isEqual:_newArtTableView])
    {
        static NSString *CellIdentifier = @"Cell";

        ArtOnlineCell *cell = (ArtOnlineCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            
            NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"ArtOnlineCell" owner:self options:nil];
            
            for (id currentObject in topLevelObjects){
                if ([currentObject isKindOfClass:[UITableViewCell class]]){
                    cell =  (ArtOnlineCell *) currentObject;
                    break;
                }
            }
        }
        
        NSDictionary *dict = [onlineInfoArray objectAtIndex:indexPath.row];
        
        cell.onlineImageView.image = [UIImage imageNamed: [dict objectForKey:KonlineImage]];
        cell.titleLable.text = [dict objectForKey:KonlineTitle];
        cell.numberLable.text = [NSString stringWithFormat:@"奖励:%@",[dict objectForKey:KonlineRewardAmount]] ;
        cell.dateLable.text = [dict objectForKey:KonlineDate];
        [cell.userButton setTitle:[NSString stringWithFormat:@"@%@",[dict objectForKey:KonlineUser]] forState:UIControlStateNormal];
        [cell.OnlinetagButton setTitle:[dict objectForKey:KonlineTag] forState:UIControlStateNormal];
        
        return cell;
    }

   else {
       assert([tableView isKindOfClass:[UITableView class]]);
       assert([indexPath isKindOfClass:[NSIndexPath class]]);
       
       NSString* cellIdentifier = @"HorizontalTableViewCell";
       
       UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
       
       if (!cell)
       {
           NSArray *nib = [[NSBundle mainBundle] loadNibNamed:cellIdentifier owner:self options:nil];
           cell = (UITableViewCell*) [nib objectAtIndex:0];
           
           assert([cellIdentifier isEqualToString:cell.reuseIdentifier]);

       }
       assert([cell isKindOfClass:[UITableViewCell class]]);
       
       
       UILabel *label = (UILabel *)[cell.contentView viewWithTag:10];
       UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:11];
       
       label .text = [_objects objectAtIndex:indexPath.row];

       [imageView setImageWithURL:[NSURL URLWithString:[_objects objectAtIndex:indexPath.row]]
              placeholderImage:[UIImage imageNamed:@"Info-AvatarSmall-Frame"]];
       
       return cell;
   }

    return nil;
}

#pragma mark - Table view delegate

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
    
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if ([tableView isEqual:_iTableView]) {//        我喜欢的

        P2DetailOLViewController *detailViewController = [[P2DetailOLViewController alloc] init];
        detailViewController.detailDataArray = _objects;
        detailViewController.indexPath = indexPath;
        
        [self.navigationController pushViewController:detailViewController animated:YES];
        [detailViewController release];
    }
    else if ([tableView isEqual:_MessageTableView])
    {
        MessageViewController *message = [[MessageViewController alloc] init];
        [self .navigationController pushViewController:message animated:YES];
        
        [message release];
    }
    
}

#pragma mark -  open  ViewController
- (IBAction)openOnlineType:(id)sender
{
    UIButton *button = (UIButton *)sender;

    NSLog(@"open line Type %d -text:%@", button.tag, button.titleLabel.text);
}


- (IBAction)newOnlineViewController:(id)sender
{
    _mainView.alpha = 0;
    
    P2NewOnLineViewController *newOnlineViewController = [[P2NewOnLineViewController alloc] init];
    
    [self.navigationController pushViewController:newOnlineViewController animated:YES];
    
    [newOnlineViewController release];
}

- (IBAction)openPaysViewController:(id)sender
{
    _mainView.alpha = 0;
    
    P2PaysViewController *payViewController = [[P2PaysViewController alloc] init];
    
    [self.navigationController pushViewController:payViewController animated:YES];
    
    [payViewController release];
}

- (IBAction)openMyHomeViewController:(id)sender
{
    
    P2UserViewController *userViewController = [[P2UserViewController alloc] init];
    
    [self.navigationController pushViewController:userViewController animated:YES];
    
    [userViewController release];
}

- (IBAction)openUserHomeViewController:(id)sender
{
    
    P2UserHomeViewController *userHomeViewController = [[P2UserHomeViewController alloc] init];
    
    [self.navigationController pushViewController:userHomeViewController animated:YES];
    
    [userHomeViewController release];
}

- (IBAction)openSettingViewController:(id)sender
{
    
    P2SettingViewController *settingViewController = [[P2SettingViewController alloc] init];
    
    [self.navigationController pushViewController:settingViewController animated:YES];
    
    [settingViewController release];
}

- (IBAction)openUserSettingViewController:(id)sender
{
    
    P2UserSettingViewController *userSettingViewController = [[P2UserSettingViewController alloc] init];
    
    [self.navigationController pushViewController:userSettingViewController animated:YES];
    
    [userSettingViewController release];
}

#pragma mark - initData

- (void)initIScrollview
{
    [self initData];
//    CGFloat width = 61.5;
//    for (int x =0 ; x <5; x++) {
//        UIButton *button  = [UIButton buttonWithType:UIButtonTypeCustom];
//        button.frame = CGRectMake(x*width, 0, width, _IScrollView.frame.size.height);
//        
////        button.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Info-AvatarSmall-Frame"]];
//        [button setImageWithURL:[NSURL URLWithString:[_objects objectAtIndex:x]]
//                       placeholderImage:[UIImage imageNamed:@"Info-AvatarSmall-Frame"]];
//        
//        
//        [ionlineInfoArray addObject:button];
//        [_IScrollView addSubview:button];
//    }

    
    

}

- (void)initData
{
    _objects =[[NSMutableArray alloc] initWithArray: [NSArray arrayWithObjects:
                  @"http://static2.dmcdn.net/static/video/257/119/43911752:jpeg_preview_small.jpg?20120416101238",
                  @"http://static2.dmcdn.net/static/video/874/098/43890478:jpeg_preview_small.jpg?20120415193608",
                  @"http://static2.dmcdn.net/static/video/406/148/43841604:jpeg_preview_small.jpg?20120416123145",
                  @"http://static2.dmcdn.net/static/video/463/885/43588364:jpeg_preview_small.jpg?20120409130206",
                  @"http://static2.dmcdn.net/static/video/176/845/38548671:jpeg_preview_small.jpg?20120414200742",
                nil]];
    
}




#pragma mark view clcyle

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    
    [self initIScrollview];

//    UIButton *button1 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button1 setTitle:NSLocalizedString(@"朋友", @"")
//             forState:UIControlStateNormal];
//    button1.frame = CGRectMake(211, 0, 49, 44);
//    [button1 addTarget:self action:@selector(openFriend:) forControlEvents:UIControlEventTouchUpInside];
//    
//    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [button2 setTitle:NSLocalizedString(@"新活动", @"")
//             forState:UIControlStateNormal];
//    [button2 addTarget:self action:@selector(newOnline:) forControlEvents:UIControlEventTouchUpInside];
//    button2.frame = CGRectMake(265, 0, 55, 44);
//    
//    UIButton *leftbutton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
//    [leftbutton setTitle:@"ART" forState:UIControlStateNormal];
//    [leftbutton addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
//    leftbutton.frame = CGRectMake(0, 0, 59, 44);
//
    UIImage *img = [UIImage imageNamed:@"NavBar-logo"];
    UIImageView *iv = [[UIImageView alloc] initWithImage:img];
    iv.frame = CGRectMake((320-img.size.width)/2, 5, img.size.width, img.size.height);
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
    [view addSubview:iv];
    
    
    UIImage* image2= [UIImage imageNamed:@"NavBar-Button"];
    
    CGRect frame_2= CGRectMake(0, 8, image2.size.width, image2.size.height);
    UIButton* backButton2= [[UIButton alloc] initWithFrame:frame_2];
//    [backButton2 setImage:image2 forState:UIControlStateNormal];
    [backButton2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [backButton2 setTitle:@"菜单" forState:UIControlStateNormal];
    [backButton2 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    backButton2.titleLabel.font=[UIFont systemFontOfSize:16];
    [backButton2 addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
    
   
    CGRect frame_1= CGRectMake(260, 2, 44, 44);
    
    UIButton* backButton1= [[UIButton alloc] initWithFrame:frame_1];
    //    [backButton2 setImage:image2 forState:UIControlStateNormal];
    [backButton1 setBackgroundImage:image2 forState:UIControlStateNormal];
    [backButton1 setTitle:@"+" forState:UIControlStateNormal];
    [backButton1 setTitleColor:[UIColor brownColor] forState:UIControlStateNormal];
    backButton1.titleLabel.font=[UIFont systemFontOfSize:26];
    [backButton1 addTarget:self action:@selector(newOnlineViewController:) forControlEvents:UIControlEventTouchUpInside];
    
    
    [view addSubview:backButton1];
    [view addSubview:backButton2];
    
    [backButton2 release];
  
    self.navigationItem.titleView = view;

    [view release];
    //    [self.navigationController.navigationBar addSubview:leftbutton];
    //    [self.navigationController.navigationBar addSubview:button1];
    //    [self.navigationController.navigationBar addSubview:button2];
    
    
    
    [P2CommonMethod setTabBarItemBadge:self.parentViewController:@"2"];
    
    ArtOnline *aonline = [[ArtOnline alloc] init];
    
    onlineInfoArray = [[NSMutableArray alloc] initWithArray:[aonline getArtOnlineArr]];
    ionlineInfoArray = [[NSMutableArray alloc] init];
    //    [aonline release];
    
    //    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    //    [dict setValue:@"Placeholder" forKey:KonlineImage];
    //    [dict setValue:@"这是标题" forKey:KonlineTitle];
    //    [dict setValue:@"32" forKey:KonlineRewardAmount];
    //    [dict setValue:@"7:21:23" forKey:KonlineDate];
    //    [dict setValue:@"星座" forKey:KonlineTag];
    //    [dict setValue:@"zeng" forKey:KonlineUser];
    //
    //    [onlineInfoArray addObject:dict];
    
    
    [self.view addSubview:_mainView];
    _mainView.alpha = 0;
    
    
    [self.contentScrollView addSubview:_contentView];    
    [self.contentScrollView setContentSize:_contentView.frame.size];
    
    
    [self.iScrollView addSubview:_iView];
    [self.iScrollView setContentSize:_iView.frame.size];
    

}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    //    ArtOnline *aonline = [[ArtOnline alloc] init];
    //    onlineInfoArray = [aonline getArtOnlineArr];
    [self.onLineTableView reloadData];
    
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    

    
    
    [_onLineTableView release];
    [_myCell release];
    [onlineInfoArray release];
    
    [_mainView release];
    [_contentScrollView release];
    [_contentView release];
    [_ICmtLable release];
    [_IScrollView release];
    [_iListView release];
    [_groupListView release];
    [_roomListView release];
    [_iTableView release];
    [_groupTableView release];
    [_roomTableView release];
    [_allDataTableView release];
    [_newArtTableView release];
    [_popularTableView release];
    [_MessageTableView release];
    [_iView release];
    [_iScrollView release];

    [super dealloc];
}
- (void)viewDidUnload {
    [self setOnLineTableView:nil];
    [self setMyCell:nil];
    [self setMainView:nil];
    [self setContentScrollView:nil];
    [self setContentView:nil];
    [self setICmtLable:nil];
    [self setIScrollView:nil];
    [self setIListView:nil];
    [self setGroupListView:nil];
    [self setRoomListView:nil];
    [self setITableView:nil];
    [self setGroupTableView:nil];
    [self setRoomTableView:nil];
    [self setAllDataTableView:nil];
    [self setNewArtTableView:nil];
    [self setPopularTableView:nil];
    [self setMessageTableView:nil];
    [self setIView:nil];
    [self setIScrollView:nil];

    [super viewDidUnload];
}



@end
