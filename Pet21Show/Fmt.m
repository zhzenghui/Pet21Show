//
//  Fmt.m
//  EiPhone
//
//  Created by zeus on 12/4/09.
//  Copyright 2009 Encompass. All rights reserved.
//

#import "Fmt.h"
#import "regex.h"
#import "Calculator.h"


@implementation BC_Fmt

//--myVal 需要是NSNumber
+(id) Null2Zero:(id)myVal
{
	id reVal;
	if([myVal isKindOfClass:[NSString class]])
	{
		if(myVal==nil||[myVal isEqualToString:@""])
		{
			reVal = @"0";
		}
		else {
			reVal = myVal;
		}
	}
	else if(myVal == [NSNull null] || [myVal stringValue] == @"" || myVal == nil)
	{
		reVal = @"0";
	}
	else
	{
		reVal = myVal;
	}
	return reVal;
}

+(NSString *) Null2EmptyStr:(id)myVal
{
	NSString *reVal=[NSString stringWithFormat:@"%@",myVal];
	if(myVal == [NSNull null] || myVal == nil)
	{
		reVal = @"";
	}
	//else
//	{
//		reVal = myVal;
//	}
	return reVal;
}

/*
+(NSString *) FormatPhone:(id)myVal
{
	id reVal;
	
	if(myVal == [NSNull null] || [myVal stringValue] == @"")
	{
		reVal = @"";
	}
	else
	{
		reVal = myVal;
		if([[myVal stringValue] length] == 7)
		{			
			reVal = [[NSString alloc] initWithFormat:@"%@-%@", 
					 [[myVal stringValue] substringToIndex:3],
					 [[myVal stringValue] substringFromIndex:4]];
		}
		else if([[myVal stringValue] length] == 10)
		{			
			NSRange myRange;
			myRange.location = 4;
			myRange.length = 3;
			
			reVal = [[NSString alloc] initWithFormat:@"(%@)%@-%@", 
					 [BC_Fmt Left:myVal length:3],
					 [[myVal stringValue] substringWithRange:myRange],
					 [BC_Fmt Left:myVal length:4]];
		}
	}
	return reVal;
}
*/

+(NSString *)Left:(id)myVal length:(int)length
{
	NSString *reVal = @"";
	if(myVal==nil)
	{
		return @"";
	}
	if([myVal isKindOfClass:[NSString class]])
	{
		reVal = myVal;
	}
	else {
		reVal = [myVal stringValue];
	}

	
	NSRange myRange;
	myRange.location = 0;
	if([reVal length]<length)
	{
		myRange.length = [reVal length];
	}
	else {
		myRange.length = length;
	}
	return [reVal substringWithRange:myRange];

}

+(NSString *)Right:(id)myVal length:(int)length
{
	NSString *reVal = @"";	
	if(myVal==nil)
	{
		return @"";
	}
	if([myVal isKindOfClass:[NSString class]])
	{
		reVal = myVal;
	}
	else {
		reVal = [myVal stringValue];
	}
	
	NSRange myRange;
	
	if([reVal length]<=length)
	{
		return reVal;
	}
	else {
		myRange.location = [myVal length] - length;
		myRange.length = length;
	}
	
	return [myVal substringWithRange:myRange];
}

+(NSString *)SubString:(NSString *)myVal startIndex:(int)startIndex length:(int)length
{
	if(myVal==nil || [myVal isEqualToString:@""])
	{
		return @"";
	}
	
	NSRange myRange;
	myRange.location = startIndex;
	myRange.length = length;
	
	return [myVal substringWithRange:myRange];
}

