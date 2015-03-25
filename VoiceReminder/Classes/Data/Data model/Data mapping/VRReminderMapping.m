//
//  VRReminderMapping.m
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderMapping.h"
#import "NSManagedObject+voiceReminder.h"
#import "VRCommon.h"

@implementation VRReminderMapping
+ (Reminder*)entityFromModel:(VRReminderModel *)model inContext:(NSManagedObjectContext *)context {
    Reminder *entity = [Reminder entityWithUuid:model.uuid inContext:context];
    entity.name = model.name;
    entity.alertReminder = [NSNumber numberWithInteger:model.alertReminder];
//    entity.repeatReminder = [NSNumber numberWithInteger:model.repeatReminder];
    entity.timeReminder = [[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder];
    entity.urlSound = model.urlSound;
    entity.nameSound = model.nameOfSound;
    entity.createdDate = model.createdDate;
    entity.isActive = [NSNumber numberWithBool:YES];
    return entity;
}
@end
