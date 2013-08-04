    //
//  EICrashHandler.m
//  EiPhone
//
//  Created by 张 增超 on 10-12-7.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CrashReporter/CrashReporter.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import "EICrashHandler.h"
#import "Directory.h"

@interface EICrashHandler()

- (void)handleReports;
- (void)cleanReports;

- (NSString *)crashLogStringForReport:(PLCrashReport *)report;

@end
 
@implementation EICrashHandler

+ (EICrashHandler *)crashHandler{
	static EICrashHandler *crashHandler = nil;
	
	if (crashHandler == nil) {
		crashHandler = [[EICrashHandler alloc] init];
	}
	
	return crashHandler;
}

- (id) init{
	self = [super init];
	if ( self != nil)
	{
		crashFiles = [[NSMutableArray alloc] init];
		crashesDir = [[NSMutableString alloc] init];
		[crashesDir appendString:[NSHomeDirectory() stringByAppendingPathComponent:@"Documents/tempCrashes/"]];
		
		NSFileManager *fileManger = [NSFileManager defaultManager];
		
		if (![fileManger fileExistsAtPath:crashesDir])
		{
			NSDictionary *attributes = [NSDictionary dictionaryWithObject: [NSNumber numberWithUnsignedLong: 0755] forKey: NSFilePosixPermissions];
			
			[fileManger createDirectoryAtPath:crashesDir withIntermediateDirectories: YES attributes: attributes error:nil];
		}
		
		PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
		NSError *error;
		//has crashed previously
		if ([crashReporter hasPendingCrashReport]){
			
			[self handleReports];
			
			NSFileManager *fileManger = [NSFileManager defaultManager];
			
			if ([crashFiles count] == 0 && [fileManger fileExistsAtPath:crashesDir])
			{
				NSString *file;
				NSDirectoryEnumerator *dirEnum = [fileManger enumeratorAtPath: crashesDir];
				while (file = [dirEnum nextObject])
				{
					NSDictionary *fileAttributes = [fileManger attributesOfItemAtPath:[crashesDir stringByAppendingPathComponent:file] error:nil];
					if ([[fileAttributes objectForKey:NSFileSize] intValue] > 0)
					{
						[crashFiles addObject:file];
					}
				}
			}
		}
		// Enable the Crash Reporter
		if (![crashReporter enableCrashReporterAndReturnError: &error])
			NSLog(@"Can not enable the crash reporter: %@", error);;
	}
	return self;
}

- (void)dealloc {
	[crashesDir release];
	[crashFiles release];
    [super dealloc];
}

#pragma mark -
#pragma mark Private Methods

- (void)cleanReports{
	
	NSError *error;
	NSFileManager *fileManger = [NSFileManager defaultManager];
	
	for (int i=0; i < [crashFiles count]; i++)
	{		
		[fileManger removeItemAtPath:[crashesDir stringByAppendingPathComponent:[crashFiles objectAtIndex:i]] error:&error];
	}
	[crashFiles removeAllObjects];
	[fileManger removeItemAtPath:crashesDir error:&error];
}


