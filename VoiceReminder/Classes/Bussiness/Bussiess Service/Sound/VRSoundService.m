//
//  VRSoundService.m
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRSoundService.h"
#import "VRCommon.h"
#import "Sound.h"
#import "VRSoundMapping.h"
#import "VRSoundModel.h"

@implementation VRSoundService
- (instancetype)init {
    self = [super init];
    if (self) {
        self.mp3SoundArray = [NSMutableArray new];
        self.recordSoundArray = [NSMutableArray new];
        self.systemSoundArray = [NSMutableArray new];
    }
    
    return self;
}

- (void)getListSounds {
    NSArray *listSound = [Sound MR_findAll];
    for (Sound *entity in listSound) {
        VRSoundModel *model = [[VRSoundModel alloc] initWithEntity:entity];
        if (model.isMp3Sound) {
            [self.mp3SoundArray addObject:model];
        }
        else if (model.isRecordSound){
            [self.recordSoundArray addObject:model];
        }
        else if (model.isSystemSound) {
            [self.systemSoundArray addObject:model];
        }
    }
    
    NSArray *tempSongs = [self.mp3SoundArray sortedArrayUsingComparator:^NSComparisonResult(VRSoundModel *obj1, VRSoundModel *obj2) {
        return [obj1.name compare:obj2.name];
    }];
    
    self.mp3SoundArray = [NSMutableArray arrayWithArray:tempSongs];
    
    VRSoundModel *defaultSong = [VRSoundModel new];
    defaultSong.name = @"Pick a song";
    defaultSong.isDefaultObject = YES;
    [self.mp3SoundArray insertObject:defaultSong atIndex:0];
    
    NSArray *tempRecord = [self.recordSoundArray sortedArrayUsingComparator:^NSComparisonResult(VRSoundModel *obj1, VRSoundModel *obj2) {
        return [obj1.name compare:obj2.name];
    }];
    self.recordSoundArray = [NSMutableArray  arrayWithArray:tempRecord];
    VRSoundModel *defaultRecord = [VRSoundModel new];
    defaultRecord.name = @"Default";
    defaultRecord.isDefaultObject = YES;
    [self.recordSoundArray insertObject:defaultRecord atIndex:0];
    
    if (self.getSoundListCompleted) {
        self.getSoundListCompleted();
    }
}

@end
