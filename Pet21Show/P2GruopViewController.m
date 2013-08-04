//
//  P2GruopViewController.m
//  LifeLine
//
//  Created by zeng on 12-10-28.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2GruopViewController.h"
#import "GroupCell.h"


@interface P2GruopViewController ()

@end

@implementation P2GruopViewController

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
    
    
    self.navigationItem.title = NSLocalizedString(@"小组", @"");
    self.navigationItem.rightBarButtonItem  = BARBUTTON(NSLocalizedString(@"创建新组题", @""), @selector(addBankInfo:));
    
    groupInfoArray = [[NSMutableArray alloc] init];
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"Placeholder" forKey:KgroupImage];
    [dict setValue:@"标题" forKey:KgroupTitle];
    [dict setValue:@"32" forKey:KgroupPayAmount];
    [dict setValue:@"7:21:23" forKey:KgroupDate];
    [dict setValue:@"zeng" forKey:KgroupUser];
    [dict setValue:@"内容的解释" forKey:KgroupDesc];
    
    
    [groupInfoArray addObject:dict];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    [groupInfoArray release];
    
    
    [super dealloc];
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
    
    return 89;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [groupInfoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    GroupCell *cell = (GroupCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"GroupCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (GroupCell *) currentObject;
                break;
            }
        }
    }
  
    NSDictionary *dict = [groupInfoArray objectAtIndex:indexPath.row];
        
    cell.imgView.image  = [UIImage imageNamed: [dict objectForKey:KgroupImage]];
    cell.titleLabel.text = [dict objectForKey:KgroupTitle];
    cell.descLabel.text = [dict objectForKey:KgroupDesc];
    cell.payAmount.text = [dict objectForKey:KgroupPayAmount];
    cell.dateLabel.text = [dict objectForKey:KgroupDate];
    [cell.userButton setTitle:[NSString stringWithFormat:@"@%@",[dict objectForKey:KgroupUser]] forState:UIControlStateNormal];

    

    
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
