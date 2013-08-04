//
//  P2DetailOLViewController.m
//  Artvotary
//
//  Created by zeng on 12-11-18.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2DetailOLViewController.h"
#import "DetailOnLineCell.h"
#import "DetailOnlineCollectionCell.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import <SDWebImage/UIButton+WebCache.h>

#define OnlineCollectionRowHight 110
#define OnlineRowHight 406

@interface P2DetailOLViewController ()

@end

@implementation P2DetailOLViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}




#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    switch (tableViewModel) {
        case DetailOnLineCellModel:
            return OnlineRowHight;
            break;
        case DetailOnlineCollectionCellModel:
            return OnlineCollectionRowHight;
            break;
        default:
            break;
    }
    return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    switch (tableViewModel) {
        case DetailOnLineCellModel:
        {
            return [_detailDataArray count];
            break;
        }
        case DetailOnlineCollectionCellModel:
        {

            return [_detailDataArray count]/3;
            break;
        }
        default:
            return 0;
            break;
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    switch (tableViewModel) {
        case DetailOnLineCellModel:
        {
            static NSString *CellIdentifier = @"Cell";
            
            DetailOnLineCell *cell = (DetailOnLineCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailOnLineCell" owner:self options:nil];
                
                for (id currentObject in topLevelObjects){
                    if ([currentObject isKindOfClass:[UITableViewCell class]]){
                        cell =  (DetailOnLineCell *) currentObject;
                        break;
                    }
                }
            }
            
            NSString *dict = [_detailDataArray objectAtIndex:indexPath.row];
            
            [cell.userButton  setImageWithURL:[NSURL URLWithString:dict]
                             placeholderImage:[UIImage imageNamed:@"Info-AvatarSmall-Frame"]];
            
            dict = [dict stringByReplacingOccurrencesOfString:@"small" withString:@"source"];
            [cell.onlineImageView setImageWithURL:[NSURL URLWithString:dict]
                                 placeholderImage:[UIImage imageNamed:@"Info-AvatarSmall-Frame"]];
            [cell.userNameButton setTitle:dict forState:UIControlStateNormal];
            [cell.descLabel setText:dict];
            [cell.dateTimeLabel setText:dict];
            
            return cell;
            break;
        }
        case DetailOnlineCollectionCellModel:
        {
            
            static NSString *CellIdentifier = @"DetailOnlineCollectionCell";

            DetailOnlineCollectionCell *cell = (DetailOnlineCollectionCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
            if (cell == nil) {
                
                NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"DetailOnlineCollectionCell" owner:self options:nil];
                
                for (id currentObject in topLevelObjects){
                    if ([currentObject isKindOfClass:[UITableViewCell class]]){
                        cell =  (DetailOnlineCollectionCell *) currentObject;
                        break;
                    }
                }

                UIImage *i = [UIImage imageNamed:@"info-OnlineDetailCellBackground"];
                cell.backgroundColor = [UIColor colorWithPatternImage:i];
            }
            
            int i = indexPath.row *3;
            
            NSString *dict1 = [_detailDataArray objectAtIndex:i];
            NSString *dict2 = [_detailDataArray objectAtIndex:i+1];
            NSString *dict3 = [_detailDataArray objectAtIndex:i+2];
//            [cell.userButton  setImageWithURL:[NSURL URLWithString:dict]
//                             placeholderImage:[UIImage imageNamed:@"Info-AvatarSmall-Frame"]];
//            
//            dict = [dict stringByReplacingOccurrencesOfString:@"small" withString:@"source"];
//            [cell.onlineImageView setImageWithURL:[NSURL URLWithString:dict]
//                                 placeholderImage:[UIImage imageNamed:@"Info-AvatarSmall-Frame"]];
//            [cell.userNameButton setTitle:dict forState:UIControlStateNormal];
//            [cell.descLabel setText:dict];
//            [cell.dateTimeLabel setText:dict];
//

            [cell.leftImageView setImageWithURL:[NSURL URLWithString:dict1]
                                 placeholderImage:[UIImage imageNamed:@"Info-AvatarSmall-Frame"]];
            [cell.centerImageView setImageWithURL:[NSURL URLWithString:dict2]
                               placeholderImage:[UIImage imageNamed:@"Info-AvatarSmall-Frame"]];
            [cell.rightImageView setImageWithURL:[NSURL URLWithString:dict3]
                               placeholderImage:[UIImage imageNamed:@"Info-AvatarSmall-Frame"]];
            return cell;

            break;
        }
        default:
            break;
    }
    
    return nil;
}

