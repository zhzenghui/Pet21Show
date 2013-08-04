//
//  P2SettingViewController.m
//  Artvotary
//
//  Created by zeng on 12-11-25.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2SettingViewController.h"
#import "FeedbackViewController.h"


@interface P2SettingViewController ()
{
    NSArray *settingArray;
    NSMutableArray *settingDataArray;
    
}
@property (retain, nonatomic) IBOutlet UIView *commentViewSetting;
@property (retain, nonatomic) IBOutlet UIView *messageViewSetting;


@property (retain, nonatomic) IBOutlet UIView *apnsViewSetting;
- (IBAction)commentSetting:(id)sender;
@end

@implementation P2SettingViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


#define Kcomment @"comment"
#define Kmessage @"message"

#define Kapns @"apns"

#define Kalipay @"alipay"
#define Kbank @"bank"


#define Kyijian @"yijian"
#define Kxieyi  @"xieyi"
#define Kguanyu @"guanyu"



#define KcommentAll 100
#define KcommentFriend 101
#define KcommentProhibits 102

#define KmessageAll 100
#define KmessageFriend 101
#define KmessageProhibits 102

#define KapnsSwitch 200


- (void)initSettingData
{
    NSMutableDictionary *settingMDict1 = [NSMutableDictionary dictionary];
    [settingMDict1 setValue:@"1" forKey:Kcomment];
    [settingMDict1 setValue:@"2" forKey:Kmessage];
    
//    NSMutableDictionary *settingMDict2 = [NSMutableDictionary dictionary];
//    [settingMDict2 setValue:@"0" forKey:Kapns];
    
//    NSMutableDictionary *settingMDict3 = [NSMutableDictionary dictionary];
//    [settingMDict3 setValue:@"1" forKey:Kalipay];
//    [settingMDict3 setValue:@"1" forKey:Kbank];
    
    NSMutableDictionary *settingMDict4 = [NSMutableDictionary dictionary];
    [settingMDict4 setValue:@"我知道你肯定没意见，有意见的话戳这里吧" forKey:Kyijian];
    [settingMDict4 setValue:@"协议我说的算， 大家遵纪守法就行了，没有了。" forKey:Kxieyi];
    [settingMDict4 setValue:@"版本1.0 " forKey:Kguanyu];
    
    settingDataArray = [[NSMutableArray alloc ]initWithObjects:settingMDict1,
                     settingMDict4
                    , nil ];

}

