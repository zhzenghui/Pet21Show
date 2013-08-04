//
//  Calculator.m
//  EiPhone
//
//  Created by gao guilong on 10-1-11.
//  Copyright 2010 encompass. All rights reserved.
//

#import "Calculator.h"
#import <math.h>
#import <string.h>

@implementation Calculator

+ (double)AutoCalculator:(NSString *)txtStr;
{
	char str[100];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"," withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"'" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@" " withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"&" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"$" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"[" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"]" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"{" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"}" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"<" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@">" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"=" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@";" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@":" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"^" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"@" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"#" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"~" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"?" withString:@""];
	txtStr = [txtStr stringByReplacingOccurrencesOfString:@"!" withString:@""];
	[txtStr getCString:str maxLength:[txtStr length]+1 encoding:NSUTF8StringEncoding];
	double t = jisuan(str);
	if(isnormal(t)!=1)
	{
		t = 0.00;
	}
	return t;
}

double jisuan(char str[])
{	
	char *p;
	char ss[100]={'\0'},fuhao[100]={'\0'};
	double number[100]={0.0},num[100]={0.0};
	int kk=0,right,left,i,j=0,flag=0;
	p=strchr(str,'(');
	while(p!=NULL)
	{
		for(left=right=i=0;str[i]!='\0';i++)
		{
			if(str[i]=='(')left++;
			if(str[i]==')')right++;
			if(left==right&&left!=0)
			{
				convert(ss,++p,&str[i-1]);
				number[kk++]=jisuan(ss);
				*(--p)='q';
				p++;
				del(p,&str[i+1]);
				//left=right=0;
				i=-1;
				break;
			}
		}
		if(str[i]=='\0')
		{
			break;
		}
		p=strchr(str,'(');
	}
	if(str[0]=='-')
		flag=1;
	for(i=1,kk=0;str[i-1]!='\0';i++)
	{
		if(str[i]=='+'||str[i]=='-'||str[i]=='*'||str[i]=='/'||str[i]=='\0')
		{
			if(str[i-1]!='q')
			{
				num[j]=transform(str,i);
				fuhao[j++]=str[i];
			}
			else
			{
				num[j]=number[kk++];
				fuhao[j++]=str[i];
			}
		}
	}
	if(flag)
	{
		num[0]=0-num[0];
		//flag=0;
	}
	for(i=0;fuhao[i]!='\0';i++)
	{
		if(fuhao[i]=='*'||fuhao[i]=='/')
		{
			if(fuhao[i]=='*')
				num[i]*=num[i+1];
			else
				num[i]/=num[i+1];
			del(&fuhao[i],&fuhao[i+1]);
			del2(num,i+1);
			i=-1;
		}
	}
	for(i=0;fuhao[i]!='\0';i++)
	{
		if(fuhao[i]=='+'||fuhao[i]=='-')
		{
			if(fuhao[i]=='+')
				num[i]+=num[i+1];
			else
				num[i]-=num[i+1];
			del(&fuhao[i],&fuhao[i+1]);
			del2(num,i+1);
			i=-1;
		}
	}
	return num[0];
}
void del(char *i,char *j)
{
	for(i;*j!='\0';j++)
		*(i++)=*j;
	*i=*j;
}
void del2(double num[],int i)
{
	for(;i<100;i++)
		num[i]=num[i+1];
}
void convert(char ss[],char *p,char *q)
{
	int i=0;
	char *pp;
	for(pp=p;pp<=q;pp++)
		ss[i++]=*pp;
}

double transform(char str[],int j)
{
	char temp[100]={'\0'};
	int k=0,i;
	i=j;
	while(i--)
	{
		if(str[i]=='+'||str[i]=='-'||str[i]=='*'||str[i]=='/')
			break;
	}
	for(i++;i<j;i++)
		temp[k++]=str[i];
	return atof(temp);
}

@end