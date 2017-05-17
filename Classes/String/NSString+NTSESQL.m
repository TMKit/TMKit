//
//  NSString+SQL.m
//  auction
//
//  Created by Teemo on 7/13/16.
//  Copyright © 2016 Netease. All rights reserved.
//

#import "NSString+NTSESQL.h"

@implementation NSString (NTSESQL)
+ (NSString*)NTSE_SQLCreateTable:(NSString*)tableName params:(NSDictionary*)params{
    NSMutableString *result = [NSMutableString string];
    [result appendFormat:@"create table if not exists %@ ",tableName];
    [result appendString:@"(id integer primary key autoincrement "];
    for (NSString *key in params.allKeys) {
        [result appendFormat:@", %@ %@ ",key,params[key]];
    }
    [result appendString:@");"];
    return result;
}


+ (NSString*)NTSE_SQLAddColumn:(NSString*)tableName params:(NSDictionary*)params{
    NSMutableString *result = [NSMutableString string];
    [result appendFormat:@"ALTER TABLE %@ ADD",tableName];
    NSMutableDictionary *dict = [params mutableCopy];
    
//    [result appendString:@"( "];
    if (params.allKeys.count) {
        [result appendFormat:@" %@ %@",dict.allKeys.firstObject,dict[dict.allKeys.firstObject]];
        [dict removeObjectForKey:dict.allKeys.firstObject];
    }
//    for (NSString *key in params.allKeys) {
//        [result appendFormat:@", %@ %@ ",key,params[key]];
//    }
//    [result appendString:@");"];
    return result;
}
@end