#pragma mark - Table view delegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
//- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//
//    UIView *footView = [[[UIView alloc] init] autorelease];
//    return footView;
//}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    

    
}


- (IBAction)backMain:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
- (IBAction)vizmodeToggle:(id)sender
{
    

    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
    
    UIImage* image2= nil;
    if (tableViewModel == DetailOnLineCellModel) {
        tableViewModel = DetailOnlineCollectionCellModel;
        
        image2= [UIImage imageNamed:@"Info-VizmodeToggle"];
        
        
        CGFloat row = (_tableView.contentOffset.y /OnlineRowHight)/3;
        indexPath = [NSIndexPath indexPathForRow:row inSection:0];
        

    }
    else {
        tableViewModel = DetailOnLineCellModel;

        image2= [UIImage imageNamed:@"Info-ListToggle"];
        
        
        CGFloat row = (_tableView.contentOffset.y / OnlineCollectionRowHight)*3;
        indexPath = [NSIndexPath indexPathForRow:row inSection:0];
    }
    
    
    [_tableView reloadData];
    [_tableView scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:NO];
    
    
    
    
    CGRect frame_2= CGRectMake(0, 0, image2.size.width+30, image2.size.height-4);
    UIButton* backButton2= [[UIButton alloc] initWithFrame:frame_2];
    [backButton2 setImage:image2 forState:UIControlStateNormal];
    [backButton2 setTitle:@"返回" forState:UIControlStateNormal];
    [backButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton2.titleLabel.font=[UIFont systemFontOfSize:16];
    [backButton2 addTarget:self action:@selector(vizmodeToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* someBarButtonItem2= [[UIBarButtonItem alloc] initWithCustomView:backButton2];
    [self.navigationItem setRightBarButtonItem:someBarButtonItem2];
    [someBarButtonItem2 release];
    [backButton2 release];
    

}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
//    Aii
    UIImage* image= [UIImage imageNamed:@"NavBar-Button-Back-Active"];
    CGRect frame_1= CGRectMake(0, 0, image.size.width+30, image.size.height-4);
    UIButton* backButton= [[UIButton alloc] initWithFrame:frame_1];
    [backButton setImage:image forState:UIControlStateNormal];
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton.titleLabel.font=[UIFont systemFontOfSize:16];
    [backButton addTarget:self action:@selector(backMain:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* someBarButtonItem= [[UIBarButtonItem alloc] initWithCustomView:backButton];
    [self.navigationItem setLeftBarButtonItem:someBarButtonItem];
    [someBarButtonItem release];
    [backButton release];
    
    UIImage* image2= [UIImage imageNamed:@"Info-ListToggle"];
    CGRect frame_2= CGRectMake(0, 0, image2.size.width+30, image2.size.height-4);
    UIButton* backButton2= [[UIButton alloc] initWithFrame:frame_2];
    [backButton2 setImage:image2 forState:UIControlStateNormal];
    [backButton2 setTitle:@"返回" forState:UIControlStateNormal];
    [backButton2 setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    backButton2.titleLabel.font=[UIFont systemFontOfSize:16];
    [backButton2 addTarget:self action:@selector(vizmodeToggle:) forControlEvents:UIControlEventTouchUpInside];
    
    UIBarButtonItem* someBarButtonItem2= [[UIBarButtonItem alloc] initWithCustomView:backButton2];
    [self.navigationItem setRightBarButtonItem:someBarButtonItem2];
    [someBarButtonItem2 release];
    [backButton2 release];
    
    tableViewModel = DetailOnLineCellModel;
    
    
    
//    table set
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:YES];
    [_tableView scrollToRowAtIndexPath:_indexPath atScrollPosition:UITableViewScrollPositionTop animated:YES];
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_tableView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setTableView:nil];
    [super viewDidUnload];
}
@end
