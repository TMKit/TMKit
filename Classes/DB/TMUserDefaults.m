//
//  TMUserDefaults.m
//  TMKit
//
//  Created by Teemo on 20/06/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import "TMUserDefaults.h"
#import "TMLogUtil.h"

@implementation TMUserDefaults

+ (void)load{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [paths objectAtIndex:0];
    TMLog(@"TMKit Log: UserDefaults path %@",documentDir);
}

+ (void)setObject:(NSString*)value key:(id)key{
    if (key != nil) {
        NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:value forKey:key];
       
    }
}

+ (void)removeObjectWithKey:(NSString *)key{
    if (key!=nil) {
        NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:key];
    }
}


+ (nullable id)objectWithKey:(NSString *)key{
    if (key!=nil) {
        NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
        id obj = [ud objectForKey:key];
        return obj;
    }
    return nil;
}

+ (void)synchronize{
    BOOL result = [[NSUserDefaults standardUserDefaults] synchronize];
    TMLog(@"%TMKit Log: TMUserDefaults synchronize result %d",result);
}
@end
