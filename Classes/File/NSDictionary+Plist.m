//
//  NSDictionary+Plist.m
//  auction
//
//  Created by Teemo on 15/8/24.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import "NSDictionary+Plist.h"

@implementation NSDictionary (Plist)
- (BOOL)savePlistWithPath:(NSString*)path
{
    
//    NSString *error;
    
    NSString *rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                              NSUserDomainMask, YES) objectAtIndex:0];
    
    NSString *plistPath = [rootPath stringByAppendingPathComponent:@"Data.plist"];

    NSData *plistData = [NSPropertyListSerialization dataWithPropertyList:self format:NSPropertyListXMLFormat_v1_0 options:NSPropertyListImmutable error:nil];
    
     
    
    if(plistData) {
       return [plistData writeToFile:plistPath atomically:YES];
    }  
    return NO;
}
@end
