//
//  TMVersionUtil.m
//  TMKit
//
//  Created by Teemo on 19/05/2017.
//  Copyright © 2017 netease. All rights reserved.
//

#import "TMVersionUtil.h"

@implementation TMVersionUtil


+ (NSString*)getBundleVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
}

+ (NSString*)getShortBundleVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end
