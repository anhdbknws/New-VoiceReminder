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
#import "Photo.h"
#import "VRSoundModel.h"
#import "VRSoundMapping.h"
#import "VRShortSoundMapping.h"

@implementation VRReminderMapping
+ (Reminder*)entityFromModel:(VRReminderModel *)model inContext:(NSManagedObjectContext *)context {
    Reminder *entity = [Reminder entityWithUuid:model.uuid inContext:context];
    entity.name = model.name;
    entity.alertReminder = [NSNumber numberWithInteger:model.alertReminder];
    entity.timeReminder = [[VRCommon commonDateTimeFormat] dateFromString:model.timeReminder];
    entity.createdDate = model.createdDate;
    entity.isActive = [NSNumber numberWithBool:YES];
    entity.notes = model.notes;
    entity.completed = [NSNumber numberWithBool:model.completed];
    entity.sound = [VRSoundMapping entityFromModel:model.soundModel inContext:context];
    entity.shortSound = [VRShortSoundMapping entityFromModel:model.shortSoundModel inContext:context];
    
    [entity removePhotos:entity.photos];
    for (NSString *url in model.photoList) {
        Photo * photo = [Photo MR_createInContext:context];
        photo.uuid = [NSUUID UUID].UUIDString;
        photo.url = url;
        photo.index = @([model.photoList indexOfObject:url]);
        [entity addPhotosObject:photo];
    }
    
    return entity;
}


@end
