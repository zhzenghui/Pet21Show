//
//  DataProcess.h
//  LifeLine
//
//  Created by zeng on 12-8-18.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "P2PetShow_Utility.h"

@interface DataProcess : NSObject
{
//	NSString *serverURL;
	//EIConfiguration *myConfig;
    
    NSString *uid ;
}

@property (nonatomic,retain) NSString *serverURL;
//@property (nonatomic,retain) EIConfiguration *myConfig;

- (void)ProcessAction:(EI_IP_ACTIONS) action obj:(id)obj;

- (void)SyncServer:(EI_SERVER_ACTIONS)serverAction syncServerPackedRecord:(struct _SYNC_SERVER_PACKET_RECORD *)syncServerPackedRecord;

@end
