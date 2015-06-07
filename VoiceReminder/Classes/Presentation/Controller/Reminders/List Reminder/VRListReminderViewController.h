//
//  ListReminderViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 1/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRSettingBaseViewController.h"
@interface VRListReminderViewController : VRSettingBaseViewController
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UITableView *listEventTableview;
@property (nonatomic, strong) UIViewController *rootViewController;
- (void)editAction;
@end
