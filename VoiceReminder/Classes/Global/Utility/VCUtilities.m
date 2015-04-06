//
//  VCUtilities.m
//  Vaccinations
//
//  Created by Nguyen Le Duan on 12/16/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import "VCUtilities.h"

@implementation VCUtilities
+ (UIViewController *)topViewController{
    return [VCUtilities topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController == nil) {
        return rootViewController;
    }
    if ([rootViewController.presentedViewController isMemberOfClass:[UINavigationController class]]) {
        UINavigationController *navigationController = (UINavigationController *)rootViewController.presentedViewController;
        UIViewController *lastViewController = [[navigationController viewControllers] lastObject];
        return [VCUtilities topViewController:lastViewController];
    }
    UIViewController *presentedViewController = (UIViewController *)rootViewController.presentedViewController;
    return [VCUtilities topViewController:presentedViewController];
}
@end
