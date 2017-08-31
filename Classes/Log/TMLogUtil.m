//
//  TMLogUtil.m
//  TMKit
//
//  Created by Teemo on 18/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import "TMLogUtil.h"

@implementation TMLogUtil


+ (void)verbose:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input, ...
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
    
    NSLog(@"class: %@ [line : %d] %@", [filePath lastPathComponent], lineNumber, formatStr);

}


@end
