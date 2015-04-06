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
        self.songArray = [NSMutableArray new];
        self.recordArray = [NSMutableArray new];
    }
    
    return self;
}

- (void)saveSoundWithModel:(VRSoundModel *)model toDatabaseLocalWithCompletionhandler:(databaseHandler)completion {
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        [VRSoundMapping entityFromModel:model inContext:localContext];
    } completion:^(BOOL success, NSError *error) {
        VRSoundModel *result = nil;
        Sound *entity = [Sound MR_findFirstByAttribute:VRUUID withValue:model.uuid];
        if (entity) {
            result = [[VRSoundModel alloc] initWithEntity:entity];
        }
        
        if(completion) {
            completion (nil, result);
        }
    }];
}

- (void)getListSounds {
    NSArray *listSound = [Sound MR_findAll];
    for (Sound *entity in listSound) {
        VRSoundModel *model = [[VRSoundModel alloc] initWithEntity:entity];
        if (model.persistenID) {
            [self.songArray addObject:model];
        }
        else {
            [self.recordArray addObject:model];
        }
    }
    
    NSArray *tempSongs = [self.songArray sortedArrayUsingComparator:^NSComparisonResult(VRSoundModel *obj1, VRSoundModel *obj2) {
        return [obj1.name compare:obj2.name];
    }];
    self.songArray = [NSMutableArray arrayWithArray:tempSongs];
    
    VRSoundModel *defaultSong = [VRSoundModel new];
    defaultSong.name = @"Pick a song";
    defaultSong.isDefaultObject = YES;
    [self.songArray insertObject:defaultSong atIndex:0];
    
    NSArray *tempRecord = [self.recordArray sortedArrayUsingComparator:^NSComparisonResult(VRSoundModel *obj1, VRSoundModel *obj2) {
        return [obj1.name compare:obj2.name];
    }];
    self.recordArray = [NSMutableArray  arrayWithArray:tempRecord];
    VRSoundModel *defaultRecord = [VRSoundModel new];
    defaultRecord.name = @"Default";
    defaultRecord.isDefaultObject = YES;
    [self.recordArray insertObject:defaultRecord atIndex:0];
    
    if (self.getSoundListCompleted) {
        self.getSoundListCompleted();
    }
}
@end