- (void)saveCrashesData{
	
		NSError *error;
		for (int i=0; i < [crashFiles count]; i++)
		{
			NSString *filename = [crashesDir stringByAppendingPathComponent:[crashFiles objectAtIndex:i]];
			NSData *crashData = [NSData dataWithContentsOfFile:filename];
			
			if ([crashData length] > 0)
			{
				PLCrashReport *report = [[[PLCrashReport alloc] initWithData:crashData error:&error] autorelease];
				
				NSString *crashLogString = [self crashLogStringForReport:report];
				
				NSString *headString = [NSString stringWithFormat:@"applicationname:%s,\nsystemversion:%@,\n%@\n",
										[[[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleExecutable"] UTF8String],
										[[UIDevice currentDevice] systemVersion],
										crashLogString];
				
                
                NSMutableData *importantData =  [NSMutableData data];
                
                
                

            
                [Directory createDcumentDic:@"log"];

                NSString *crash = [NSString stringWithFormat:@"%@/log/CrashReporter.log", [Directory Documents]];
                
                if ([Directory fileExistsAtPath:crash]) {
                
                }
                
				[importantData appendData:[headString dataUsingEncoding:NSUTF8StringEncoding]];
             
//				[importantData writeToFile:crash atomically:YES];
                [importantData writeToFile:crash options:NSDataWritingFileProtectionNone error:nil];
                
			}
		}
		
	[self cleanReports];
}


- (NSString *)crashLogStringForReport:(PLCrashReport *)report{
	NSMutableString *crashString = [NSMutableString string];
	
	// Header 
    boolean_t lp64;
	
	//OS name 
	const char *osName;
	switch (report.systemInfo.operatingSystem) {
		case PLCrashReportOperatingSystemiPhoneOS:
			osName = "iPhone OS";
			break;
		case PLCrashReportOperatingSystemiPhoneSimulator:
			osName = "Mac OS X";
			break;
		default:
			osName = "iPhone OS";
			break;
	}
	
	NSString *codeType;
	switch (report.systemInfo.architecture) {
		case PLCrashReportArchitectureARM:
			codeType = @"ARM (Native)";
            lp64 = false;
			break;
        case PLCrashReportArchitectureX86_32:
            codeType = @"X86";
            lp64 = false;
            break;
        case PLCrashReportArchitectureX86_64:
            codeType = @"X86-64";
            lp64 = true;
            break;
        case PLCrashReportArchitecturePPC:
            codeType = @"PPC";
            lp64 = false;
            break;
		default:
			codeType = @"ARM (Native)";
            lp64 = false;
			break;
	}
	
	[crashString appendString:@"Incident Identifier: [TODO]\n"];
	[crashString appendString:@"CrashReporter Key:   [TODO]\n"];
    
    // Application and process info
    {
        NSString *unknownString = @"???";
        
        NSString *processName = unknownString;
        NSString *processId = unknownString;
        NSString *processPath = unknownString;
        NSString *parentProcessName = unknownString;
        NSString *parentProcessId = unknownString;
        
        // Process information was not available in earlier crash report versions 
        if (report.hasProcessInfo) {
            // Process Name 
            if (report.processInfo.processName != nil)
                processName = report.processInfo.processName;
            
            // PID 
            processId = [[NSNumber numberWithUnsignedInteger: report.processInfo.processID] stringValue];
            
            // Process Path 
            if (report.processInfo.processPath != nil)
                processPath = report.processInfo.processPath;
            
            // Parent Process Name 
            if (report.processInfo.parentProcessName != nil)
                parentProcessName = report.processInfo.parentProcessName;
            
            // Parent Process ID 
            parentProcessId = [[NSNumber numberWithUnsignedInteger: report.processInfo.parentProcessID] stringValue];
        }
        
        [crashString appendFormat: @"Process:         %@ [%@]\n", processName, processId];
        [crashString appendFormat: @"Path:            %@\n", processPath];
        [crashString appendFormat: @"Identifier:      %@\n", report.applicationInfo.applicationIdentifier];
        [crashString appendFormat: @"Version:         1.514\n"];
        [crashString appendFormat: @"Code Type:       %@\n", codeType];
        [crashString appendFormat: @"Parent Process:  %@ [%@]\n", parentProcessName, parentProcessId];
    }
    
	[crashString appendString:@"\n"];
	
	// System info 
	[crashString appendFormat:@"Date/Time:       %s\n", [[report.systemInfo.timestamp description] UTF8String]];
	[crashString appendFormat:@"OS Version:      %s %s\n", osName, [report.systemInfo.operatingSystemVersion UTF8String]];
	
	[crashString appendString:@"\n"];
	
	// Exception code 
	[crashString appendFormat:@"Exception Type:  %s\n", [report.signalInfo.name UTF8String]];
    [crashString appendFormat:@"Exception Codes: %@ at 0x%" PRIx64 "\n", report.signalInfo.code, report.signalInfo.address];
	
    for (PLCrashReportThreadInfo *thread in report.threads) {
        if (thread.crashed) {
            [crashString appendFormat: @"Crashed Thread:  %ld\n", (long) thread.threadNumber];
            break;
        }
    }
	
	[crashString appendString:@"\n"];
	
    if (report.hasExceptionInfo) {
        [crashString appendString:@"Application Specific Information:\n"];
        [crashString appendFormat: @"*** Terminating app due to uncaught exception '%@', reason: '%@'\n",
         report.exceptionInfo.exceptionName, report.exceptionInfo.exceptionReason];
        [crashString appendString:@"\n"];
    }
    
	// Threads 
    PLCrashReportThreadInfo *crashedThread = nil;
    for (PLCrashReportThreadInfo *thread in report.threads) {
        if (thread.crashed) {
            [crashString appendFormat: @"Thread %ld Crashed:\n", (long) thread.threadNumber];
            crashedThread = thread;
        } else {
            [crashString appendFormat: @"Thread %ld:\n", (long) thread.threadNumber];
        }
        for (NSUInteger frameId = 0; frameId < [thread.stackFrames count]; frameId++) {
            PLCrashReportStackFrameInfo *frameInfo = [thread.stackFrames objectAtIndex: frameId];
            PLCrashReportBinaryImageInfo *imageInfo;
            
            //images
            uint64_t baseAddress = 0x0;
            uint64_t pcOffset = 0x0;
            NSString *imageName = @"\?\?\?";
            
            imageInfo = [report imageForAddress: frameInfo.instructionPointer];
            if (imageInfo != nil) {
                imageName = [imageInfo.imageName lastPathComponent];
                baseAddress = imageInfo.imageBaseAddress;
                pcOffset = frameInfo.instructionPointer - imageInfo.imageBaseAddress;
            }
            
            [crashString appendFormat: @"%-4ld%-36s0x%08" PRIx64 " 0x%" PRIx64 " + %" PRId64 "\n", 
             (long) frameId, [imageName UTF8String], frameInfo.instructionPointer, baseAddress, pcOffset];
        }
        [crashString appendString: @"\n"];
    }
    
    // Registers 
    if (crashedThread != nil) {
        [crashString appendFormat: @"Thread %ld crashed with %@ Thread State:\n", (long) crashedThread.threadNumber, codeType];
        
        int regColumn = 1;
        for (PLCrashReportRegisterInfo *reg in crashedThread.registers) {
            NSString *regInfo;
            
            // Use 32-bit or 64-bit fixed width format for the register values 
            if (lp64)
                regInfo = @"%6s:\t0x%016" PRIx64 " ";
            else
                regInfo = @"%6s:\t0x%08" PRIx64 " ";
            
            [crashString appendFormat: regInfo, [reg.registerName UTF8String], reg.registerValue];
            
            if (regColumn % 4 == 0)
                [crashString appendString: @"\n"];
            regColumn++;
        }
        
        if (regColumn % 3 != 0)
            [crashString appendString: @"\n"];
        
        [crashString appendString: @"\n"];
    }
	
	// Images 
	[crashString appendFormat:@"Binary Images:\n"];
	
    for (PLCrashReportBinaryImageInfo *imageInfo in report.images) {
		NSString *uuid;
		//uuid 
		if (imageInfo.hasImageUUID)
			uuid = imageInfo.imageUUID;
		else
			uuid = @"???";
		
        NSString *device = @"\?\?\? (\?\?\?)";
        
#ifdef _ARM_ARCH_7 
        device = @"armv7";
#else
        device = @"armv6";
#endif
        
		[crashString appendFormat:@"0x%" PRIx64 " - 0x%" PRIx64 "  %@ %@ <%@> %@\n",
		 imageInfo.imageBaseAddress,
		 imageInfo.imageBaseAddress + imageInfo.imageSize,
		 [imageInfo.imageName lastPathComponent],
		 device,
		 uuid,
		 imageInfo.imageName];
	}
	
	return crashString;
}

- (void) handleReports{
	
	PLCrashReporter *crashReporter = [PLCrashReporter sharedReporter];
	NSError *error;
	NSData *crashData = [NSData dataWithData:[crashReporter loadPendingCrashReportDataAndReturnError: &error]];
	
	NSString *cacheFilename = [NSString stringWithFormat: @"%.0f", [NSDate timeIntervalSinceReferenceDate]];
	
	if (crashData == nil) {
		goto finish;
	} else {
		[crashData writeToFile:[crashesDir stringByAppendingPathComponent: cacheFilename] atomically:YES];
	}
	
	PLCrashReport *report = [[[PLCrashReport alloc] initWithData: [crashData retain] error: &error] autorelease];
	[crashData release];
	if (report == nil) {
		goto finish;
	}
finish:
	[crashReporter purgePendingCrashReport];
	return;
}

@end