+ (NSString *)trim:(NSString *)tNSString
{
	if(tNSString==nil)
		return @"";
	return [tNSString stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
}

+ (NSString *)FormatCurrency:(NSString*)money withDecimalDigits:(int)bit
{
	BOOL isLegalData = YES;
	
	if(money == nil)
		return @"$0";
	
	//--for negative data ,remove the illegal chars
	if(([money rangeOfString:@")"].length > 0) && ([money rangeOfString:@"("].length > 0)){
		isLegalData = NO;
		money = [money stringByReplacingOccurrencesOfString:@")" withString:@""];
		money = [money stringByReplacingOccurrencesOfString:@"(" withString:@""];
	}
	
	if(![BC_Fmt isNumeric:money])
		return @"$0";
	NSString *strformate = @"%.";
	strformate = [strformate stringByAppendingFormat:@"%d",bit];
	strformate = [strformate stringByAppendingString:@"f"];
	money = [@"$" stringByAppendingString:[NSString stringWithFormat:strformate,[money doubleValue]]];
	
	if(!isLegalData){
		money = [[@"(" stringByAppendingString:money] stringByAppendingString:@")"];
	}
	
	return money;
}

+ (NSString *)FormatCurrencyWithoutUSD:(NSString*)money withDecimalDigits:(int)bit
{
	if(money==nil)
		return @"0";
	
	if(![BC_Fmt isNumeric:money])
		return @"0";
	
	NSString *strformate=@"%.";
	strformate = [strformate stringByAppendingFormat:@"%d",bit];
	strformate = [strformate stringByAppendingString:@"f"];
	money = [@"" stringByAppendingString:[NSString stringWithFormat:strformate,[money doubleValue]]];
	
	return money;
}

+ (NSString *)FormatCurrencyImp:(NSString*)money withDecimalDigits:(int)bit
{
	if(money==nil)
		return @"$0";
	if(![BC_Fmt isNumeric:money])
		return @"$0";
	NSString *strformate=@"%.";
	strformate = [strformate stringByAppendingFormat:@"%d",bit];
	strformate = [strformate stringByAppendingString:@"f"];
	
	BOOL isNeg = ([money characterAtIndex:0] == '-')?YES:NO;
	if (isNeg)
	{
		money = [money substringFromIndex:1];
		money = [NSString stringWithFormat:strformate,[money doubleValue]];
		money = [NSString stringWithFormat:@"($%@)",money];
	}
	else {
		money = [@"$" stringByAppendingString:[NSString stringWithFormat:strformate,[money doubleValue]]];
	}
	
	return money;
}

+ (NSString *)FormatNumber:(NSString*)number withDecimalDigits:(int)bit
{
	if(number==nil)
		return @"";
	if(![BC_Fmt isNumeric:number])
		return @"";
	NSString *strformate=@"%.";
	strformate = [strformate stringByAppendingFormat:@"%d",bit];
	strformate = [strformate stringByAppendingString:@"f"];
	
	BOOL isNeg = ([number characterAtIndex:0] == '-')?YES:NO;
	if (isNeg)
	{
		number = [number substringFromIndex:1];
		number = [NSString stringWithFormat:strformate,[number doubleValue]];
		number = [NSString stringWithFormat:@"(%@)",number];
	}
	else {
		number = [NSString stringWithFormat:strformate,[number doubleValue]];
	}
	
	return number;
}

+(BOOL)isDate:(NSString *)dateStr
{
	if(dateStr==nil)
		return NO;
	return [BC_Fmt RegExpMatch:dateStr withPattern:@"^[0-9]{4}(\\-)[0-9]{1,2}(\\-)[0-9]{1,2}|[0-9]{1,2}(\\/)[0-9]{1,2}(\\/)[0-9]{4}"];
}

+(BOOL)RegExpMatch:(NSString *)string withPattern:(NSString*)pattern{
    regex_t reg;
    regmatch_t sub[10];
    int status=regcomp(&reg, [pattern UTF8String], REG_EXTENDED);
    if(status)
	{
		regfree(&reg);
		//free(sub);
		return NO;
	}
    status=regexec(&reg, [string UTF8String], 10, sub, 0);
    if(status==REG_NOMATCH)
	{
		regfree(&reg);
		//free(sub);
		return NO;
	}
    else if(status)
	{
		regfree(&reg);
		//free(sub);
		return NO;
	}
	regfree(&reg);
	//free(sub);
    return YES;
}

//--val 需要是字符串
+(BOOL)isNumeric:(id)val
{
	if(val==nil||[val isEqualToString:@""])
	{
		return NO;
	}
	else {
		return [BC_Fmt RegExpMatch:val withPattern:@"^[+-]?([1-9][0-9]+|[0-9])(\\.[0-9]+){0,1}$"];
	}
}

+(BOOL)isNumber:(id)val
{
	if(val==nil||[val isEqualToString:@""])
	{
		return NO;
	}
	else {
		return [BC_Fmt RegExpMatch:val withPattern:@"^[0-9]*[1-9][0-9]*$"];
	}
}

+ (NSString *)FormatData:(id)myValue DataType:(NSString *)DataType Length:(int)Length
{
	id Value;
	if(myValue==nil)
	{
		Value = @"";
	}
	else {
		Value = myValue;
	}
	if([DataType isEqualToString:@"date"])
	{
		Value = [Value stringByReplacingOccurrencesOfString:@"'" withString:@""];
		if(![BC_Fmt isDate:Value])
		{
			Value = @"";
		}
		else {
			
			NSTimeInterval seconds= [Value timeIntervalSinceNow];
			if(seconds > 10*365*24*60*60)
			{
				Value = @"";
			}
			else {
				Value = [[@"'" stringByAppendingString:Value] 
						 stringByAppendingString:@"'"];
			}
		}
	}
	else if([DataType isEqualToString:@"integer"]||[DataType isEqualToString:@"autonumber"])
	{
		if([Value isEqualToString:@""])
		{
			Value = @"";
		}
		if(![BC_Fmt isNumber:Value])
		{
			Value = @"";
		}
		else {
			Value = [BC_Fmt Left:Value length:10];
		}
	}
	else if([DataType isEqualToString:@"currency"])
	{
		Value = [Value stringByReplacingOccurrencesOfString:@"$" withString:@""];
		if([BC_Fmt isNumeric:Value]||[Value isEqualToString:@""])
		{
			Value = @"";
		}
		else{
			Value = [NSString stringWithFormat:@"%.4f",Value];
		}
	}
	else if([DataType isEqualToString:@"decimal"])
	{
		if([BC_Fmt isNumeric:Value]||[Value isEqualToString:@""])
		{
			Value = @"";
		}
		else{
			Value = [NSNumber numberWithDouble:[Value doubleValue]];
		}
	}
	else if([DataType isEqualToString:@"text"])
	{
		Value = [BC_Fmt trim:Value];		
		
		NSRange range = [Value rangeOfString:@"  "];
		
		while (range.location != NSNotFound) {
			Value = [Value stringByReplacingOccurrencesOfString:@"  " withString:@" "];
			range = [Value rangeOfString:@"  "];
		}
		
		//Communication Characters
		Value = [Value stringByReplacingOccurrencesOfString:@"^" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"|" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"~" withString:@""];
		
		//Don't like double quotes
		Value = [Value stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"\\" withString:@""];
		//Carage Return
		Value = [Value stringByReplacingOccurrencesOfString:@"\r" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
		
		//SQLBless
		//WSC Object wont compile with this character inside double quotes
		Value = [Value stringByReplacingOccurrencesOfString:@"'" withString:@" "];
		Value = [Value stringByReplacingOccurrencesOfString:@"`" withString:@" "];
		Value = [Value stringByReplacingOccurrencesOfString:@"/" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"?" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"%" withString:@""];

		//End SQLBless
		Value = [BC_Fmt Left:[BC_Fmt trim:Value] length:Length];
		
		if([Value isEqualToString:@""])
		{
			Value = @"";
		}
		else if (Value!=nil)
		{
			Value = [[@"'" stringByAppendingString:Value] 
					 stringByAppendingString:@"'"];
		}		
	}
	else if([DataType isEqualToString:@"yesOrno"])
	{
		if ([BC_Fmt isNumeric:Value])
		{
			if(abs([Value intValue])==1)
			{
				Value = [NSNumber numberWithInt:1];
			}
			else {
				Value = [NSNumber numberWithInt:0];
			}
		}
		else 
		{
			if( [[Value lowercaseString] isEqualToString:@ "true"] )
			{
				Value = [NSNumber numberWithInt:1];
			}
			else
			{
				Value = [NSNumber numberWithInt:0];
			}
		}
	}
	else if([DataType isEqualToString:@"phone"])
	{
		Value = [Value stringByReplacingOccurrencesOfString:@"(" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@")" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"-" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"." withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@" " withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"'" withString:@""];
		
		//Communication Characters
		Value = [Value stringByReplacingOccurrencesOfString:@"^" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"|" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"~" withString:@""];
		
		//Don't like double quotes
		Value = [Value stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"\\" withString:@""];
		//SQLBless
		//WSC Object wont compile with this character inside double quotes
		Value = [Value stringByReplacingOccurrencesOfString:@"'" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"`" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"<" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@">" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"$" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"¥" withString:@""];
		
		Value = [Value stringByReplacingOccurrencesOfString:@"*" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"%" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"@" withString:@""];
		
		Value = [Value stringByReplacingOccurrencesOfString:@"!" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"£" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"#" withString:@""];
		
		Value = [Value stringByReplacingOccurrencesOfString:@"," withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"/" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"?" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"[" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"]" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"{" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"}" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"(" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@")" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"-" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"+" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"=" withString:@""];
        Value = [Value stringByReplacingOccurrencesOfString:@"." withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@";" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@":" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"," withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"&" withString:@""];
		Value = [BC_Fmt Left:[BC_Fmt trim:Value] length:Length];
		
		if([Value isEqualToString:@""])
		{
			Value = @"";
		}
		else if (!Value)
		{
			Value = [[@"'" stringByAppendingString:Value] 
					 stringByAppendingString:@"'"];
		}	
	}
	else  if([DataType isEqualToString:@"textnospc"])
	{
		Value = [Value stringByReplacingOccurrencesOfString:@" " withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"&" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"'" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"\"" withString:@""];

		Value = [Value stringByReplacingOccurrencesOfString:@"^" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"|" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"~" withString:@""];

		
		Value = [BC_Fmt Left:[BC_Fmt trim:Value] length:Length];
		
		if([Value isEqualToString:@""])
		{
			Value = @"";
		}
		else if (!Value)
		{
			Value = [[@"'" stringByAppendingString:Value] 
					 stringByAppendingString:@"'"];
		}	
	}
	return Value;

}

+ (int)DateDiff:(NSString *)interval Date1:(NSString *)date1 Date2:(NSString *)date2
{
	
	int intervalTemp=0;
	
	NSDate *inputDate1 = [BC_Fmt StringFormatToDate:date1];
	NSDate *inputDate2 = [BC_Fmt StringFormatToDate:date2];

	NSTimeInterval timeInterval = [inputDate1 timeIntervalSinceDate:inputDate2];
	if([interval isEqualToString:@"yyyy"])//year
	{
		intervalTemp = timeInterval/(365*24*60*60);
	}
	else if([interval isEqualToString:@"q"]){//quarter
		intervalTemp = timeInterval/(90*24*60*60);
	}
	else if([interval isEqualToString:@"m"]){//month
		intervalTemp = timeInterval/(30*24*60*60);
	}
	else if([interval isEqualToString:@"y"]){
		
	}
	else if([interval isEqualToString:@"d"]){//day
		intervalTemp = timeInterval/(24*60*60);
	}
	else if([interval isEqualToString:@"w"]){
		
	}
	else if([interval isEqualToString:@"ww"]){//week
		intervalTemp = timeInterval/(7*24*60*60);
	}
	else if([interval isEqualToString:@"h"]){//hour
		intervalTemp = timeInterval/(60*60);
	}
	else if([interval isEqualToString:@"n"]){//minute
		intervalTemp = timeInterval/60;
	}
	else if([interval isEqualToString:@"s"]){//second
		intervalTemp = timeInterval;
	}
	else {
		intervalTemp = timeInterval;
	}
	
	return abs(intervalTemp);
}
+(NSString *)DateAdd:(NSString *)interval Date1:(int)date1 Date2:(NSString *)date2
{
	NSString *input = [BC_Fmt FormatDate:date2 withTime:NO];
	NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
	[dateFormatter setDateFormat:@"MM/dd/yyyy"];//--custom style
	
	NSDate *inputDate2 = [dateFormatter dateFromString:input];
	NSDateComponents *components = [[[NSDateComponents alloc] init] autorelease];
	
	if([interval isEqualToString:@"y"])//year
	{
		[components setYear:date1];
	}
	else if([interval isEqualToString:@"m"]){//month
		[components setMonth:date1];
	}
	else if([interval isEqualToString:@"d"]){//day
		[components setDay:date1];
	}
	else {
		[components setDay:0];
	}		
	// create a calendar
	NSCalendar *gregorian = [[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] autorelease];
	
	NSDate *newDate2 = [gregorian dateByAddingComponents:components toDate:inputDate2 options:0];
	
	
	return [dateFormatter stringFromDate:newDate2];
}
+(NSString *)Zero2Empty:(NSNumber *)num{
	
	if([num doubleValue]==0)
	{
		return @"";
	}
	return [NSString stringWithFormat:@"%@", num];
}

+ (NSString *)StringFormatDate:(NSString *)strDate
{
	return [BC_Fmt FormatDate:strDate withTime:YES];
}

+ (NSString *)FormatDate:(NSString *)strDate withTime:(BOOL)withTime
{
	NSString *month = [NSString string];
	NSString *day = [NSString string];
	NSString *year = [NSString string];
	if(strDate == nil || [strDate isEqualToString:@""])
	{
		return @"";
	}
	if([strDate rangeOfString:@"/"].location!=NSNotFound)//  /
	{
		NSArray *listItems = [strDate componentsSeparatedByString:@"/"];// MM/dd/yyyy
		if([listItems count]>2)
		{
			month = [listItems  objectAtIndex:0];
			if([month length]==1)
				month = [@"0" stringByAppendingString:month];
			day = [listItems objectAtIndex:1];
			if([day length]==1)
				day = [@"0" stringByAppendingString:day];
			year = [listItems objectAtIndex:2];
			if([year rangeOfString:@" "].location!=NSNotFound)
				year = [year substringToIndex:[year rangeOfString:@" "].location];
			if([year length]==2)
				year = [@"20" stringByAppendingString:year];			
		}
		
	}
	if([strDate rangeOfString:@"-"].location!=NSNotFound)// －
	{
		NSArray *listItems = [strDate componentsSeparatedByString:@"-"];
		if([listItems count]>2)
		{
			year = [listItems objectAtIndex:0];
			if([year length]==2)
				year = [@"20" stringByAppendingString:year];
			month = [listItems  objectAtIndex:1];
			if([month length]==1)
				month = [@"0" stringByAppendingString:month];
			day = [listItems objectAtIndex:2];
			if([day rangeOfString:@" "].location!=NSNotFound)
				day = [day substringToIndex:[day rangeOfString:@" "].location];
			if([day length]==1)
				day = [@"0" stringByAppendingString:day];
		}
	}
	
	if(withTime)
	{
		return [[[[[year stringByAppendingString:@"-"] 
				 stringByAppendingString:month] 
				 stringByAppendingString:@"-"] 
				 stringByAppendingString:day] 
				 stringByAppendingString:@" 00:00:00 +GMT"];
	}
	else 
	{
		return [NSString stringWithFormat:@"%@/%@/%@", month, day, year];
	}
}
//style = YES year; NO month
+ (NSString *)FormatDateForEncompass:(NSString *)strDate Style:(BOOL)style
{
	if(strDate==nil)
		return @"";
	NSString *tmpDate = [BC_Fmt FormatDate:strDate withTime:NO];
	if (!style) {
		tmpDate = [BC_Fmt Left:tmpDate length:5];
	}
	return tmpDate;
}

+ (NSDate *)StringFormatToDate:(NSString *)strDate
{
	if(strDate==nil)
		return nil;
	NSString *tempStr = [BC_Fmt StringFormatDate:strDate];
	return [[[NSDate alloc] initWithString:tempStr] autorelease];
	//return [[NSDate alloc] initWithString:tempStr];
}
+ (NSString *)DateFormatToString:(NSDate *)date
{
	if(date ==nil)
	{
		return @"";
	}
	return [date description];
}
+(BOOL)isPhone:(NSString*)PhoneCode
{
	if(PhoneCode==nil||[PhoneCode isEqualToString:@""])
	{
		return NO;
	}
	else
	{
		return [BC_Fmt RegExpMatch:PhoneCode withPattern:@"\\d{3}-\\d{3}-?\\d{4}|\\d{10}|\\(\\d{3}\\)\\d{3}-\\d{4}"];
	}
}
+(NSNumber *)StringToNumber:(NSString *)string
{
	if(string==nil)
		return nil;
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	NSNumber *number = [numberFormatter numberFromString:string];
	[numberFormatter release];
	return number;
}

+(NSString *)NumberToString:(NSNumber *)number
{
	if(number==nil)
		return @"";
	NSNumberFormatter *numberFormatter = [[NSNumberFormatter alloc] init];
	[numberFormatter setNumberStyle:NSNumberFormatterDecimalStyle];
	NSString *string = [numberFormatter stringFromNumber:number];
	[numberFormatter release];
	return string;
}
+ (NSString *)InterceptionDecimalEndZero:(NSString *)decimalStr
{
	if(decimalStr==nil)
		return @"0";
	if([decimalStr rangeOfString:@"."].location!=NSNotFound)
	{
		NSArray *listItems = [decimalStr componentsSeparatedByString:@"."];
		NSString *tempStr = [listItems objectAtIndex:1];
		while ([tempStr length] > 0) {
			if([[tempStr substringFromIndex:[tempStr length]-1] isEqualToString:@"0"])
			{
				tempStr = [tempStr substringToIndex:[tempStr length]-1];
			}
			else {
				break;
			}
		}
		if([tempStr isEqualToString:@""])
		{
			return [listItems objectAtIndex:0];
		}
		else {
					return [[[listItems objectAtIndex:0] stringByAppendingString:@"."] stringByAppendingString: tempStr];
		}
	}
	return decimalStr;

}

//--判断一个字符串里是否只存在某些字符，不区分大小写
//--YES: 是  NO：还有其它字符
+(BOOL)IsString:(NSString *)myStr OnlyExistOfChars:(NSArray *)charsArray{
	
	BOOL reVal;
	NSMutableString *temp=[[NSMutableString alloc] init];
	[temp appendString:myStr];
	for(NSInteger i=0;i<[charsArray count];i++){
		if([temp length]==0){
			break;
		}
		NSString *t=[NSString stringWithFormat:@"%@",[charsArray objectAtIndex:i]];
		[temp replaceOccurrencesOfString:t withString:@"" options:NSCaseInsensitiveSearch range:NSMakeRange(0,[temp length])];
	}
	if([temp length]>0){
		
		reVal=NO;
	}else{
		reVal=YES;
	}
	[temp release];
	return reVal;
}

//support $ man min
+(NSString *)NumComp:(NSString *)myVal{
	
	NSMutableString *result=[NSMutableString stringWithString:myVal];
	if([result isEqualToString:@""])
	{
		[result setString:@"0"];
	}
	
	if ([myVal length] > 32) {
		[result setString:@"0"];
	}
	
	//support $
	NSRange _range=[result rangeOfString:@"$"]; //--是否只能替换第一个？
	if(_range.length>0)
	{
		[result deleteCharactersInRange:_range];
	}
	
	result=[NSMutableString stringWithFormat:@"%.4f", [Calculator AutoCalculator:result]];
	result=[NSMutableString stringWithFormat:@"%@", [BC_Fmt InterceptionDecimalEndZero:result]];
	
	// support max range
	if([result intValue]>1000000){
		[result setString:@"0"];
	}
	
	// support min range
	if ([result intValue] < -1000000) {
		[result setString:@"0"];
	}
	
	return result;
}
+ (NSString*)FormatPhone:(NSString*)myVal
{
	NSString *tmp;
	if (myVal==nil||[myVal length]==0) {
		tmp = @"";
	}
	else {
		tmp = myVal;
		tmp = [tmp stringByReplacingOccurrencesOfString:@"(" withString:@""];
		tmp = [tmp stringByReplacingOccurrencesOfString:@")" withString:@""];
		tmp = [tmp stringByReplacingOccurrencesOfString:@"-" withString:@""];
		tmp = [tmp stringByReplacingOccurrencesOfString:@" " withString:@""];
		if ([tmp length]==7) {
			tmp = [[[BC_Fmt Left:tmp length:3] 
					stringByAppendingString:@"-"] 
				   stringByAppendingString:[BC_Fmt Right:tmp length:4]];
		}
		else if ([tmp length]==10){
		//	NSString* fristStr=[BC_Fmt Left:tmp length:3];
//			NSString* secondStr=[tmp substringWithRange:NSMakeRange(3, 3)];
//			NSString* threeStr=[BC_Fmt Right:tmp length:4];
//			
//			tmp=[NSString stringWithFormat:@"(%@) %@-%@",fristStr,secondStr,threeStr];
			tmp = [[[[[@"(" stringByAppendingString:[BC_Fmt Left:tmp length:3]] 
					  stringByAppendingString:@") "] 
					 stringByAppendingString:[tmp substringWithRange:NSMakeRange(3, 3)]] 
					stringByAppendingString:@"-"] 
				   stringByAppendingString:[BC_Fmt Right:tmp length:4]];
		}		
	}
	return tmp;
}


+(UIColor *)colorWithRGBIntegers:(CGFloat)red green:(CGFloat)green blue:(CGFloat)blue alpha:(CGFloat)alpha{
	
	CGFloat redF    = red/255;
	CGFloat greenF    = green/255;
	CGFloat blueF    = blue/255;
	CGFloat alphaF    = alpha/1.0;
	
	return [UIColor colorWithRed:redF green:greenF blue:blueF alpha:alphaF];
}
+(int)ConvertCharFrom16to10:(NSString *)str{
	
	int reVal = 0;
	if([str isEqualToString:@"A"]){ reVal = 10; }
	else if([str isEqualToString:@"B"]){ reVal = 11; }
	else if([str isEqualToString:@"C"]){ reVal = 12; }
	else if([str isEqualToString:@"D"]){ reVal = 13; }
	else if([str isEqualToString:@"E"]){ reVal = 14; }
	else if([str isEqualToString:@"F"]){ reVal = 15; }
	else { reVal = [str intValue]; }
	
	return reVal;
}
+(UIColor *)getColorByRGBstr:(NSString *)rgbstr{
	if(rgbstr == nil || [rgbstr length] < 6)
	{
		return [UIColor blueColor];
	}
	
	if(![[rgbstr substringToIndex:1] isEqualToString:@"#"]){
		
		rgbstr = [@"#" stringByAppendingString:rgbstr];
	}
	
	NSArray *rgbArr = [NSArray arrayWithObjects:[rgbstr substringWithRange:NSMakeRange(1, 1)],
					   [rgbstr substringWithRange:NSMakeRange(2, 1)],
					   [rgbstr substringWithRange:NSMakeRange(3, 1)],
					   [rgbstr substringWithRange:NSMakeRange(4, 1)],
					   [rgbstr substringWithRange:NSMakeRange(5, 1)],
					   [rgbstr substringWithRange:NSMakeRange(6, 1)],nil];
	
	int redInt = [self ConvertCharFrom16to10:[rgbArr objectAtIndex:0]] * 16 + [self ConvertCharFrom16to10:[rgbArr objectAtIndex:1]];
	int greenInt = [self ConvertCharFrom16to10:[rgbArr objectAtIndex:2]] * 16 + [self ConvertCharFrom16to10:[rgbArr objectAtIndex:3]];
	int blueInt = [self ConvertCharFrom16to10:[rgbArr objectAtIndex:4]] * 16 + [self ConvertCharFrom16to10:[rgbArr objectAtIndex:5]];
	
	return [self colorWithRGBIntegers:redInt green:greenInt blue:blueInt alpha:1.0];
	
}

+(NSString *)fdate:(NSString *)Value
{
    NSString *tmp = Value;
	
    if([tmp isEqualToString:@""])
	{
        return tmp;
    }
	
    NSString *myMonth = @"";
    NSString *myDate = @"";
    NSString *myYear = @"";
    
	tmp = [tmp stringByReplacingOccurrencesOfString:@"-" withString:@"/"];
    
    if ([tmp rangeOfString:@"/"].location == NSNotFound)
	{
        if([tmp length] > 8)
		{
			tmp = [BC_Fmt SubString:tmp startIndex:0 length:8];
        }
        switch([tmp length])
		{
            case 3:
                myMonth = [BC_Fmt SubString:tmp startIndex:0 length:1];
                myDate = [BC_Fmt SubString:tmp startIndex:1 length:2];
                break;
            case 4:
                myMonth = [BC_Fmt SubString:tmp startIndex:0 length:2];
                myDate = [BC_Fmt SubString:tmp startIndex:2 length:2];
                break;
            case 5:
                myMonth = [BC_Fmt SubString:tmp startIndex:0 length:1];
                myDate = [BC_Fmt SubString:tmp startIndex:1 length:2];
                myYear = [BC_Fmt SubString:tmp startIndex:3 length:2];
                break;
            case 6:
                myMonth = [BC_Fmt SubString:tmp startIndex:0 length:2];
                myDate = [BC_Fmt SubString:tmp startIndex:2 length:2];
                myYear = [BC_Fmt SubString:tmp startIndex:4 length:2];
                break;
            case 7:
                myMonth = [BC_Fmt SubString:tmp startIndex:0 length:1];
                myDate = [BC_Fmt SubString:tmp startIndex:1 length:2];
                myYear = [BC_Fmt SubString:tmp startIndex:3 length:4];
                break;
            case 8:
                myMonth = [BC_Fmt SubString:tmp startIndex:0 length:2];
                myDate = [BC_Fmt SubString:tmp startIndex:2 length:2];
                myYear = [BC_Fmt SubString:tmp startIndex:4 length:4];
                break;
        }
    }
    else
	{
        NSArray *tmpArr = [tmp componentsSeparatedByString:@"/"];
        myMonth = [tmpArr objectAtIndex:0];
        if ([tmpArr count] > 1)
		{
			myDate = [tmpArr objectAtIndex:1];
		}
        if ([tmpArr count] > 2)
		{
			myYear = [tmpArr objectAtIndex:2];
		}
    }
    
    if ([myYear length] < 4 && ![myYear isEqualToString:@""])
	{ 
		myYear = [NSString stringWithFormat:@"%d",[myYear intValue] + 2000];
	}
 
	NSDate *myDateObj = [NSDate date];
    
    if (![BC_Fmt isNumber:myMonth] || [myMonth intValue] < 1 || [myMonth intValue] > 12)
	{
        myMonth = [BC_Fmt getComponentFromDate:myDateObj 
											   component:@"M" 
										       offset:1];
    }
	
    if (![BC_Fmt isNumber:myDate] || [myDate intValue] < 1)
	{
        myDate = @"1";
    }
    if (![BC_Fmt isNumber:myDate] || [myDate intValue] > 31)
	{
        myDate = @"31";
    }
    if (![BC_Fmt isNumber:myYear] || [myYear intValue] < 1980 || [myYear intValue] > 2050)
	{
        myYear = [BC_Fmt getComponentFromDate:myDateObj 
									component:@"Y" 
									   offset:0];
    }
    
	if([myMonth isEqualToString:@"4"] || [myMonth isEqualToString:@"6"] || [myMonth isEqualToString:@"9"] || [myMonth isEqualToString:@"11"])
	{
		if ([myDate intValue] > 30)
		{
			myDate = @"30";
		}      
    }
	else if([myMonth isEqualToString:@"2"])
	{
		if ([myDate intValue] > 29)
		{
			myDate = @"28";
		}
	}
    
	return [NSString stringWithFormat:@"%@/%@/%@", myMonth, myDate, myYear];
}

+(NSString *)getComponentFromDate:(NSDate *)dateValue component:(NSString *)component offset:(int)offset
{
	NSString *retVal = @"";
	
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit |  NSDayCalendarUnit;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:dateValue];
    if([[component uppercaseString] isEqualToString:@"Y"])
	{
		retVal = [NSString stringWithFormat:@"%d", [comps year] + offset];
	}
	else if([[component uppercaseString] isEqualToString:@"M"])
	{
		retVal = [NSString stringWithFormat:@"%d",[comps month] + offset];
	}
	else if([[component uppercaseString] isEqualToString:@"D"])
	{
		retVal = [NSString stringWithFormat:@"%d",[comps day] + offset];
	}
    //[gregorian dateFromComponents:comps];
    [gregorian release];
	return retVal;
}

+ (NSString *)CustomerFormatData:(id)myValue DataType:(NSString *)DataType Length:(int)Length
{
	id Value;
	if(myValue==nil)
	{
		Value = @"";
	}
	else {
		Value = myValue;
	}
	
	if([DataType isEqualToString:@"text"])
	{
		Value = [BC_Fmt trim:Value];		
		
		NSRange range = [Value rangeOfString:@"  "];
		
		while (range.location != NSNotFound) {
			Value = [Value stringByReplacingOccurrencesOfString:@"  " withString:@" "];
			range = [Value rangeOfString:@"  "];
		}
		
		Value = [Value stringByReplacingOccurrencesOfString:@"&" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		
		Value = [Value stringByReplacingOccurrencesOfString:@"^" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"|" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"~" withString:@""];
		
		//print 
		Value = [Value stringByReplacingOccurrencesOfString:@"€" 
													   withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"•" 
													   withString:@""];
		
			//SQLBless
			//WSC Object wont compile with this character inside double quotes
		Value = [Value stringByReplacingOccurrencesOfString:@"'" withString:@"''"];
		Value = [Value stringByReplacingOccurrencesOfString:@"<" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@">" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"$" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"¥" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"%" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"!" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"£" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"/" withString:@""];
		
		Value = [Value stringByReplacingOccurrencesOfString:@"+" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"=" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@";" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@":" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"&" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"{" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"}" withString:@""];
			//End SQLBless 	
	}
	
	if([DataType isEqualToString:@"textnospc"]){
		Value = [BC_Fmt trim:Value];		
		
			//Communication Characters
		
		Value = [Value stringByReplacingOccurrencesOfString:@" " withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"^" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"|" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"~" withString:@""];
		
			//Don't like double quotes
		Value = [Value stringByReplacingOccurrencesOfString:@"\"" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"\\" withString:@""];
			//Carage Return
		Value = [Value stringByReplacingOccurrencesOfString:@"\r" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"\n" withString:@" "];
		
		//print 
		Value = [Value stringByReplacingOccurrencesOfString:@"€" 
												 withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"•" 
												 withString:@""];
		
			//SQLBless
			//WSC Object wont compile with this character inside double quotes
		Value = [Value stringByReplacingOccurrencesOfString:@"'" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"/" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"?" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"%" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"<" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@">" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"$" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"¥" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"%" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"!" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"£" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"/" withString:@""];
		
		Value = [Value stringByReplacingOccurrencesOfString:@"+" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"=" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@";" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@":" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"&" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"{" withString:@""];
		Value = [Value stringByReplacingOccurrencesOfString:@"}" withString:@""];
			//End SQLBless
	}
	
	
	Value = [BC_Fmt Left:[BC_Fmt trim:Value] length:Length];
	
	if([Value isEqualToString:@""])
	{
		Value = @"";
	}
	else if (Value!=nil)
	{
		Value = [[@"" stringByAppendingString:Value] 
				 stringByAppendingString:@""];
	}
	return Value;
}


+ (NSString *)addSpaceInString:(NSString *)sourceStr lineLength:(int)lineLength
{
	NSMutableString *resultString = [NSMutableString string];
	[resultString setString:@""];
	
	if (sourceStr != nil && ![sourceStr isEqualToString:@""]) 
	{
		int spaceCount = 0;
		int sourceStrLen = [sourceStr length];
		
		if (sourceStrLen < lineLength) 
		{
			spaceCount = (lineLength - sourceStrLen) / 2;
		}
		
		if (spaceCount < 1) 
		{
			return sourceStr;
		}
		for (int i = 0; i < spaceCount; i++) 
		{
			[resultString appendString:@" "];
		}
		[resultString appendString:sourceStr];
		return resultString;
	}
	else 
	{
		return @"";
	}
}

+ (BOOL)checkUPC:(NSString *)UPCCode
{
	if (UPCCode == nil||[UPCCode isEqualToString:@""]) {
		return NO;
	}
	if ([UPCCode length] < 8) { //||[UPCCode length] > 13
		return NO;
	}
	if([BC_Fmt isNumber:UPCCode]){
		return YES;
	}
	return NO;
	
}

//--formate negative data before calculat
+ (NSString*)FormatNegativeData:(NSString*)sourceStr {
	
	NSString* returnValue = @"";
	if(sourceStr == nil || [sourceStr isEqualToString:@""]) {
		return @"";
	}
	else {
		returnValue = sourceStr;
	}
	
	if(([returnValue rangeOfString:@")"].length > 0) 
	   && ([returnValue rangeOfString:@"("].length > 0)){
		
	    returnValue = [returnValue stringByReplacingOccurrencesOfString:@")" withString:@""];
		returnValue = [returnValue stringByReplacingOccurrencesOfString:@"(" withString:@""];
		returnValue = [returnValue stringByReplacingOccurrencesOfString:@"-" withString:@""];
		returnValue = [returnValue stringByReplacingOccurrencesOfString:@"$" withString:@""];
		returnValue = [@"-" stringByAppendingString:returnValue];
	}
	else {
		returnValue = [returnValue stringByReplacingOccurrencesOfString:@"$" withString:@""];
	}
	
	return returnValue;
}

+ (NSString*)getLocaleTime {
	
	NSString *curDateString = @"";
	NSDate *curDate = [NSDate date];
	NSTimeZone *curZone = [NSTimeZone localTimeZone];
	NSInteger secondsFromGMT = [curZone secondsFromGMT];
	
#ifdef __IPHONE_3_2 OR __IPHONE_4_0 OR __IPHONE_3_1
	
	NSDate *returnDate = [curDate addTimeInterval:secondsFromGMT];
#else 
	NSDate *returnDate = [curDate dateByAddingTimeInterval:secondsFromGMT];
#endif
	curDateString = [[NSString stringWithFormat:@"%@",[returnDate description]] substringToIndex:19];
		//NSLog(@"%@",curDateString);
	return curDateString;
}

+ (NSString*)FormatMoney:(NSString*)value{
	
	NSString* returnValue = @"";
	
	value = [BC_Fmt trim:value];
	BOOL isNumber = [BC_Fmt isNumeric:value];
	
	if (isNumber != YES) {
		return @"0";
	}
	
	if (value == nil || [value isEqualToString:@""] || [value doubleValue] == 0) {
		return @"0";
	}
	
	double valueOfFloat = [value doubleValue];
	if (valueOfFloat > 99999999999999) {
		return @"0";
	}
	
	NSNumberFormatter *fmt = [[NSNumberFormatter alloc] init];
	[fmt setMinimumFractionDigits:0];
	[fmt setMaximumFractionDigits:2];
	[fmt setMinimumIntegerDigits:0];
	[fmt setMaximumIntegerDigits:14];
	
	returnValue = [fmt stringFromNumber:[NSNumber numberWithDouble:[value doubleValue]]];
	[fmt release];
	return returnValue;
}

+ (NSString*)FormatDateToLongDate:(NSString *)dateStr Style:(BOOL)style{
	
	NSString *returnValue = @"";
	
	if (![self isDate:dateStr]) {
		return @"";
	}
	
	dateStr = [BC_Fmt FormatDateForEncompass:dateStr 
									   Style:YES];
	
	NSArray *listItems = [dateStr componentsSeparatedByString:@"/"];
	
	int month = [[listItems objectAtIndex:0] intValue];
	int day = [[listItems objectAtIndex:1] intValue];
	int year = [[listItems objectAtIndex:2] intValue];
	
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFAbsoluteTime currentTime = CFAbsoluteTimeGetCurrent();
	CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(currentTime,tz);
	CFRelease(tz);
	
	currentDate.year = year;
	currentDate.month = month;
	currentDate.day = day;
	
	int weekday = [self getMonthWeekday:currentDate];

	NSString *weekDayValue = @"";
	switch (weekday) {
		case 1:{
			weekDayValue = style ? @"Moday":@"Mon";
			break;
		}
		case 2:{
			weekDayValue = style ? @"Tuesday":@"Tues";
			break;
		}
		case 3:{
			weekDayValue = style ? @"Wednesday":@"Wed";
			break;
		}
		case 4:{
			weekDayValue = style ? @"Thursday":@"Thur";
			break;
		}
		case 5:{
			weekDayValue = style ? @"Friday":@"Fri";
			break;
		}
		case 6:{
			weekDayValue = style ? @"Saturday":@"Sat";
			break;
		}
		case 7:{
			weekDayValue = style ? @"Sunday":@"Sun";
			break;
		}
	}
	
	NSString *monthValue = @"";
	
	switch (month) {
		case 1:
			monthValue = style ? @"January" : @"JAN";
			break;
		case 2:
			monthValue = style ? @"Frbruary" : @"FEB";
			break;
		case 3:
			monthValue = style ? @"March" : @"MAR";
			break;
		case 4:
			monthValue = style ? @"April" : @"APR";
			break;
		case 5:
			monthValue = style ? @"May" : @"MAY";
			break;
		case 6:
			monthValue = style ? @"June" : @"JUN";
			break;
		case 7:
			monthValue = style ? @"July" : @"JUL";
			break;
		case 8:
			monthValue = style ? @"August" : @"AUG";
			break;
		case 9:
			monthValue = style ? @"September" : @"SEP";
			break;
		case 10:
			monthValue = style ? @"October" : @"OCT";
			break;
		case 11:
			monthValue = style ? @"November" : @"NOV";
			break;
		case 12:
			monthValue = style ? @"December" : @"DEC";
			break;
	}
	
	returnValue = [NSString stringWithFormat:@"%@  %@ %d, %d",weekDayValue,monthValue,day,year];
	
	return returnValue;
}

+ (int)getMonthWeekday:(CFGregorianDate)date{
	
	CFTimeZoneRef tz = CFTimeZoneCopyDefault();
	CFGregorianDate month_date;
	month_date.year = date.year;
	month_date.month = date.month;
	month_date.day = date.day;
	month_date.hour = 0;
	month_date.minute = 0;
	month_date.second = 1;
	
	CFAbsoluteTime at = CFGregorianDateGetAbsoluteTime(month_date,tz);
	SInt32 weekday = CFAbsoluteTimeGetDayOfWeek(at ,tz);
	CFRelease(tz);
	
	return (int)weekday;
}

@end
