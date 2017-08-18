//
//  NSDate+TMUtil.h
//  TMKit
//
//  Created by Teemo on 24/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSDate (TMUtil)

/**
 Get DateComponents (Era | Year | Month | Day | Hour | Minute | Second | Weekday)

 @return NSDateComponents
 */
- (NSDateComponents*) tm_getDateComponents;


/**
 this is judge date

 @return if today return yes , else  return no
 */
- (BOOL) tm_isToday;

/**
 this is judge date
 
 @return if today return yes , else  return no
 */
- (BOOL) tm_isYesterday;

/**
 this is judge date
 
 @return if Yesterday return yes , else  return no
 */
- (BOOL) tm_isTheDayBeforeYesterday;

/**
 this is judge date
 
 @return if TheDayBeforeYesterday return yes , else  return no
 */
- (BOOL) isThisYear;

@end

NS_ASSUME_NONNULL_END
