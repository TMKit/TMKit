//
//  NSDate+Utils.m
//  auction
//
//  Created by Teemo on 15/5/19.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NSDate+Utils.h"




// return YEAR, MONTH, DAY in NSDateComponents by given NSDate
NSDateComponents *getDateComponents(NSDate *date)
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    return comps;
}


static NSDateComponents *getChineseDateComponents(NSDate *date)
{
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierChinese];
    unsigned unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    NSDateComponents *comps = [gregorian components:unitFlags fromDate:date];
    return comps;
}

BOOL isToday(NSDate *date)
{
    if (date == nil) {
        return NO;
    }
    
    // Get Today's YYYY-MM-DD
    NSDateComponents *today_comps = getDateComponents([NSDate date]);
    
    // Given Date's YYYY-MM-DD
    NSDateComponents *select_comps = getDateComponents(date);
    
    // if it's today, return TODAY
    if ( [today_comps year] == [select_comps year] &&
        [today_comps month] == [select_comps month] &&
        [today_comps day] == [select_comps day]){
        return YES;
    }
    else {
        return NO;
    }
    
}

BOOL isYesterday(NSDate *date){
    // Get Today's YYYY-MM-DD
    NSDateComponents *today_comps = getChineseDateComponents([NSDate date]);
    
    // Given Date's YYYY-MM-DD
    NSDateComponents *select_comps = getChineseDateComponents(date);
    
    // if it's today, return TODAY
    if ( [today_comps year] == [select_comps year] &&
        [today_comps month] == [select_comps month]&&
        ([today_comps day] - [select_comps day] == 1)){
        return YES;
    }
    else {
        return NO;
    }
}

BOOL isTheDayBeforeYesterday(NSDate *date)
{
    // Get Today's YYYY-MM-DD
    NSDateComponents *today_comps = getChineseDateComponents([NSDate date]);
    
    // Given Date's YYYY-MM-DD
    NSDateComponents *select_comps = getChineseDateComponents(date);
    
    // if it's today, return TODAY
    if ( [today_comps year] == [select_comps year] &&
        [today_comps month] == [select_comps month]&&
        ([today_comps day] - [select_comps day] == 2)){
        return YES;
    }
    else {
        return NO;
    }
}

BOOL isThisYear(NSDate *date)
{
    // Get Today's YYYY-MM-DD
    NSDateComponents *today_comps = getChineseDateComponents([NSDate date]);
    
    // Given Date's YYYY-MM-DD
    NSDateComponents *select_comps = getChineseDateComponents(date);
    
    // if it's today, return TODAY
    if ( [today_comps year] == [select_comps year]){
        return YES;
    }
    else {
        return NO;
    }
}


#define ONEDAYTIME    (24*60*60)  //一天的秒数

@implementation NSDate (Utils)




+(NSDateComponents*)stringFromTimeInterval:(NSTimeInterval)messageTime components:(NSCalendarUnit)components
{
    NSDateComponents *dateComponents = [[NSCalendar currentCalendar] components:components fromDate:[NSDate dateWithTimeIntervalSince1970:messageTime]];
    return dateComponents;
}


+(BOOL)isTheSameDay:(NSTimeInterval)currentTime compareTime:(NSDateComponents*)older
{
    NSCalendarUnit currentComponents =NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;;
    NSDateComponents *current = [[NSCalendar currentCalendar] components:currentComponents fromDate:[NSDate dateWithTimeIntervalSinceNow:currentTime]];
    
    return current.year == older.year && current.month == older.month && current.day == older.day;
}


+(NSString*)weekdayStr:(NSInteger)dayOfWeek
{
    static NSDictionary *daysOfWeekDict = nil;
    daysOfWeekDict = @{@(0):@"星期日",
                       @(1):@"星期一",
                       @(2):@"星期二",
                       @(3):@"星期三",
                       @(4):@"星期四",
                       @(5):@"星期五",
                       @(6):@"星期六",
                       @(7):@"星期日"};
    return [daysOfWeekDict objectForKey:@(dayOfWeek)];
}


