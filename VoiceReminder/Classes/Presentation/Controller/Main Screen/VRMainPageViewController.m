//
//  VRMainPageViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 6/17/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRMainPageViewController.h"
#import "VRMainScreenViewController.h"

@interface VRMainPageViewController ()

@end

@implementation VRMainPageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStylePageCurl navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    self.pageViewController.dataSource = self;
    
    [self.view addSubview:self.pageViewController.view];
    
    [self.pageViewController.view autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.pageViewController.view autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [self.pageViewController.view autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [self.pageViewController.view autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    VRMainScreenViewController *initVC = [self viewControllerAtIndex:[NSDate date]];
    
    NSArray *viewControllers = [NSArray arrayWithObject:initVC];
    
    [self.pageViewController setViewControllers:viewControllers direction:UIPageViewControllerNavigationDirectionForward animated:NO completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.pageViewController didMoveToParentViewController:self];
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (VRMainScreenViewController *)viewControllerAtIndex:(NSDate *)date {
    
    VRMainScreenViewController *childViewController = [[VRMainScreenViewController alloc] initWithNibName:NSStringFromClass([VRMainScreenViewController class]) bundle:nil];
    childViewController.displayDate = date;
    
    return childViewController;
    
}

#pragma mark - pageview datasource
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    
    NSDate *oldDate = [(VRMainScreenViewController *)viewController displayDate];
    
    // Decrease the date by 1 day to return
    NSDate *newDate = [VRCommon minusOneDayFromDate:oldDate];
    
    return [self viewControllerAtIndex:newDate];
    
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    
    NSDate *oldDate = [(VRMainScreenViewController *)viewController displayDate];
    
    // increase the date by 1 day to return
    NSDate *newDate = [VRCommon addOneDayToDate:oldDate];
    
    return [self viewControllerAtIndex:newDate];
    
}
@end
