//
//  Fmt.h
//  EiPhone
//
//  Created by zeus on 12/4/09.
//  Copyright 2009 Encompass. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface BC_Fmt : NSObject 
{

}

+ (id) Null2Zero:(id)myVal;
+ (id) Null2EmptyStr:(id)myVal;
//+ (NSString *) FormatPhone:(id)myVal;
+ (NSString *)Left:(id)myVal length:(int)length;
+ (NSString *)Right:(id)myVal length:(int)length;
+ (NSString *)trim:(NSString *)tNSString;//trim
+ (NSString *)FormatCurrency:(NSString*)money withDecimalDigits:(int)bit;
+ (NSString *)FormatCurrencyImp:(NSString*)money withDecimalDigits:(int)bit;
+ (NSString *)FormatCurrencyWithoutUSD:(NSString*)money withDecimalDigits:(int)bit;
+ (NSString *)FormatNumber:(NSString*)number withDecimalDigits:(int)bit;
+ (BOOL)isDate:(NSString *)dateStr;
+ (BOOL)RegExpMatch:(NSString *)string withPattern:(NSString*)pattern;
+ (BOOL)isNumeric:(id)val;
+ (BOOL)isNumber:(id)val;
+ (NSString *)FormatData:(id)myValue DataType:(NSString *)DataType Length:(int)Length;
+ (int)DateDiff:(NSString *)interval Date1:(NSString *)date1 Date2:(NSString *)date2;
+ (NSString *)DateAdd:(NSString *)interval Date1:(int)date1 Date2:(NSString *)date2;
+ (NSString *)Zero2Empty:(NSNumber *)num;
+ (NSDate *)StringFormatToDate:(NSString *)strDate;
+ (NSString *)DateFormatToString:(NSDate *)date;
+ (BOOL)isPhone:(NSString*)PhoneCode;
+ (NSNumber *)StringToNumber:(NSString *)string;
+ (NSString *)NumberToString:(NSNumber *)number;
+ (NSString *)StringFormatDate:(NSString *)strDate;
+ (NSString *)FormatDate:(NSString *)strDate withTime:(BOOL)withTime;
+ (NSString *)FormatDateForEncompass:(NSString *)strDate Style:(BOOL)style;
+ (NSString *)InterceptionDecimalEndZero:(NSString *)decimalStr;
+ (BOOL)IsString:(NSString *)myStr OnlyExistOfChars:(NSArray *)charsArray;
+ (NSString *)NumComp:(NSString *)myVal;
+ (NSString*)FormatPhone:(NSString*)myVal;
+(NSString *)SubString:(NSString *)myVal startIndex:(int)startIndex length:(int)length;
+(NSString *)fdate:(NSString *)Value;
+(NSString *)getComponentFromDate:(NSDate *)dateValue component:(NSString *)component offset:(int)offset;

//--used for color
+(UIColor *)colorWithRGBIntegers:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha;
+(int)ConvertCharFrom16to10:(NSString *)str;
+(UIColor *)getColorByRGBstr:(NSString *)rgbstr;

+ (NSString *)addSpaceInString:(NSString *)sourceStr lineLength:(int)lineLength;
+ (NSString *)CustomerFormatData:(id)myValue DataType:(NSString *)DataType Length:(int)Length;
+ (BOOL)checkUPC:(NSString *)UPCCode;
+ (NSString*)FormatNegativeData:(NSString*)sourceStr;

+ (NSString*)getLocaleTime;
+ (NSString*)FormatMoney:(NSString*)value;
+ (NSString*)FormatDateToLongDate:(NSString *)dateStr Style:(BOOL)style;
+ (int)getMonthWeekday:(CFGregorianDate)date;
@end
