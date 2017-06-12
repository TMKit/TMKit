//
//  TMLogUtil.h
//  TMKit
//
//  Created by Teemo on 18/05/2017.
//
//

#import <Foundation/Foundation.h>


#ifdef DEBUG
#define TMLog(format, ...) ([TMLogUtil output:__FILE__ lineNumber:__LINE__ input:(format), ## __VA_ARGS__])
#else
#define TMLog(format, ...)
#endif





@interface TMLogUtil : NSObject

+ (void)startLog:(NSString*)string;

+ (void)stopLog:(NSString*)string;

+ (void)output:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input, ...;

+ (void)output:(const char*)fileName lineNumber:(int)lineNumber function:(const char*)function input:(NSString*)input, ...;

@end
