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
@property (nonatomic , strong) NSMutableArray *songArray;
@property (nonatomic , strong) NSMutableArray *recordArray;
@property (nonatomic , strong) void (^getSoundListCompleted)();

- (void)saveSoundWithModel:(VRSoundModel *)model toDatabaseLocalWithCompletionhandler:(databaseHandler)completion;
- (void)getListSounds;
@end
