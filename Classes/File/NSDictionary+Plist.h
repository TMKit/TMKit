//
//  NSDictionary+Plist.h
//  auction
//
//  Created by Teemo on 15/8/24.
//  Copyright (c) 2015年 Netease. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (Plist)

- (BOOL)savePlistWithPath:(NSString*)path;

@end
