//
//  NSDate+Utils.h
//  auction
//
//  Created by Teemo on 15/5/19.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>
NSDateComponents *getDateComponents(NSDate *date);


#define TIMESTAMP_WEEK  (7*24*60*60.0f)
#define TIMESTAMP_DAY   (24*60*60.0f)

BOOL isToday(NSDate *date);

BOOL isYesterday(NSDate *date);

BOOL isTheDayBeforeYesterday(NSDate *date);

BOOL isThisYear(NSDate *date);



@interface NSDate (Utils)

+(NSString*)showTimeInLatelyCell:(NSTimeInterval) messageTime;


/**
 *  在此之前
 */
+(NSString*)getTimeBeforeString:(NSTimeInterval) messageTime;
/**
 *  在此之后
 */
+(NSString*)getTimeAfterString:(NSTimeInterval) messageTime;
@end
