//
//  UIApplication+AppDimensions.h
//  Vaccinations
//
//  Created by Nguyen Le Duan on 11/18/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIApplication (AppDimensions)

+(CGSize) currentSize;

+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation;

+ (UIWindow *)window;

@end
