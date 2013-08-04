//
//  Calculator.h
//  EiPhone
//
//  Created by gao guilong on 10-1-11.
//  Copyright 2010 encompass. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Calculator : NSObject {
}
double transform(char [],int );
void del(char* ,char *);
void del2(double [],int );
void convert(char [],char *,char *);
double jisuan(char str[]);
+(double)AutoCalculator:(NSString *)txtStr;

@end


