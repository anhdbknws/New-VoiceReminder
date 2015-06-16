//
//  VRMainPageViewController.m
//  VoiceReminder
//
//  Created by Điệp Nguyễn on 6/16/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRMainPageViewController.h"
#import "VRMainScreenViewController.h"

@interface VRMainPageViewController ()

@end

@implementation VRMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [[self view] addSubview:[self.pageController view]];
    self.pageController.dataSource = self;
    
    [self.pageController.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.pageController.view autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [self.pageController.view autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [self.pageController.view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50];
    
    VRMainScreenViewController *initialViewController = [self viewControllerAtIndex:[NSDate date]];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initialViewController];
    
    [self.pageController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageController];
    
    [self.pageController didMoveToParentViewController:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    VRMainScreenViewController *previousVC = (VRMainScreenViewController *)viewController;
    NSDate  *displayDate = [previousVC displayDate];
    [previousVC.webview stringByEvaluatingJavaScriptFromString:@"_flipRight()"];
    //    if (index == 0) {
    //        return nil;
    //    }
    
    // Decrease the index by 1 to return
//    index--;
    
    return [self viewControllerAtIndex:[VRCommon minusOneDayFromDate:displayDate]];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
   
    VRMainScreenViewController *nextVC = (VRMainScreenViewController *)viewController;
     NSDate *displayDate = [nextVC displayDate];
    [nextVC.webview stringByEvaluatingJavaScriptFromString:@"_flipLeft()"];
    
//    index++;
    
    //    if (index == 5) {
    //        return nil;
    //    }
    
    return [self viewControllerAtIndex:[VRCommon addOneDayToDate:displayDate]];
    
}

- (VRMainScreenViewController *)viewControllerAtIndex:(NSDate *)date {
    
    VRMainScreenViewController *childViewController = [[VRMainScreenViewController alloc] initWithNibName:@"VRMainScreenViewController" bundle:nil];
    
    childViewController.displayDate = date;
    
    return childViewController;
    
}
@end
