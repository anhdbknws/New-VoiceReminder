//
//  VRLocalNotificationController.h
//  VoiceReminder
//
//  Created by GemCompany on 4/4/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRLocalNotificationController : UIViewController
+ (instancetype)shareInstance;
- (void)processNotification:(UILocalNotification *)notification;
@end
