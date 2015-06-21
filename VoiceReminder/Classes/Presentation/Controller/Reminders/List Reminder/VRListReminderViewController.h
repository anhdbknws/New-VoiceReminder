//
//  ListReminderViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 1/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRReminderListBaseController.h"
typedef NS_ENUM(NSInteger, LIST_REMINDER_TYPE) {
    LIST_REMINDER_TYPE_COMPLETED = 2,
    LIST_REMINDER_TYPE_ACTIVE = 0,
    LIST_REMINDER_TYPE_ALL = 1
};

@interface VRListReminderViewController : VRReminderListBaseController
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UITableView *listEventTableview;
@property (nonatomic, strong) UIViewController *rootViewController;

- (void)editAction;

- (void)doneAction;
@end
