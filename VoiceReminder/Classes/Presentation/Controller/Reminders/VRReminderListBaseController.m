//
//  VRReminderListBaseController.m
//  VoiceReminder
//
//  Created by GemCompany on 6/7/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderListBaseController.h"

@interface VRReminderListBaseController ()

@end

@implementation VRReminderListBaseController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)getReminderFromDBLocalCompletionHandler:(databaseHandler)completion {
    if (!_service) {
        _service = [[VRReminderListService alloc] init];
    }
    
    [_service getListReminderFromDBWithcompletionHandler:^(NSError *error, id result) {
        if (completion) {
            completion(error, result);
        }
    }];
}

- (void)updateStatus:(BOOL)status {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
