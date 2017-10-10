//
//  TMVersionUtil.m
//  TMKit
//
//  Created by Teemo on 19/05/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import "TMVersionUtil.h"

inline NSString* _Nullable  tm_BundleVersion(){
    return [TMVersionUtil getBundleVersion];
}

inline NSString* _Nullable  tm_BundleShortVersion(){
    return [TMVersionUtil getShortBundleVersion];
}

@implementation TMVersionUtil


+ (NSString*)getBundleVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey];
}

+ (NSString*)getShortBundleVersion{
    return [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
}

@end