+(NSString*)showTimeInLatelyCell:(NSTimeInterval) messageTime
{
    NSString *result = nil;
    
    NSCalendarUnit components = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;
    NSDateComponents *dateComponents = [self stringFromTimeInterval:messageTime components:components];
    if ([self isTheSameDay:[[NSDate date] timeIntervalSinceNow] compareTime:dateComponents]) {
        result = [NSString stringWithFormat:@"%@ %02zd:%02zd",NSLocalizedString(@"今天 ", nil), dateComponents.hour,dateComponents.minute];
    } else if ([self isTheSameDay:([[NSDate date] timeIntervalSinceNow] - ONEDAYTIME) compareTime:dateComponents])
    {
        result = [NSString stringWithFormat:@"%@ %02zd:%02zd",NSLocalizedString(@"昨天 ", nil), dateComponents.hour,dateComponents.minute];;
    } else if ([self isTheSameDay:([[NSDate date] timeIntervalSinceNow] - ONEDAYTIME*2) compareTime:dateComponents])
    {
        result = [NSString stringWithFormat:@"%@ %02zd:%02zd",NSLocalizedString(@"前天 ", nil), dateComponents.hour,dateComponents.minute];;
    } else if ([self isTheSameDay:([[NSDate date] timeIntervalSinceNow] - ONEDAYTIME*7) compareTime:dateComponents])
    {
        result =[NSString stringWithFormat:@"%@ %02zd:%02zd",[self weekdayStr:dateComponents.weekday], dateComponents.hour,dateComponents.minute];;
        
    } else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        result = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:messageTime]];
    }
    return result;
}


+(NSString*)getTimeBeforeString:(NSTimeInterval) messageTime
{
    NSString *result = nil;
    
    NSCalendarUnit components = NSCalendarUnitYear | NSCalendarUnitMonth |  NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond | NSCalendarUnitWeekday;;
    NSDateComponents *dateComponents = [self stringFromTimeInterval:messageTime components:components];
    if ([self isTheSameDay:[[NSDate date] timeIntervalSinceNow] compareTime:dateComponents]) {
        NSDateComponents *nowComp = getDateComponents([NSDate date]);
        
        if (dateComponents.hour != nowComp.hour) {
            result = [NSString stringWithFormat:@"%zd小时前",nowComp.hour - dateComponents.hour];
        }
        else if (dateComponents.minute != nowComp.minute){
            result = [NSString stringWithFormat:@"%zd分钟前",nowComp.minute - dateComponents.minute];
        }
        else{
            result = [NSString stringWithFormat:@"刚刚"];
        }
        
    }
    else if ([self isTheSameDay:([[NSDate date] timeIntervalSinceNow] - ONEDAYTIME) compareTime:dateComponents])
    {
        result = [NSString stringWithFormat:@"昨天 %02zd:%02zd", dateComponents.hour,dateComponents.minute];;
    }
    else if ([self isTheSameDay:([[NSDate date] timeIntervalSinceNow] - ONEDAYTIME*2) compareTime:dateComponents])
    {
        result = [NSString stringWithFormat:@"前天 %02zd:%02zd",dateComponents.hour,dateComponents.minute];;
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        result = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:messageTime]];
    }

    return result;
}

+(NSString*)getTimeAfterString:(NSTimeInterval) messageTime
{
    NSString *result = nil;
    
   
    NSDateComponents *dateComponents = getDateComponents([NSDate dateWithTimeIntervalSince1970:messageTime]);
    if ([self isTheSameDay:[[NSDate date] timeIntervalSinceNow] compareTime:dateComponents]) {
        NSDateComponents *nowComp = getDateComponents([NSDate date]);
        
        if (dateComponents.hour != nowComp.hour) {
            result = [NSString stringWithFormat:@"%zd小时后",-nowComp.hour + dateComponents.hour];
        }
        else if (dateComponents.minute != nowComp.minute){
            result = [NSString stringWithFormat:@"%zd分钟后",-nowComp.minute + dateComponents.minute];
        }
        else{
            result = [NSString stringWithFormat:@"%zd秒后",-nowComp.second + dateComponents.second];
        }
        
    }
    else if ([self isTheSameDay:([[NSDate date] timeIntervalSinceNow] + ONEDAYTIME) compareTime:dateComponents])
    {
        result = [NSString stringWithFormat:@"明天 %02zd:%02zd", dateComponents.hour,dateComponents.minute];;
    }
    else if ([self isTheSameDay:([[NSDate date] timeIntervalSinceNow] + ONEDAYTIME*2) compareTime:dateComponents])
    {
        result = [NSString stringWithFormat:@"后天 %02zd:%02zd",dateComponents.hour,dateComponents.minute];;
    }
    else
    {
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"MM-dd HH:mm"];
        result = [dateFormatter stringFromDate:[NSDate dateWithTimeIntervalSince1970:messageTime]];
    }
    
    return result;
}

@end
