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
#import "ShortSound.h"
#import "VRShortSoundModel.h"
#import "VRShortSoundMapping.h"

@implementation VRSoundService
- (instancetype)init {
    self = [super init];
    if (self) {
        self.mp3SoundArray = [NSMutableArray new];
        self.recordSoundArray = [NSMutableArray new];
        self.systemSoundArray = [NSMutableArray new];
        self.shortSoundArray = [NSMutableArray new];
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
        else {
            [self.systemSoundArray addObject:model];
        }
    }
    
    /* musics */
    NSArray *tempSongs = [self.mp3SoundArray sortedArrayUsingComparator:^NSComparisonResult(VRSoundModel *obj1, VRSoundModel *obj2) {
        return [obj1.name compare:obj2.name];
    }];
    
    self.mp3SoundArray = [NSMutableArray arrayWithArray:tempSongs];
    
    
    /* record sound*/
    NSArray *tempRecord = [self.recordSoundArray sortedArrayUsingComparator:^NSComparisonResult(VRSoundModel *obj1, VRSoundModel *obj2) {
        return [obj1.name compare:obj2.name];
    }];
    
    self.recordSoundArray = [NSMutableArray  arrayWithArray:tempRecord];
    
    /*short sound*/
    NSArray *listShortSound = [ShortSound MR_findAll];
    for (ShortSound *entity in listShortSound) {
        VRShortSoundModel *model = [[VRShortSoundModel alloc] initWithEntity:entity];
        [_shortSoundArray addObject:model];
    }
    
    if (self.getSoundListCompleted) {
        self.getSoundListCompleted();
    }
}

- (void)saveRecordSoundToDB:(VRSoundModel *)model completion:(databaseHandler)completed {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [VRSoundMapping entityFromModel:model inContext:localContext];
    } completion:^(BOOL success, NSError *error) {
        VRSoundModel *result;
        Sound *entity = [Sound MR_findFirstByAttribute:@"uuid" withValue:model.uuid];
        if (entity) {
            result = [[VRSoundModel alloc] initWithEntity:entity];
        }
        
        if (completed) {
            completed(nil, result);
        }
    }];
}
@end
