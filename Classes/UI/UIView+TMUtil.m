//
//  UIView+TMUtil.m
//  TMKit
//
//  Created by Teemo on 18/09/2017.
//  MIT License
//  Copyright (c) 2017 TMKit
//

#import "UIView+TMUtil.h"

CGFloat tm_ScreenWidth(){
    return [UIScreen mainScreen].bounds.size.width;
}

CGFloat tm_ScreenHeight(){
    return [UIScreen mainScreen].bounds.size.height;
}

CGFloat tm_ScreenScale(){
    return [UIScreen mainScreen].scale;
}

@implementation UIView (TMUtil)

@end
