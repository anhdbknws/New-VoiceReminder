//
//  VRLocalNotificationController.m
//  VoiceReminder
//
//  Created by GemCompany on 4/4/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRLocalNotificationController.h"

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
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Test" message:@"Alarm" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Ok", nil];
    
    [alertView show];
}

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
