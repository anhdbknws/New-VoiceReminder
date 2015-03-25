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

@interface VRCalendarViewController : UIViewController
@property (nonatomic, strong) JTCalendarMenuView *menuView;
@property (nonatomic, strong) JTCalendarContentView *contentView;
@property (nonatomic, strong) UITableView *listEventTableView;
@property (nonatomic, strong) JTCalendar *calendar;
- (void)editAction;
@end
