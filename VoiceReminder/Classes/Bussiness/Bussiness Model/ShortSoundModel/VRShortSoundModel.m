//
//  VRShortSoundModel.m
//  VoiceReminder
//
//  Created by GemCompany on 6/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRShortSoundModel.h"

@implementation VRShortSoundModel
- (instancetype)initWithEntity:(ShortSound *)entity {
    self = [super init];
    if (self) {
        self.uuid = entity.uuid;
        self.createdDate = entity.createdDate;
        self.name = entity.name;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    VRShortSoundModel *object = [VRShortSoundModel new];
    object.uuid = [self.uuid copyWithZone:zone];
    object.createdDate = [self.createdDate copyWithZone:zone];
    object.name = [self.name copyWithZone:zone];
    return object;
}
@end
