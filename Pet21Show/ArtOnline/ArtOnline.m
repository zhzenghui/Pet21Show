//
//  ArtOnline.m
//  Artvotary
//
//  Created by zeng on 12-11-1.
//  Copyright (c) 2012年 zeng. All rights reserved.
//

#import "ArtOnline.h"

@implementation ArtOnline


-(id)init {
    self = [super init];
    if(self)
    {
    }
    return self;
}

-(NSMutableArray *)getArtOnlineArr{
    NSMutableArray *artOnlineArr = [NSMutableArray array];
    NSMutableString *SQL = [[NSMutableString alloc] init];
    
//    [SQL appendString:@"title,"];
//    [SQL appendString:@"desc,"];
//    [SQL appendString:@"imageUrl,"];
//    [SQL appendString:@"uid_id,"];
//    [SQL appendString:@"artType_id,"];
//    [SQL appendString:@"createDate,"];
//    [SQL appendString:@"endDate,"];
//    [SQL appendString:@"RewardAmount,"];
//    [SQL appendString:@"hotNum,"];
//    [SQL appendString:@"joinNum"];
    [SQL setString:@""];
    [SQL appendString:@"SELECT "];
    [SQL appendString:@"title, "];
    [SQL appendString:@"desc, "];
    [SQL appendString:@"imageUrl, "];
    [SQL appendString:@"uid_id, "];
    [SQL appendString:@"artType_id, "];
    [SQL appendString:@"createDate, "];
    [SQL appendString:@"endDate, "];
    [SQL appendString:@"RewardAmount, "];
    [SQL appendString:@"hotNum, "];
    [SQL appendString:@"joinNum"];
    
    [SQL appendString:@" "];
    [SQL appendString:@"FROM ArtOnline_artonline "];
    [SQL appendString:@"WHERE isdel = 0 "];
    [SQL appendString:@"ORDER BY ArtOnline_artonline.id desc "];
    
    FMResultSet *rs = [myDB executeQuery:SQL];
    
    while ([rs next])
    {
        NSMutableDictionary *tmpDict = [[NSMutableDictionary alloc] init];
        
        [tmpDict setValue:[rs stringForColumn:KonlineTitle] forKey:KonlineTitle];
        [tmpDict setValue:[rs stringForColumn:KonlineDesc] forKey:KonlineDesc];
        [tmpDict setValue:[rs stringForColumn:KonlineImage] forKey:KonlineImage];
        [tmpDict setValue:[rs stringForColumn:KonlineUser] forKey:KonlineUser];

        [tmpDict setValue:[rs stringForColumn:KonlineTag] forKey:KonlineTag];
        [tmpDict setValue:[rs stringForColumn:KonlineDate] forKey:KonlineDate];
        [tmpDict setValue:[rs stringForColumn:KonlineEndDate] forKey:KonlineEndDate];
        [tmpDict setValue:[rs stringForColumn:KonlineRewardAmount] forKey:KonlineRewardAmount];
        [tmpDict setValue:[rs stringForColumn:KonlineHotNum] forKey:KonlineHotNum];
        [tmpDict setValue:[rs stringForColumn:KonlineJoinNum] forKey:KonlineJoinNum];
        
        [artOnlineArr addObject:tmpDict];
        [tmpDict release];
    }	
    [rs close];
    [SQL release];
    return artOnlineArr;
}

-(BOOL)addArtOnline:(NSDictionary *)artOnline
{

    NSMutableString *SQL = [[NSMutableString alloc] init];

    [SQL setString:@"INSERT INTO "];
    [SQL appendString:@"ArtOnline_artonline( "];

    [SQL appendString:@"title,"];    
    [SQL appendString:@"desc,"];
    [SQL appendString:@"imageUrl,"];
    [SQL appendString:@"uid_id,"];
    [SQL appendString:@"artType_id,"];
    [SQL appendString:@"createDate,"];
    [SQL appendString:@"endDate,"];
    [SQL appendString:@"RewardAmount,"];
    [SQL appendString:@"hotNum,"];
    [SQL appendString:@"joinNum"];    
    
    
    [SQL appendString:@") VALUES( "];
    
    [SQL appendString:[NSString stringWithFormat:@"'%@',", [artOnline objectForKey:KonlineTitle]]];
    [SQL appendString:[NSString stringWithFormat:@"'%@',", [artOnline objectForKey:KonlineDesc]]];
    [SQL appendString:[NSString stringWithFormat:@"'%@',", [artOnline objectForKey:KonlineImage]]];
    [SQL appendString:[NSString stringWithFormat:@"'%@',", [artOnline objectForKey:KonlineUser]]];
    [SQL appendString:[NSString stringWithFormat:@"'%@',", [artOnline objectForKey:KonlineDate]]];
    [SQL appendString:[NSString stringWithFormat:@"'%@',", [artOnline objectForKey:KonlineDate]]];
    [SQL appendString:[NSString stringWithFormat:@"'%@',", [artOnline objectForKey:KonlineEndDate]]];
    [SQL appendString:[NSString stringWithFormat:@"'%@',", [artOnline objectForKey:KonlineRewardAmount]]];
    [SQL appendString:[NSString stringWithFormat:@"'0',"]];
    [SQL appendString:[NSString stringWithFormat:@"'0'"]];
    
    [SQL appendString:@") "];
    [myDB executeUpdate:SQL];
    
    
    [SQL release];
    
    return YES;
}

@end
