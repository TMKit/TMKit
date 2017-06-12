//
//  NSObject+TMDataValid.m
//  TMKit
//
//  Created by Teemo on 10/04/2017.
//  Copyright © 2017 TMKit. All rights reserved.
//

#import "NSObject+TMDataValid.h"

@implementation NSObject (TMDataValid)


- (NSString*)tm_String{
    if (![self p_handleNull]) {
        return nil;
    }
    
    if ([self isKindOfClass:[NSString  class]]) {
        return (NSString*)self;
    }
    if ([self isKindOfClass:[NSNumber  class]]) {
        return [(NSNumber*)self stringValue];
    }
    return nil;
}

- (NSNumber*)tm_Number{
    if (![self p_handleNull]) {
        return nil;
    }
    
    if ([self isKindOfClass:[NSNumber  class]]) {
        return (NSNumber*)self;
    }
    
    if ([self isKindOfClass:[NSString  class]]) {
        NSNumberFormatter *f = [[NSNumberFormatter alloc] init];
        f.numberStyle = NSNumberFormatterDecimalStyle;
        NSNumber *myNumber = [f numberFromString:(NSString*)self];
        
        return myNumber;
    }
    return nil;
}

- (NSDictionary*)tm_Dictionary{
    if([self isKindOfClass:[NSDictionary class]]){
        return (NSDictionary*)self;
    }
    return nil;
}

- (NSArray*)tm_Array{
    if([self isKindOfClass:[NSArray class]]){
        return (NSArray*)self;
    }
    return nil;
}


- (BOOL)tm_isNull{
    if (self == nil) {
        return YES;
    }
    
    if ([self isKindOfClass:[NSNull  class]]) {
        return YES;
    }
    
    return NO;
}

//- (NSInteger)getInteger{
//    if (![self handleNull]) {
//        return 0;
//    }
//    return nil;
//}
//
//- (NSUInteger)getUInteger{
//    if (![self handleNull]) {
//        return 0;
//    }
//    return nil;
//}
//
//- (CGFloat)getCGFloat{
//    if (![self handleNull]) {
//        return 0;
//    }
//    return nil;
//}
//
//- (long long)getLongLongValue{
//    if (![self handleNull]) {
//        return 0;
//    }
//    return nil;
//}

- (BOOL)p_handleNull{
   
    
    if([self isKindOfClass:[NSValue class]]){
        return YES;
    }
    if ([self isKindOfClass:[NSString class]]) {
        return YES;
    }
    return NO;
}

@end
