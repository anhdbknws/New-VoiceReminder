//
//  ListReminderViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 1/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRListReminderViewController : UIViewController
@property (nonatomic, strong) UISegmentedControl *segmentControl;
@property (nonatomic, strong) UITableView *listEvents;
@property (nonatomic, strong) UIViewController *rootViewController;
- (void)editAction;
@end
