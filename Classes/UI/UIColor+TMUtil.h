//
//  UIColor+TMUtil.h
//  TMKit
//
//  Created by Teemo on 13/06/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

//============Swift&&Objc==============


/**
convenient to create the UIColor , aphle is one

 @param r red channel
 @param g green channel
 @param b blue channel
 @return UIColor
 */
extern  UIColor* tm_RGB(CGFloat r,CGFloat g,CGFloat b);


/**
 convenient to create the UIColor

 @param r red channel
 @param g green channel
 @param b blue channel
 @param a aphle channel
 @return UIColor
 */
extern  UIColor* tm_RGBA(CGFloat r,CGFloat g,CGFloat b,CGFloat a);


@interface UIColor (TMUtil)

/**
 convenient to create the UIColor , aphle is one
 
 @param r red channel
 @param g green channel
 @param b blue channel
 @return UIColor
 */
+ (UIColor*)tm_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b;

/**
 convenient to create the UIColor
 
 @param r red channel
 @param g green channel
 @param b blue channel
 @param a aphle channel
 @return UIColor
 */
+ (UIColor*)tm_colorWithR:(CGFloat)r g:(CGFloat)g b:(CGFloat)b a:(CGFloat)a;


/**
 convenient to create the UIColor, rgb is zero

 @param transparency aphle
 @return UIColor
 */
+ (UIColor*)tm_colorWithTransparency:(CGFloat)transparency;
@end

NS_ASSUME_NONNULL_END
