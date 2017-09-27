//
//  TMLogUtil.h
//  TMKit
//
//  Created by Teemo on 18/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import <Foundation/Foundation.h>


/*
            Method	Production
            verbose	No
            debug	No
            info	No
            warning	No
            error	Yes
*/

/**
 ❌ Error messages stand out with a big red X — hard to miss!
 */
extern  void TMLogError(NSString* input, ...);

/**
 🔶 Warnings are highlighted with a fire-orange diamond
 */
extern  void TMLogWarning(NSString* input, ...);

/**
 🔷 Info messages add a splash of color in the form of a blue diamond
 */
extern  void TMLogInfo(NSString* input, ...);

/**
 ◾️ Debug messages have a black square; easier to spot, but still de-emphasized
 */
extern  void TMLogDebug(NSString* input, ...);

/**
 ◽️ Verbose messages are tagged with a small gray square — easy to ignore
 */
extern  void TMLogVerbose(NSString* input, ...);


/**
 Discard Log api
 */
extern  void TMLog(NSString* input, ...)  NS_DEPRECATED_IOS(5_0,7_0,"please use new log api");



