//
//  TMUserDefaults.m
//  Pods
//
//  Created by Teemo on 20/06/2017.
//
//

#import "TMUserDefaults.h"

@implementation TMUserDefaults

+ (void)setObject:(NSString*)key forKey:(id)value{
    if (key != nil) {
        NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
        [ud setObject:value forKey:key];
       
    }
}

+ (void)removeObjectForKey:(NSString *)defaultName{
    if (defaultName!=nil) {
        NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
        [ud removeObjectForKey:defaultName];
    }
}


+ (nullable id)objectForKey:(NSString *)defaultName{
    if (defaultName!=nil) {
        NSUserDefaults* ud = [NSUserDefaults standardUserDefaults];
        return [ud objectForKey:defaultName];
    }
}
@end
