//
//  P2NewOnLineViewController.m
//  LifeLine
//
//  Created by zeng on 12-9-29.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "P2NewOnLineViewController.h"
#import "ArtOnline.h"

@interface P2NewOnLineViewController ()


@end

@implementation P2NewOnLineViewController


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    } 
    return self;
}

- (BOOL)checkInputInfo
{

    [_titleTextField resignFirstResponder];
    if (_titleTextField.text.length == 0) {
        return false;
    }
    
    [_descTextView resignFirstResponder];
    if (_descTextView.text.length == 0) {
        return false;
    }

    return true;
}


#pragma mark - _SYNC_SERVER_PACKET_RECORD

- (void)getDBList_CallBack:(ASIFormDataRequest *)request
{
    NSLog(@"%@", request.responseString);
    
    UIWebView *web = [[UIWebView alloc] initWithFrame:CGRectMake(0, 0, 299, 299)];
    [web loadHTMLString:request.responseString baseURL:nil];
    
    [self.view addSubview:web];
    
    
    
    if (request.responseStatusCode == 200) {
        if ([request.responseString isEqualToString:@"t"]) {
//            alertShow(@"提示", @"添加活动成功", @"好")
//            [self.navigationController popViewControllerAnimated:YES];
        }
//
//        statuses = (NSMutableArray *)[request.responseString objectFromJSONString];
//        [statuses retain];
//        
//        [self initAppcord];
//        [myTableView reloadData];
//        NSLog(@"%@", statuses);
    }
//    else {
//        NSLog(@"%@", request.responseString);
//        UIWebView *webV = [[UIWebView alloc]initWithFrame:screenSize];
//        
//        [webV loadHTMLString:request.responseString baseURL:nil];
//        [self.view addSubview:webV];
//        [webV release];
//    }
}


- (IBAction)getDBListFail_CallBack:(id)sender
{
    
}


- (void)netWork
{
    struct _SYNC_SERVER_PACKET_RECORD *P_SYNC_SERVER_PACKET_RECORD = (struct _SYNC_SERVER_PACKET_RECORD *)malloc(sizeof(struct _SYNC_SERVER_PACKET_RECORD));
    
    P_SYNC_SERVER_PACKET_RECORD -> delegate = self;
    P_SYNC_SERVER_PACKET_RECORD -> progressIndicator = nil;
    P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFinishSelector = @selector(getDBList_CallBack:);
    P_SYNC_SERVER_PACKET_RECORD -> action = SERVER_ACTIONS_ADDONLINE;
    P_SYNC_SERVER_PACKET_RECORD -> setRequestDidFailSelector = @selector(getDBListFail_CallBack:);
    P_SYNC_SERVER_PACKET_RECORD -> dataDict = onlineDict;
    
    DataProcess *myDataProcess = [[DataProcess alloc] init];
    
    [myDataProcess SyncServer:SERVER_ACTIONS_ADDONLINE syncServerPackedRecord:P_SYNC_SERVER_PACKET_RECORD];

}

- (IBAction)newOnline:(id)sender
{
//    title
    if ([self checkInputInfo]) {
        
        [onlineDict setValue:[EscopeString escope:_titleTextField.text] forKey:KonlineTitle];
        [onlineDict setValue:[EscopeString escope:_descTextView.text] forKey:KonlineDesc];
        [onlineDict setValue:[EscopeString escope:@"adfadf"] forKey:KonlineImage];
        [onlineDict setValue:[NSString stringWithFormat:@"0"] forKey:KonlineHotNum];
        [onlineDict setValue:[NSString stringWithFormat:@"0"] forKey:KonlineJoinNum];
        [onlineDict setValue:[NSString stringWithFormat:@"1"] forKey:KonlineTag];

        [onlineDict setValue:@"1" forKey:KonlineRewardAmount];
        [onlineDict setValue:[Session getSession:@"id"] forKey:KonlineUser];
        
        ArtOnline *online = [[ArtOnline alloc] init];
        
        if ([online addArtOnline:onlineDict]) {
            
            [self netWork];
        }
        else {
            
        }
        
        [online release];
    }
}

- (void)initRewardView
{
    [self.view addSubview:_rewardView];
    _rewardView .alpha = 0;
    
}
- (void)initTagView
{
//    _tagScrollView.frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
//    [_tagScrollView addSubview:_tagView];
//    [_tagScrollView setContentSize:_tagView.frame.size];

//    [self.view addSubview:_tagScrollView];
//    _tagScrollView.alpha = 0;

    [self.view addSubview:_tagView];
    _tagView.alpha = 0;

}

