//
//  VRLocalNotificationController.h
//  VoiceReminder
//
//  Created by GemCompany on 4/4/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
@class VRReminderModel;

@interface VRLocalNotificationController : UIViewController
+ (instancetype)shareInstance;
- (void)processNotification:(UILocalNotification *)notification;

- (void)gotoDetail:(UILocalNotification *)notification;

@end
