//
//  LogUtil.m
//  three20test
//
//  Created by qqn_pipi on 10-3-30.
//  Copyright 2010 QQN-PIPI.com. All rights reserved.
//

#import "LogUtil.h"

@implementation LogUtil

+ (void)startLog:(NSString*)string
{
	NSLog(@"************************** Start %@ **************************", string);
}

+ (void)stopLog:(NSString*)string
{
	NSLog(@"************************** End %@ **************************", string);
}

+ (void)output:(const char*)fileName lineNumber:(int)lineNumber function:(const char*)function input:(NSString*)input, ...
{
    va_list argList;
    NSString *filePath, *formatStr;
    
    // Build the path string
    filePath = [[NSString alloc] initWithBytes:fileName length:strlen(fileName)
                                      encoding:NSUTF8StringEncoding];
    
    // Process arguments, resulting in a format string
    va_start(argList, input);
    formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
    
    // Call NSLog, prepending the filename and line number
//    NSLog(@"%@ [%d] %s %@", [filePath lastPathComponent], lineNumber, function, formatStr);

    NSLog(@"%@[%d] %s %@", [filePath lastPathComponent], lineNumber, function, formatStr);

//    CFShow([NSString stringWithFormat:@"%@[%d] %@", [filePath lastPathComponent], lineNumber, formatStr]);

}

+ (void)output:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input, ...
{
    va_list argList;
    NSString *filePath, *formatStr;
    
    // Build the path string
    filePath = [[NSString alloc] initWithBytes:fileName length:strlen(fileName)
                                      encoding:NSUTF8StringEncoding];
    
    // Process arguments, resulting in a format string
    va_start(argList, input);
    formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
    
    // Call NSLog, prepending the filename and line number
    //    NSLog(@"%@ [%d] %s %@", [filePath lastPathComponent], lineNumber, function, formatStr);
    
    NSLog(@"%@[%d] %@", [filePath lastPathComponent], lineNumber, formatStr);
    
    //    CFShow([NSString stringWithFormat:@"%@[%d] %@", [filePath lastPathComponent], lineNumber, formatStr]);
    

}
@end
