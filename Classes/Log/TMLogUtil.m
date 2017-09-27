//
//  TMLogUtil.m
//  TMKit
//
//  Created by Teemo on 18/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import "TMLogUtil.h"

@interface TMLogUtil : NSObject

+ (void)error:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*) input;

+ (void)warnings:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input ;

+ (void)info:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input;

+ (void)debug:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input;

+ (void)output:(const char*)fileName lineNumber:(int)lineNumber  input:(NSString*)input;

+ (void)verbose:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input;

@end


@implementation TMLogUtil

+ (void)error:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input {

    [self output:@"❌ Error -" fileName:fileName lineNumber:lineNumber input:input];
}

+ (void)warnings:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input{
    [self output:@"🔶 Warning -" fileName:fileName lineNumber:lineNumber input:input];
}

+ (void)info:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input {
    [self output:@"🔷 Info  -" fileName:fileName lineNumber:lineNumber input:input];
}

+ (void)debug:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input {
    [self output:@"◾️ Debug -" fileName:fileName lineNumber:lineNumber input:input];
}

+ (void)verbose:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input{
    [self output:@"◽️ Verbose -" fileName:fileName lineNumber:lineNumber input:input];
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
    
    [TMLogUtil error: __FILE__ lineNumber: __LINE__ input:formatStr];
}
void TMLogWarning(NSString* input, ...){
    va_list argList;
    va_start(argList, input);
    NSString *formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
#ifdef DEBUG
    [TMLogUtil warnings: __FILE__ lineNumber: __LINE__ input:formatStr];
#endif
}

void TMLogInfo(NSString* input, ...){
    va_list argList;
    va_start(argList, input);
    NSString *formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
#ifdef DEBUG
    [TMLogUtil info: __FILE__ lineNumber: __LINE__ input:formatStr];
#endif
}

void TMLogDebug(NSString* input, ...){
    va_list argList;
    va_start(argList, input);
    NSString *formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
#ifdef DEBUG
    [TMLogUtil debug: __FILE__ lineNumber: __LINE__ input:formatStr];
#endif
}
void TMLogVerbose(NSString* input, ...){
    va_list argList;
    va_start(argList, input);
    NSString *formatStr = [[NSString alloc] initWithFormat:input arguments:argList];
    va_end(argList);
#ifdef DEBUG
    [TMLogUtil verbose: __FILE__ lineNumber: __LINE__ input:formatStr];
#endif
}


void TMLog(NSString* input, ...){
#ifdef DEBUG
    [TMLogUtil output:__FILE__ lineNumber: __LINE__ input:input];
#endif
}

