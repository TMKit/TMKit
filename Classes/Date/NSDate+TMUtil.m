//
//  NSDate+TMUtil.m
//  TMKit
//
//  Created by Teemo on 24/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import "NSDate+TMUtil.h"

@implementation NSDate (TMUtil)

- (NSDateComponents*) tm_getDateComponents{
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitEra | NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour
    | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:self];
    return comps;
    
}

- (BOOL) tm_isToday{
    
    NSDateComponents *today_comps = [[NSDate date] tm_getDateComponents];
    NSDateComponents *my_comps = [self tm_getDateComponents];
    if ( [today_comps year] == [my_comps year] &&
        [today_comps month] == [my_comps month] &&
        [today_comps day] == [my_comps day]){
        return YES;
    }
    else {
        return NO;
    }
    
}

- (BOOL) tm_isYesterday{
    NSDateComponents *today_comps = [[NSDate date] tm_getDateComponents];
    NSDateComponents *my_comps = [self tm_getDateComponents];
    if ( [today_comps year] == [my_comps year] &&
        [today_comps month] == [my_comps month] &&
        [today_comps day] - [my_comps day]==1){
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL) tm_isTheDayBeforeYesterday{
    NSDateComponents *today_comps = [[NSDate date] tm_getDateComponents];
    NSDateComponents *my_comps = [self tm_getDateComponents];
    if ( [today_comps year] == [my_comps year]){
        return YES;
    }
    else {
        return NO;
    }
}

- (BOOL) isThisYear{
    NSDateComponents *today_comps = [[NSDate date] tm_getDateComponents];
    NSDateComponents *my_comps = [self tm_getDateComponents];
    if ( [today_comps year] == [my_comps year]){
        return YES;
    }
    else {
        return NO;
    }
}


@end
