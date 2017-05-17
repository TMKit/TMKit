//
//  LogUtil.h
//  three20test
//
//  Created by qqn_pipi on 10-3-30.
//  Copyright 2010 QQN-PIPI.com. All rights reserved.
//

#import <Foundation/Foundation.h>

//__FUNCTION__,__FILE__,__LINE__

#ifdef DEBUG
//    #define PPDebug(format, ...) (NSLog(format, ## __VA_ARGS__))
    #define DLog(format, ...) ([LogUtil output:__FILE__ lineNumber:__LINE__ input:(format), ## __VA_ARGS__])
#else
    #define DLog(format, ...)
#endif

#ifdef DEBUG
//    #define PPDebug(format, ...) (NSLog(format, ## __VA_ARGS__))
#define QDebug(format, ...) ([LogUtil output:__FILE__ lineNumber:__LINE__ function:__PRETTY_FUNCTION__ input:(format), ## __VA_ARGS__])
#else
#define QDebug(format, ...)
#endif

#ifdef DEBUG
//    #define PPDebug(format, ...) (NSLog(format, ## __VA_ARGS__))
    #define UIDebug(format, ...) ([LogUtil alertViewOutput:__FILE__ lineNumber:__LINE__ function:__PRETTY_FUNCTION__ input:(format), ## __VA_ARGS__])
#else
    #define UIDebug(format, ...)
#endif


@interface LogUtil : NSObject {

}

+ (void)startLog:(NSString*)string;
+ (void)stopLog:(NSString*)string;
+ (void)output:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input, ...;
+ (void)output:(const char*)fileName lineNumber:(int)lineNumber function:(const char*)function input:(NSString*)input, ...;


@end
