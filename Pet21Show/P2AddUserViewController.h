//
//  P2AddUserViewController.h
//  PetShows
//
//  Created by zeng on 12-8-10.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum _EI_USERVIEW_STATUE
{
    EI_USERVIEW_STATUE_CRATE = 1,
    EI_USERVIEW_STATUE_LOGIN = 2,

}EI_USERVIEW_STATUE;

typedef enum _EI_NETWORK
{
    EI_NETWORK_CHECKEMAIL =0,
    EI_NETWORK_CHECKEUSERNAME =1,
}EI_NETWORK;

@interface P2AddUserViewController : UIViewController <UITextFieldDelegate>
{
    EI_USERVIEW_STATUE ei_userview_statue;
    EI_NETWORK ei_network;
    
    UITextField *myTextField;
    
    NSMutableDictionary *errors;
}



@end
