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
    self.timeReminder   = [[VRCommon commonDateTimeFormat] stringFromDate:entity.timeReminder];
    self.isActive       = entity.isActive.boolValue;
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
@end
