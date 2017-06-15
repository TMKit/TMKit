//
//  UIColor+TMUtil.m
//  Pods
//
//  Created by Teemo on 13/06/2017.
//
//

#import "UIColor+TMUtil.h"

@implementation UIColor (TMUtil)


+ (UIColor*)tm_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b{
    return [UIColor tm_colorWithR:r g:g b:b a:1];
}

+ (UIColor*)tm_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a{
    return [[UIColor alloc]initWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a];
}

@end
