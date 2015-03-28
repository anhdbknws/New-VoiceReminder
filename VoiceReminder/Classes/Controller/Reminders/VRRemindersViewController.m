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
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    [self configureListViewControllers];
    [self listenNotification];
}

- (void)listenNotification {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(backAction:)
                                                 name:@"testNotification"
                                               object:nil];
}

#pragma mark - configureUI

- (void)configureListViewControllers {
    self.arrayViewControllers = [NSMutableArray new];
    _calendarController     = [[VRCalendarViewController alloc] init];
    UINavigationController *calendarNavi = [[UINavigationController alloc] initWithRootViewController:_calendarController];
    calendarNavi.title = @"Calender";
    [self.arrayViewControllers addObject:calendarNavi];
    
    _listReminderController = [[VRListReminderViewController alloc] init];
    UINavigationController *listNavi = [[UINavigationController alloc] initWithRootViewController:
                                        _listReminderController];
    listNavi.title = @"List";
    
    [self.arrayViewControllers addObject:listNavi];
    tabbar = [[UITabBarController alloc] init];
    tabbar.delegate = self;
    [tabbar setViewControllers:self.arrayViewControllers animated:YES];
    [self setSelectedButton:0];
    [self.view addSubview:tabbar.view];
}

#pragma mark - Configure Navigation bar
- (void)backAction:(id)sender {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - tabbar delegate
- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController {
    [self setSelectedButton:tabBarController.selectedIndex];
}

- (void)setSelectedButton:(NSInteger)selectedIndex {
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

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

@end