-(void)dateChanged:(id)sender{
    UIDatePicker* control = (UIDatePicker*)sender;
    NSDate* _date = control.date;
    NSLog(@"%@", _date);

    endDate = [[NSDate alloc] initWithTimeInterval:0 sinceDate:_date];
}
- (void)initDateView
{
//    NSDate* _date = [NSDate date];
//    endDate = _date;
//    
//    
//    UIDatePicker *datePicker = [ [ UIDatePicker alloc] initWithFrame:CGRectMake(0.0,0.0,0.0,0.0)];
//    datePicker.datePickerMode = UIDatePickerModeDate;
//    
//    NSDate* minDate = [NSDate date];
//    NSDate* maxDate = [NSDate dateWithTimeInterval:604800 sinceDate:_date];
//
//    
//    
//    datePicker.minimumDate = minDate;
//    datePicker.maximumDate = maxDate;
//    
//    datePicker.date = _date;
//    
//    [ datePicker addTarget:self action:@selector(dateChanged:) forControlEvents:UIControlEventValueChanged ];
//    
//    [_dateView addSubview:datePicker];
    [self.view addSubview:_dateView];
    _dateView.alpha = 0;
    
    
}

- (void)initPicView
{
    [self.view addSubview:_camaryView];
    _camaryView.alpha = 0;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self.view addSubview:_newOnlineView];
    
//    self.navigationItem.title = NSLocalizedString(@"活动", @"");
    self.titleLable.text = NSLocalizedString(@"新活动", @"");
    
    self.navigationItem.rightBarButtonItem  = BARBUTTON(NSLocalizedString(@"创建", @""), @selector(newOnline:));
    
    onlineDict = [[NSMutableDictionary alloc] init];

    [onlineDict setValue:@"1" forKey:KonlineEndDate];
    [onlineDict setValue:@"照片" forKey:KonlineTag];
    [onlineDict setValue:@"0,0" forKey:KonlineRewardAmount];
    
    [self initRewardView];
    [self initTagView];

    [self initDateView];
    [self initPicView];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [_newOnlineView release];
    [_titleTextField release];
    [_descTextView release];
    [_rewardView release];
    [_rewardButton release];
    [_tagScrollView release];
    [_tagView release];
    [_tagButton release];
    [_dateView release];

    [_endTimeButton release];
    [_imageButton release];
    [_camaryView release];
    [endDate release];
    [_imgView release];
    [super dealloc];
}
- (void)viewDidUnload {
    [self setNewOnlineView:nil];
    [self setTitleTextField:nil];
    [self setDescTextView:nil];
    [self setRewardView:nil];
    [self setRewardButton:nil];
    [self setTagScrollView:nil];
    [self setTagView:nil];
    [self setTagButton:nil];
    [self setDateView:nil];
    [self setEndTimeButton:nil];
    [self setImageButton:nil];
    [self setCamaryView:nil];

    [self setImgView:nil];
    [super viewDidUnload];
}

#pragma mark - textview
- (void)textViewDidBeginEditing:(UITextView *)textView
{
    self.view .frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    [UIView animateWithDuration:.4 animations:^{
        self.view .frame = CGRectMake(0, -80, self.view.frame.size.width, self.view.frame.size.height);
    }];
}
- (void)textViewDidEndEditing:(UITextView *)textView
{
    [UIView animateWithDuration:.4 animations:^{
        self.view .frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    }];
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    return YES;
}
#pragma mark - textfiled
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return NO;
}

#pragma mark -

- (IBAction)chooseTag:(id)sender
{
    UIButton *button = (UIButton *)sender;
    
    [_tagButton setTitle:button.titleLabel.text forState:UIControlStateNormal];
    
    
    [UIView animateWithDuration:.3 animations:^{
        _tagView.alpha = 0;
    }];
    
    //    数据
    
    [onlineDict setValue:[NSString stringWithFormat:@"1"] forKey:KonlineTag];
}

- (IBAction)endTime:(id)sender
{
//    NSString *dateContent= [Date currentdateToDate:endDate];
    UIButton *button = (UIButton *)sender;
    
    NSString *endTimeString = button.titleLabel.text;
    NSString *endTimeData = nil;
    if ([endTimeString isEqualToString:@"一天"]) {
        endTimeData = @"1";
    }
    else if([endTimeString isEqualToString:@"二天"]) {
        endTimeData = @"2";
    }
    else if([endTimeString isEqualToString:@"三天"]) {
        endTimeData = @"3";
    }
    else if([endTimeString isEqualToString:@"一周"]) {
        endTimeData = @"7";
    }
    else if([endTimeString isEqualToString:@"十天"]) {
        endTimeData = @"10";        
    }
    [_endTimeButton setTitle:endTimeString forState:UIControlStateNormal];

    [onlineDict setValue:endTimeData forKey:KonlineEndDate];
    [UIView animateWithDuration:.3 animations:^{
        
        _dateView.alpha = 0;
    }];
}

