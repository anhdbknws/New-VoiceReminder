//
//  VRMainPageViewController.h
//  VoiceReminder
//
//  Created by Điệp Nguyễn on 6/16/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRMainPageViewController : UIViewController <UIPageViewControllerDataSource>
@property (strong, nonatomic) UIPageViewController *pageController;
@end
