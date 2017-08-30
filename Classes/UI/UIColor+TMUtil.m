//
//  UIColor+TMUtil.m
//  TMKit
//
//  Created by Teemo on 13/06/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import "UIColor+TMUtil.h"

UIColor* tm_RGB(CGFloat r,CGFloat g,CGFloat b){
    return [UIColor tm_colorWithR:r g:g b:b];
}

UIColor* tm_RGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a){
    return [UIColor tm_colorWithR:r g:g b:b a:a];
}

@implementation UIColor (TMUtil)

+ (UIColor*)tm_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b{
    return [UIColor tm_colorWithR:r g:g b:b a:1];
}

+ (UIColor*)tm_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a{
    return [[UIColor alloc]initWithRed:(r/255.0) green:(g/255.0) blue:(b/255.0) alpha:a];
}

+ (UIColor*)tm_colorWithTransparency:(CGFloat)transparency{
    return [UIColor tm_colorWithR:0 g:0 b:0 a:transparency];
}
@end
