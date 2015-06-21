//
//  VRReminderModel.m
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderModel.h"
#import "VRCommon.h"
#import "Photo.h"
#import "VRSoundModel.h"
#import "Repeat.h"
#import "VRRepeatModel.h"

@implementation VRReminderModel

- (instancetype)initWithEntity:(Reminder *)entity {
    self = [super init];
    if (self) {
        _entity = entity;
        self.uuid           = entity.uuid;
        self.createdDate    = entity.createdDate;
        self.name           = entity.name;
        self.alertReminder  = [entity.alertReminder integerValue];
        self.timeReminder   = [[VRCommon commonDateTimeFormat] stringFromDate:entity.timeReminder];
        self.isActive       = entity.isActive.boolValue;
        self.notes          = entity.notes;
    }
    
    return self;
}

- (NSMutableArray *)photoList
{
    if (!_photoList) {
        _photoList = [NSMutableArray new];
        NSArray * photos = _entity.photos.allObjects;
        photos = [photos sortedArrayUsingComparator:^NSComparisonResult(Photo * obj1, Photo * obj2) {
            return [obj1.index compare:obj2.index];
        }];
        for (Photo * photo in photos)
            [_photoList addObject:photo.url];
    }
    return _photoList;
}

- (VRSoundModel *)soundModel {
    if (!_soundModel) {
        if (_entity.sound) {
            _soundModel = [[VRSoundModel alloc] initWithEntity:_entity.sound];
        }
    }
    
    return _soundModel;
}

- (VRShortSoundModel *)shortSoundModel {
    if (!_shortSoundModel) {
        if (_entity.shortSound) {
            _shortSoundModel = [[VRShortSoundModel alloc] initWithEntity:_entity.shortSound];
        }
    }
    
    return _shortSoundModel;
}

- (NSMutableArray *)repeats {
    if (!_repeats) {
        _repeats = [NSMutableArray new];
        for (Repeat *object in _entity.repeats) {
            VRRepeatModel *model = [[VRRepeatModel alloc] initWithEntity:object];
            [_repeats addObject:model];
        }
    }
    
    return _repeats;
}

- (id)copyWithZone:(NSZone *)zone {
    VRReminderModel *object = [[VRReminderModel alloc] init];
    object.name = [self.name copyWithZone:zone];
    object.timeReminder = [self.timeReminder copyWithZone:zone];
    object.repeats = [[NSMutableArray alloc] initWithArray:self.repeats copyItems:YES];
    object.photoList = [[NSMutableArray alloc] initWithArray:self.photoList copyItems:YES];
    object.isActive = self.isActive;
    object.alertReminder = self.alertReminder;
    object.soundModel = [self.soundModel copyWithZone:zone];
    object.shortSoundModel = [self.shortSoundModel copyWithZone:zone];
    object.entity = self.entity;
    return object;
}
@end
