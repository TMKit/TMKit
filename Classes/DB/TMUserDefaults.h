//
//  TMUserDefaults.h
//  Pods
//
//  Created by Teemo on 20/06/2017.
//
//

#import <Foundation/Foundation.h>

@interface TMUserDefaults : NSObject

+ (void)setObject:(NSString*_Nonnull)key forKey:(id _Nullable)value;

+ (void)removeObjectForKey:(NSString *_Nonnull)defaultName;

+ (nullable id)objectForKey:(NSString *_Nonnull)defaultName;

+ (void)synchronize;

@end
