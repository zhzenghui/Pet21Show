//
//  P2RoomViewController.m
//  LifeLine
//
//  Created by zeng on 12-9-29.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2RoomViewController.h"
#import "OneToOneCell.h"


@interface P2RoomViewController ()

@end

@implementation P2RoomViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        dispatch_queue_t downloadQueue = dispatch_queue_create("image downloader", NULL);
        dispatch_async(downloadQueue, ^{
//            NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:@""]];
            dispatch_sync(dispatch_get_main_queue(), ^{
                self.view.backgroundColor = [UIColor redColor];
            });

        });
        
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    self.navigationItem.title = NSLocalizedString(@"一对一", @"");    
    self.navigationItem.rightBarButtonItem  = BARBUTTON(@"邀请艺术家", @selector(addBankInfo:));
    
    roomInfoArray = [[NSMutableArray alloc] init];
    
    
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    [dict setValue:@"A" forKey:KroomA];
    [dict setValue:@"B" forKey:KroomB];
    [dict setValue:@"1000" forKey:KroomPayAmount];
    
    [roomInfoArray addObject:dict];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    return 57;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [roomInfoArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    OneToOneCell *cell = (OneToOneCell *) [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        
        NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"OneToOneCell" owner:self options:nil];
        
        for (id currentObject in topLevelObjects){
            if ([currentObject isKindOfClass:[UITableViewCell class]]){
                cell =  (OneToOneCell *) currentObject;
                break;
            }
        }
    }
    NSDictionary *dict = [roomInfoArray objectAtIndex:indexPath.row];
    
    [cell.InviteesUserButton setTitle:[NSString stringWithFormat:@"@%@",
                                       [dict objectForKey:KroomA]]
                             forState:UIControlStateNormal];
    [cell.toBeInviteesUserButton setTitle:[NSString stringWithFormat:@"@%@", [dict objectForKey:KroomB]] forState:UIControlStateNormal];
    cell.payAmountLable.text =[NSString stringWithFormat:@"%@", [dict objectForKey:KroomPayAmount]];

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
