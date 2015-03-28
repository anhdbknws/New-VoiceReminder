//
//  VRReminderModel.m
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderModel.h"
#import "VRCommon.h"

@implementation VRReminderModel

- (instancetype)initWithEntity:(Reminder *)entity {
    self = [super init];
    if (self) {
        _entity = entity;
        [self copyPropertiesFromEntity:entity];
    }
    
    return self;
}

- (void)copyPropertiesFromEntity:(Reminder *)entity {
    self.uuid           = entity.uuid;
    self.createdDate    = entity.createdDate;
    self.name           = entity.name;
    self.nameOfSound    = entity.nameSound;
    self.alertReminder  = [entity.alertReminder integerValue];
//    self.repeatReminder = [entity.repeatReminder integerValue];
    self.timeReminder   = [[VRCommon commonDateTimeFormat] stringFromDate:entity.timeReminder];
    self.urlSound       = entity.urlSound;
    self.isActive       = entity.isActive;
}


@end
