//
//  VRSoundModel.m
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRSoundModel.h"
#import "Sound.h"
@implementation VRSoundModel
- (instancetype)initWithEntity:(Sound *)entity {
    self = [super init];
    if (self) {
        self.uuid = entity.uuid;
        self.url = entity.url;
        self.name = entity.name;
        self.isMp3Sound = entity.isMp3Sound.boolValue;
        self.isRecordSound = entity.isRecordSound.boolValue;
        self.isSystemSound = entity.isSystemSound.boolValue;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    VRSoundModel *object = [VRSoundModel new];
    object.uuid = [self.uuid copyWithZone:zone];
    object.name = [self.name copyWithZone:zone];
    object.url = [self.url copyWithZone:zone];
    object.mp3Url = [self.mp3Url copyWithZone:zone];
    object.isMp3Sound = self.isMp3Sound;
    object.isRecordSound = self.isRecordSound;
    object.isSystemSound = self.isSystemSound;
    return object;
}

- (NSString *)metadata {
    NSString *fullString = [NSString stringWithFormat:@"%@%@%@%@%@%@", self.name, self.url, self.mp3Url, @(self.isMp3Sound), @(self.isRecordSound), @(self.isSystemSound)];
    return fullString;
}
@end
