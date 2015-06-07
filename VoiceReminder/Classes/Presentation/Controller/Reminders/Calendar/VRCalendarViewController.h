//
//  VRCalendarViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 1/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JTCalendar.h"
#import "JTCalendarMenuView.h"
#import "JTCalendarContentView.h"
#import "VRReminderListBaseController.h"

@interface VRCalendarViewController : VRReminderListBaseController
@property (nonatomic, strong) JTCalendarMenuView *menuView;
@property (nonatomic, strong) JTCalendarContentView *contentView;
@property (nonatomic, strong) UITableView *listEventTableview;
@property (nonatomic, strong) JTCalendar *calendar;
@property (nonatomic, strong) UIView *horizontalView;

- (void)editAction;
@end
