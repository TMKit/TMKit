//
//  TMLogUtil.h
//  TMKit
//
//  Created by Teemo on 18/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import <Foundation/Foundation.h>

// TODO
//◽️ Verbose messages are tagged with a small gray square — easy to ignore
//◾️ Debug messages have a black square; easier to spot, but still de-emphasized
//🔷 Info messages add a splash of color in the form of a blue diamond
//🔶 Warnings are highlighted with a fire-orange diamond
//❌ Error messages stand out with a big red X — hard to miss!


#ifdef DEBUG
#define TMLog(format, ...) ([TMLogUtil output:__FILE__ lineNumber:__LINE__ input:(format), ## __VA_ARGS__])
#else
#define TMLog(format, ...)
#endif





@interface TMLogUtil : NSObject

//+ (void)startLog:(NSString*)string;
//
//+ (void)stopLog:(NSString*)string;

//+ (void)output:(const char*)fileName lineNumber:(int)lineNumber input:(NSString*)input, ...;

//+ (void)output:(const char*)fileName lineNumber:(int)lineNumber function:(const char*)function input:(NSString*)input, ...;

@end
