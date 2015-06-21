//
//  VRLocalNotificationController.m
//  VoiceReminder
//
//  Created by GemCompany on 4/4/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRLocalNotificationController.h"
#import "VRReminderModel.h"
#import "Reminder.h"
#import "UIAlertView+VR.h"
#import "VRReminderDetailController.h"
#import "VRUtilities.h"

@interface VRLocalNotificationController ()

@end

@implementation VRLocalNotificationController

+ (instancetype)shareInstance {
    static VRLocalNotificationController *share = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        share = [[VRLocalNotificationController alloc] init];
    });
    
    return share;
}

- (void)processNotification:(UILocalNotification *)notification {
    NSString *uuid = [notification.userInfo objectForKey:@"uuid"];
    Reminder *entity = [Reminder MR_findFirstByAttribute:@"uuid" withValue:uuid];
    VRReminderModel *model = [[VRReminderModel alloc] initWithEntity:entity];
    
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:model.name message:model.notes delegate:self cancelButtonTitle:@"Close" otherButtonTitles:@"Detail", nil];
    [alertView showAlerViewWithHandler:^(UIAlertView *alertView, NSInteger buttonIndex) {
        switch (buttonIndex) {
            case 0:
                break;
            case 1:
                [self showDetailReminder:model];
                break;
            default:
                break;
        }
    }];
}

- (void)gotoDetail:(UILocalNotification *)notification {
    NSString *uuid = [notification.userInfo objectForKey:@"uuid"];
    Reminder *entity = [Reminder MR_findFirstByAttribute:@"uuid" withValue:uuid];
    VRReminderModel *model = [[VRReminderModel alloc] initWithEntity:entity];
    [self showDetailReminder:model];
}

- (void)showDetailReminder:(VRReminderModel *)model {
    VRReminderDetailController *vc = [[VRReminderDetailController alloc] initWithNibName:NSStringFromClass([VRReminderDetailController class]) bundle:nil];
    vc.model = model;
    UIViewController *topviewController = [VRUtilities topViewController];
    [topviewController.navigationController pushViewController:vc
                                                      animated:YES];
}

- (void)removeScheduleFromSystem {
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
