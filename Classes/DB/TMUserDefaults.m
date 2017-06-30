//
//  TMUserDefaults.m
//  Pods
//
//  Created by Teemo on 20/06/2017.
//
//

#import "TMUserDefaults.h"
#import "TMLogUtil.h"

@implementation TMUserDefaults

+ (void)load{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentDir = [paths objectAtIndex:0];
    TMLog(@"TMKit Log: UserDefaults path %@",documentDir);
}

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
        id obj = [ud objectForKey:defaultName];
        return obj;
    }
}

+ (void)synchronize{
    BOOL result = [[NSUserDefaults standardUserDefaults] synchronize];
    TMLog(@"%TMKit Log: TMUserDefaults synchronize result %d",result);
}
@end
