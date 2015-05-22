//
//  UIApplication+AppDimensions.m
//  Vaccinations
//
//  Created by Nguyen Le Duan on 11/18/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import "UIApplication+AppDimensions.h"
#import "VRMacro.h"

@implementation UIApplication (AppDimensions)

+(CGSize) currentSize
{
    return [UIApplication sizeInOrientation:[UIApplication sharedApplication].statusBarOrientation];
}

+(CGSize) sizeInOrientation:(UIInterfaceOrientation)orientation
{
    CGSize size = [UIScreen mainScreen].bounds.size;
    if (NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_7_1 || !IS_IPAD) {
        UIApplication *application = [UIApplication sharedApplication];
        if (UIInterfaceOrientationIsLandscape(orientation))
        {
            size = CGSizeMake(size.height, size.width);
        }
        if (application.statusBarHidden == NO && NSFoundationVersionNumber <= NSFoundationVersionNumber_iOS_6_1)
        {
            size.height -= MIN(application.statusBarFrame.size.width, application.statusBarFrame.size.height);
        }
    }
    
    return size;
}
+ (UIWindow *)window
{
    UIWindow* window = [UIApplication sharedApplication].keyWindow;
    if (!window) {
        window = [[UIApplication sharedApplication].windows objectAtIndex:0];
    }
    return window;
}
@end