- (IBAction)takePic:(id)sender
{
    UIImagePickerController *aImagePickerController = [[UIImagePickerController alloc] init];
    aImagePickerController.delegate = self;
    aImagePickerController.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentModalViewController:aImagePickerController animated:YES];
    [aImagePickerController release];
    
    [UIView animateWithDuration:.3 animations:^{
        
        _camaryView.alpha = 0;
    }];
}

- (IBAction)camaryPic:(id)sender {
    if ([UIImagePickerController availableMediaTypesForSourceType:UIImagePickerControllerSourceTypeCamera]) {
        
        EICameraImageController *cameraImageView = [[EICameraImageController alloc] initWithNibName:@"EICameraImageView" bundle:nil];
        cameraImageView.showCamera = YES;
//        cameraImageView.viewType = ;
//        cameraImageView.surveyAnswerId = self.surveyAnswerId;
        [self.navigationController pushViewController:cameraImageView animated:YES];
        [cameraImageView release];
        

        
		}
		else {
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:nil
                                                            message:NSLocalizedString(@"This device dose not support a camera", @"")
                                                           delegate:self
                                                  cancelButtonTitle:@"OK"
                                                  otherButtonTitles:nil];
        [alertView show];
        [alertView release];
		}

}

- (IBAction)canclePic:(id)sender
{
    [UIView animateWithDuration:.3 animations:^{
        
        _camaryView.alpha = 0;
    }];
}

- (void)resignFirstResponderTT:(id)sender;
{
    [_titleTextField resignFirstResponder];
    [_descTextView resignFirstResponder];
}

- (IBAction)allTagEvent:(id)sender
{
    [self resignFirstResponderTT:nil];
    UIButton *button = sender;
    switch (button.tag) {
        case 21:
        {
            [UIView animateWithDuration:.3 animations:^{
                
                _tagView.alpha = 1;
            }];
            break;
        }
        case 22:
        {
            [UIView animateWithDuration:.3 animations:^{
                
                _rewardView.alpha = 1;
            }];
            break;
        }
        case 23:
        {
            [UIView animateWithDuration:.3 animations:^{
                
                _dateView.alpha = 1;
            }];
            break;
        }
        case 24:
        {
            [UIView animateWithDuration:.3 animations:^{
                
                _camaryView.alpha = 1;
            }];
            break;
        }
        default:
            break;
    }
}


- (IBAction)rewardAmount:(id)sender
{
  
    NSString *amount = nil;
    int type = 0;
    int x = 0;
    
    UIButton *button = (UIButton *)sender;
    
    switch (button.tag) {
        case 1:
        {
            type = 0;
            x = 0;
            break;
        }
        case 2:
        {
            type = 1;
            x = 5;
            break;
        }
        case 3:
        {
            type = 1;
            x = 10;
            break;
        }
        case 4:
        {
            type = 100;
            x = 5;
            break;
        }
        case 5:
        {
            type = 100;            
            x = 10;
            break;
        }
        default:
            break;
    }
    
    amount = [NSString stringWithFormat:@"%d,%d", type, x];
    [onlineDict setValue:amount forKey:KonlineRewardAmount];
    
    if (type == 1) {
        
        [_rewardButton setTitle: [NSString stringWithFormat:@"银色 %d", x] forState:UIControlStateNormal];
    }
    else if (type == 100) {

        [_rewardButton setTitle: [NSString stringWithFormat:@"金色 %d", x] forState:UIControlStateNormal];
    }
    else {
        [_rewardButton setTitle: [NSString stringWithFormat:@"无奖励"] forState:UIControlStateNormal];    
    }

    [UIView animateWithDuration:.3 animations:^{
        
        _rewardView.alpha = 0;
    }];
}

#pragma mark UIImagePickerController Delegate Methods
//返回选取的图片
- (void)imagePickerController:(UIImagePickerController *)picker
        didFinishPickingImage:(UIImage *)image
                  editingInfo:(NSDictionary *)editingInfo {
//    [_imageButton setBackgroundImage:image forState:UIControlStateNormal];
    AGViewController *agViewController = [[AGViewController alloc] init];
    agViewController.image = image;
    agViewController.delegate = self;
    [self.navigationController pushViewController:agViewController animated:YES ];
    
    [agViewController release];
    
//    [_imageButton setImage:image forState:UIControlStateNormal];
    [_imageButton setTitle:@"" forState:UIControlStateNormal];
    [picker dismissModalViewControllerAnimated:YES];
}
//选取结束时调用
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker {
    [picker dismissModalViewControllerAnimated:YES];
}

//updateImageButton
- (void)saveImage:(UIImage *)clipImage
{
    NSLog(@"%f,%f", clipImage.size.width,clipImage.size.height);
//    320
//    640
//    原图
    [self.view setBackgroundColor:[UIColor colorWithPatternImage:clipImage]];
    _imgView.image = clipImage  ;
}

@end
