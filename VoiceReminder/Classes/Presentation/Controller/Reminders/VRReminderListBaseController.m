//
//  VRReminderListBaseController.m
//  VoiceReminder
//
//  Created by GemCompany on 6/7/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderListBaseController.h"
#import "VRReminderModel.h"

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

- (void)updateStatusFor:(VRReminderModel *)model CompletionHandler:(databaseHandler)completion{
    if (!_service) {
        _service = [[VRReminderListService alloc] init];
    }
    
    [_service setStatusForReminder:model completionHandler:^(NSError *error, id result) {
        if (completion) {
            completion(error, result);
        }
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
