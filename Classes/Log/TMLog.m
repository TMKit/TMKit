//
//  TMLog.m
//  TMKit
//
//  Created by Teemo on 18/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import "TMLog.h"


@implementation TMLog

+ (void)error:(NSString*)input {
    [self output:@"❌ Error -" fileName:nil lineNumber:0 input:input];
}

+ (void)warnings:(NSString*)input{
    [self output:@"🔶 Warning -" fileName:nil   lineNumber:0 input:input];
}

+ (void)info:(NSString*)input {
    [self output:@"🔷 Info  -" fileName:nil lineNumber:0 input:input];
}

+ (void)debug:(NSString*)input {
    [self output:@"◾️ Debug -" fileName:nil lineNumber:0 input:input];
}

+ (void)verbose:(NSString*)input{
    [self output:@"◽️ Verbose -" fileName:nil lineNumber:0 input:input];
}

+ (void)output:(NSString*)type
      fileName:(const char*)fileName
    lineNumber:(int)lineNumber
         input:(NSString*)input
{
    NSLog(@"%@ %@", type, input);
}

+ (void)output:(const char*)fileName lineNumber:(int)lineNumber  input:(NSString*)input {
    NSLog(@"%@", input);
}

@end


void TMLogError(NSString* input, ...){
    va_list argList;
    va_start(argList, input);
    NSString *formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
    
    [TMLog error:formatStr];
}
void TMLogWarning(NSString* input, ...){
    va_list argList;
    va_start(argList, input);
    NSString *formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
#ifdef DEBUG
    [TMLog warnings:formatStr];
#endif
}

void TMLogInfo(NSString* input, ...){
    va_list argList;
    va_start(argList, input);
    NSString *formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
#ifdef DEBUG
    [TMLog info:formatStr];
#endif
}

void TMLogDebug(NSString* input, ...){
    va_list argList;
    va_start(argList, input);
    NSString *formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
#ifdef DEBUG
    [TMLog debug:formatStr];
#endif
}
void TMLogVerbose(NSString* input, ...){
    va_list argList;
    va_start(argList, input);
    NSString *formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
#ifdef DEBUG
    [TMLog verbose:formatStr];
#endif
}


//void TMLog(NSString* input, ...){
//#ifdef DEBUG
//    [TMLogUtil output:__FILE__ lineNumber: __LINE__ input:input];
//#endif
//}