- (void)viewDidLoad
{
    [super viewDidLoad];
//    隐私设置
//         评论
//          信息
//
//    通知
//      f 请求
//     评论
//      赠送
//    权限请求
//        推送通知
//            
//    兑换信息设置

//    意见反馈
//    关于
    
    NSMutableArray *settingMArray = [NSMutableArray array];
    [settingMArray addObject:NSLocalizedString(@"评论", @"")];
    [settingMArray addObject:NSLocalizedString(@"信息", @"")];
    
//    NSMutableArray *setting1MArray = [NSMutableArray array];
//    [setting1MArray addObject:NSLocalizedString(@"推送通知", @"")];

//    NSMutableArray *setting3MArray = [NSMutableArray array];
//    [setting3MArray addObject:NSLocalizedString(@"支付宝", @"")];
//    [setting3MArray addObject:NSLocalizedString(@"银行卡", @"")];
    
    NSMutableArray *setting4MArray = [NSMutableArray array];
    [setting4MArray addObject:NSLocalizedString(@"跟作者说话", @"")];
    [setting4MArray addObject:NSLocalizedString(@"使用协议", @"")];
    [setting4MArray addObject:NSLocalizedString(@"关于", @"")];
    
    settingArray = [[NSArray alloc ]initWithObjects:settingMArray
                    , setting4MArray
                    , nil ];

    [self initSettingData];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - 
- (IBAction)apnsValueChanged:(id)sender
{
    UISwitch *switchControl = (UISwitch *)sender;
    
    NSDictionary *dict = [settingDataArray objectAtIndex:1];
    
    if (switchControl.on) {
        [dict setValue:[NSNumber numberWithInt:1] forKey:Kapns];
    }
    else {
        [dict setValue:[NSNumber numberWithInt:0] forKey:Kapns];
    }
}

#pragma mark - setting
- (void)swithMessageButtonInTag :(int)tag
{
    UIImage *imageSelect = [UIImage imageNamed:@"Info-Checkbox-Selected"];
    UIImage *imageUnselect = [UIImage imageNamed:@"Info-Checkbox-Unselected"];
    
    UIButton *allButton = (UIButton *)[self.messageViewSetting viewWithTag:KcommentAll];
    UIButton *friendButton = (UIButton *)[self.messageViewSetting viewWithTag:KcommentFriend];
    UIButton *ProhibitsButton = (UIButton *)[self.messageViewSetting viewWithTag:KcommentProhibits];
    
    [allButton setImage:imageUnselect forState:UIControlStateNormal];
    [friendButton setImage:imageUnselect forState:UIControlStateNormal];
    [ProhibitsButton setImage:imageUnselect forState:UIControlStateNormal];
    
    switch (tag) {
        case 0:
        {
            [allButton setImage:imageSelect forState:UIControlStateNormal];
            
            break;
        }
        case 1:
        {
            [friendButton setImage:imageSelect forState:UIControlStateNormal];
            
            break;
        }
        case 2:
        {
            [ProhibitsButton setImage:imageSelect forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }
    

}

- (void)swithCommentButtonInTag :(int)tag
{
    
    UIImage *imageSelect = [UIImage imageNamed:@"Info-Checkbox-Selected"];
    UIImage *imageUnselect = [UIImage imageNamed:@"Info-Checkbox-Unselected"];
    
    UIButton *allButton = (UIButton *)[self.commentViewSetting viewWithTag:KcommentAll];
    UIButton *friendButton = (UIButton *)[self.commentViewSetting viewWithTag:KcommentFriend];
    UIButton *ProhibitsButton = (UIButton *)[self.commentViewSetting viewWithTag:KcommentProhibits];
    
    [allButton setImage:imageUnselect forState:UIControlStateNormal];
    [friendButton setImage:imageUnselect forState:UIControlStateNormal];
    [ProhibitsButton setImage:imageUnselect forState:UIControlStateNormal];
    
    switch (tag) {
        case 0:
        {
            [allButton setImage:imageSelect forState:UIControlStateNormal];
            
            break;
        }
        case 1:
        {
            [friendButton setImage:imageSelect forState:UIControlStateNormal];
            
            break;
        }
        case 2:
        {
            [ProhibitsButton setImage:imageSelect forState:UIControlStateNormal];
            break;
        }
        default:
            break;
    }

}



- (IBAction)commentSetting:(id)sender
{

    NSDictionary *dict = [settingDataArray objectAtIndex:0];
    
    UIButton *button = (UIButton *)sender;

    switch (button.tag) {
        case KcommentAll:
        {
            [dict setValue:[NSNumber numberWithInt:0] forKey:Kcomment];
            [self swithCommentButtonInTag:0];
            break;
        }
        case KcommentFriend:
        {
            [dict setValue:[NSNumber numberWithInt:1] forKey:Kcomment];
            [self swithCommentButtonInTag:1];
            break;
        }
        case KcommentProhibits:
        {
            [dict setValue:[NSNumber numberWithInt:2] forKey:Kcomment];
            [self swithCommentButtonInTag:2];
            break;
        }
            
        default:
            break;
    }

}

- (IBAction)messageSetting:(id)sender
{
    NSDictionary *dict = [settingDataArray objectAtIndex:0];
    
    UIButton *button = (UIButton *)sender;
    
    switch (button.tag) {
        case KmessageAll:
        {
            [dict setValue:[NSNumber numberWithInt:0] forKey:Kmessage];
            [self swithMessageButtonInTag:0];
            break;
        }
        case KmessageFriend:
        {
            [dict setValue:[NSNumber numberWithInt:1] forKey:Kmessage];
            [self swithMessageButtonInTag:1];
            break;
        }
        case KmessageProhibits:
        {
            [dict setValue:[NSNumber numberWithInt:2] forKey:Kmessage];
            [self swithMessageButtonInTag:2];
            break;
        }
            
        default:
            break;
    }

}

#pragma mark - Table view data source

//- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
//{
//    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 20)];
//    
//    return nil;
//}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    //    隐私设置
    //         评论
    //          信息
    //
    //    通知
    //      f 请求
    //     评论
    //      赠送
    //    权限请求
    //        推送通知
    //
    //    兑换信息设置
    
    //    意见反馈
    //    关于
    switch (section) {
        case 0:
        {
            return @"隐私设置";
            break;
        }
//        case 1:
//        {
//            return @"通知";
//            break;
//        }
//        case 2:
//        {
//            return @"权限请求";
//            break;
//        }
//        case 1:
//        {
//            return @"兑换信息设置";
//            break;
//        }
        case 1:
        {
            return @"软件";
            break;
        }
        default:
            break;
    }
    return nil;

}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return settingArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [(NSArray *)[settingArray objectAtIndex:section] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];

        
    }
    
//    set cell
    switch (indexPath.section ) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    _commentViewSetting.frame = CGRectMake(120, 0, _commentViewSetting.frame.size.width, _commentViewSetting.frame.size.height);
                    [cell.contentView addSubview:_commentViewSetting];
                }
                case 1:
                {
                    _messageViewSetting .frame =  CGRectMake(120, 0, _commentViewSetting.frame.size.width, _commentViewSetting.frame.size.height);
                    [cell.contentView addSubview:_messageViewSetting];
                    break;
                }
            }
            break;
        }
        case 1:
        {

            switch (indexPath.row) {
                case 0:
                {
                    
                }
            }
            break;
        }
        case 2:
        {
            break;
        }
        default:
            break;
    }
    
