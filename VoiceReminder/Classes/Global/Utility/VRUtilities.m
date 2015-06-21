//
//  VCUtilities.m
//  Vaccinations
//
//  Created by Nguyen Le Duan on 12/16/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import "VRUtilities.h"

@implementation VRUtilities
+ (UIViewController *)topViewController{
    return [VRUtilities topViewController:[UIApplication sharedApplication].keyWindow.rootViewController];
}

+ (UIViewController *)topViewController:(UIViewController *)rootViewController
{
    if (rootViewController.presentedViewController)
    {
        
        UIViewController *presentedViewController = rootViewController.presentedViewController;
        return [self topViewController:presentedViewController];
    }
    else if ([rootViewController isKindOfClass:[UITabBarController class]])
    {
        
        UITabBarController *tabBarController = (UITabBarController *)rootViewController;
        return [self topViewController:tabBarController.selectedViewController];
    }
    
    else if ([rootViewController isKindOfClass:[UINavigationController class]])
    {
        
        UINavigationController *navController = (UINavigationController *)rootViewController;
        
        return [self topViewController:navController.visibleViewController];
    }
    
    // Handling UIViewController's added as subviews to some other views.
    else {
        
        NSInteger subCount = [rootViewController.view subviews].count - 1;
        
        for (NSInteger index = subCount; index >=0 ; --index)
        {
            
            UIView *view = [[rootViewController.view subviews] objectAtIndex:index];
            
            id subViewController = [view nextResponder];    // Key property which most of us are unaware of / rarely use.
            
            if ( subViewController && [subViewController isKindOfClass:[UIViewController class]])
            {
                return [self topViewController:subViewController];
            }
        }
        return rootViewController;
    }
}
@end
