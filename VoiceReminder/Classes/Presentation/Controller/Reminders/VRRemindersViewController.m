//
//  VRRemindersViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/10/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRRemindersViewController.h"
#import "VRCalendarViewController.h"
#import "VRListReminderViewController.h"

NSString *kNotificationName1 = @"testNotification";
@interface VRRemindersViewController ()<UITabBarControllerDelegate>
@property (nonatomic, strong) VRCalendarViewController *calendarController;
@property (nonatomic, strong) VRListReminderViewController *listReminderController;
@property (nonatomic, strong) NSMutableArray *arrayViewControllers;
@property (nonatomic, assign) BOOL selectLock;
@end

@implementation VRRemindersViewController
{
    UITabBarController *tabbar;
    NSInteger selectedIndex;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        self.title = @"List reminders";
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    self.view.backgroundColor = [UIColor whiteColor];
    [self createListViewControllers];
    
    [self leftNavigationItem:nil andTitle:@"Back" orImage:nil];
    
    [self rightNavigationItem:@selector(editAction:) andTitle:@"Edit" orImage:nil];
}

- (void)viewDidLayoutSubviews {
    self.navigationController.navigationBar.translucent = NO;
}
#pragma mark - configureUI

- (void)createListViewControllers {
    self.arrayViewControllers = [NSMutableArray new];
    _calendarController     = [[VRCalendarViewController alloc] init];
    _calendarController.title = @"Calender";
    
    [self.arrayViewControllers addObject:_calendarController];
    
    _listReminderController = [[VRListReminderViewController alloc] init];
    _listReminderController.title = @"List";
    _listReminderController.rootViewController = self;
    
    [self.arrayViewControllers addObject:_listReminderController];
    tabbar = [[UITabBarController alloc] init];
    tabbar.tabBar.backgroundColor = [UIColor blueColor];
    tabbar.delegate = self;
    [tabbar setViewControllers:self.arrayViewControllers animated:YES];
    selectedIndex = 0;
    [self setSelectedButton];
    [self.view addSubview:tabbar.view];
}

#pragma mark - Configure Navigation bar
- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - tabbar delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    selectedIndex = tabBarController.selectedIndex;
    [self setSelectedButton];
}

- (void)setSelectedButton {
    [self rightNavigationItem:@selector(editAction:) andTitle:@"Edit" orImage:nil];
    UIViewController *selectedVC = nil;
    UIViewController *otherVC = nil;
    if (selectedIndex == 0) {
        selectedVC = self.arrayViewControllers[0];
        otherVC = self.arrayViewControllers[1];
    }
    else {
        selectedVC = self.arrayViewControllers[1];
        otherVC = self.arrayViewControllers[0];
    }
    
    selectedVC.tabBarItem.image = [UIImage imageNamed:@"1.png"];
    otherVC.tabBarItem.image = [UIImage imageNamed:@"1.png"];
}

- (BOOL)tabBarController:(UITabBarController *)tabBarController shouldSelectViewController:(UIViewController *)viewController {
    return !self.selectLock;
}

#pragma mark - Actions
- (void)editAction:(id)sender {
    if (selectedIndex == 0) {
        [_calendarController editAction];
    }
    else {
        [_listReminderController editAction];
    }
    
    [self rightNavigationItem:@selector(doneAction:) andTitle:@"Done" orImage:nil];
}

- (void)doneAction:(id)sender {
    if (selectedIndex == 0) {
        [_calendarController doneAction];
    }
    else {
        [_listReminderController doneAction];
    }
    [self rightNavigationItem:@selector(editAction:) andTitle:@"Edit" orImage:nil];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