//    config cell
    switch (indexPath.section ) {
        case 0:
        {
            switch (indexPath.row) {
                case 0:
                {
                    
                    NSDictionary *dict = [settingDataArray objectAtIndex:indexPath.section];
                    [self swithCommentButtonInTag: [[dict objectForKey:Kcomment] integerValue]];
                    break;
                }
                case 1:
                {
                    NSDictionary *dict = [settingDataArray objectAtIndex:indexPath.section];
                    [self swithMessageButtonInTag: [[dict objectForKey:Kmessage] integerValue]];
                    break;
                }
                default:
                    break;
            }
            break;
        }
        case 1:
        {
            NSDictionary *dict = [settingDataArray objectAtIndex:indexPath.section];
//
//            UISwitch *switchControl = (UISwitch *)[_apnsViewSetting viewWithTag:KapnsSwitch];
//            [switchControl setOn:[[dict objectForKey:Kapns] integerValue]];
            switch (indexPath.row ) {
                case 0:
                {
                    cell.detailTextLabel.text = [dict objectForKey:Kyijian];

                    break;
                }
                case 1:
                {
                    cell.detailTextLabel.text = [dict objectForKey:Kxieyi];
                    break;
                }
                case 2:
                {
                    cell.detailTextLabel.text = [dict objectForKey:Kguanyu];
                    break;
                }
                default:
                    break;
            }
            
            break;
        }
        default:
            break;
    }
    

    cell.textLabel.text = [[settingArray objectAtIndex:indexPath.section] objectAtIndex:indexPath.row];

    
    
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (indexPath.section == 1) {
     
        switch (indexPath.row) {
            case 0:
            {
                
                FeedbackViewController *detailViewController = [[FeedbackViewController alloc] initWithNibName:@"FeedbackViewController" bundle:nil];
                
                
                [self.navigationController pushViewController:detailViewController animated:YES];
                [detailViewController release];
        
                break;
            }
            default:
                break;
        }

    }
}

- (void)dealloc {
    [_commentViewSetting release];
    [_apnsViewSetting release];
    [_messageViewSetting release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setCommentViewSetting:nil];
    [self setApnsViewSetting:nil];
    [self setMessageViewSetting:nil];
    [super viewDidUnload];
}

@end