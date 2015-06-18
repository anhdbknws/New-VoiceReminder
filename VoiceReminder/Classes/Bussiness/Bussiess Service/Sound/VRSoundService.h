//
//  VRSoundService.h
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>


@class VRSoundModel;
@interface VRSoundService : NSObject
@property (nonatomic, strong) NSMutableArray *shortSoundArray;
@property (nonatomic, strong) NSMutableArray *mp3SoundArray;
@property (nonatomic, strong) NSMutableArray *recordSoundArray;
@property (nonatomic, strong) NSMutableArray *systemSoundArray;
@property (nonatomic, strong) void (^getSoundListCompleted)();

- (void)getListSounds;
- (void)saveRecordSoundToDB:(VRSoundModel *)model completion:(databaseHandler)completed;
@end
