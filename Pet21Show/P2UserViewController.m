//
//  P2UserViewController.m
//  LifeLine
//
//  Created by zeng on 12-10-28.
//  Copyright (c) 2012年 zeng. All rights reserved.
//



#import "P2UserViewController.h"
#import "MeCell.h"
#import "P2ExchangViewController.h"

@interface P2UserViewController ()

@end

@implementation P2UserViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (IBAction)exchanggeGold:(id)sender
{
    P2ExchangViewController *exchangeVC = [[P2ExchangViewController alloc] init];
    
    [self.navigationController pushViewController:exchangeVC animated:YES];
    
    [exchangeVC release];
}

- (IBAction)setting:(id)sender
{
    
}

#pragma mark - tabBarController

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
//    self.parentViewController.tabBarItem.badgeValue = @"0";
}

#pragma mark - life cycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    

    
    
//    self.navigationItem.leftBarButtonItem = BARBUTTON(@"设置", @selector(setting:));
    self.navigationItem.rightBarButtonItem = BARBUTTON(@"门兑换", @selector(exchanggeGold:));
    
    userMessageArray = [[NSMutableArray alloc] init];

    
    self.navigationItem.title = NSLocalizedString(@"我的Art", @"");
    self.titleLable.text = NSLocalizedString(@"我的Art", @"");
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"一对一" forKey:KmessageType];
    [dict setValue:@"我要邀请你" forKey:KmessageTitle];
    [dict setValue:@"2" forKey:KmessageCount];
    
    NSMutableDictionary *dict1 = [NSMutableDictionary dictionary];
    [dict1 setValue:@"小组" forKey:KmessageType];
    [dict1 setValue:@"我的小组" forKey:KmessageTitle];
    [dict1 setValue:@"3" forKey:KmessageCount];
    
    NSMutableDictionary *dict2 = [NSMutableDictionary dictionary];
    [dict2 setValue:@"活动" forKey:KmessageType];
    [dict2 setValue:@"我的活动" forKey:KmessageTitle];
    [dict2 setValue:@"12" forKey:KmessageCount];
    
    NSMutableDictionary *dict3 = [NSMutableDictionary dictionary];
    [dict3 setValue:@"账户" forKey:KmessageType];
    [dict3 setValue:@"我的金库" forKey:KmessageTitle];
    [dict3 setValue:@"120" forKey:KmessageCount];
    
    [userMessageArray addObject:dict];
    [userMessageArray addObject:dict1];
    [userMessageArray addObject:dict2];
    [userMessageArray addObject:dict3];
    
   

}

- (void)viewWillAppear:(BOOL)animated
{
    
}


- (void)viewDidAppear:(BOOL)animated
{
     self.parentViewController.tabBarItem.badgeValue = nil;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{

    [super dealloc];
    [userMessageArray release];
}

#pragma mark - Table view data source

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    //    NSLog(@"%d", indexPath.row);
    //    NSDictionary *statusInfo = [statuses objectAtIndex:indexPath.row];
    //
    //    NSDictionary *statusFieldInfo = [statusInfo objectForKey:@"fields"];
    //
    //    NSString *text = [statusFieldInfo objectForKey:@"text"];
    //
    //    CGSize constraint = CGSizeMake(CELL_CONTENT_WIDTH - (CELL_CONTENT_MARGIN * 2), 20000.0f);
    //
    //    CGSize size = [text sizeWithFont:[UIFont systemFontOfSize:FONT_SIZE] constrainedToSize:constraint lineBreakMode:UILineBreakModeWordWrap];
    //
    //    CGFloat height = MAX(size.height, 44.0f);
    //
    //    if (YES) {
    //        height += CELLIMAGEHEITH;
    //    }
    
    //    return height + (CELL_CONTENT_MARGIN * 2) ;
    
    return 47;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [userMessageArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    MeCell *cell = (MeCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"MeCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (MeCell *) currentObject;
                break;
            }
        }
    }
    
    cell.titleLable.text = [[userMessageArray objectAtIndex:indexPath.row] objectForKey:KmessageTitle];
    cell.numberLabel.text = [NSString stringWithFormat:@"(%@)",
                             [[userMessageArray objectAtIndex:indexPath.row]
                              objectForKey:KmessageCount]];
    [cell.souceTypeButton setTitle:[[userMessageArray objectAtIndex:indexPath.row] objectForKey:KmessageType] forState:UIControlStateNormal];
    return cell;
}

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
    
    
}

@end
