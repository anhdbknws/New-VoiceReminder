//
//  VRSoundMapping.m
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRSoundMapping.h"
#import "Sound.h"
#import "VRSoundModel.h"
#import "NSManagedObject+voiceReminder.h"
@implementation VRSoundMapping
+ (Sound *)entityFromModel:(VRSoundModel *)model inContext:(NSManagedObjectContext *)context {
    Sound *entity = [Sound entityWithUuid:model.uuid inContext:context];
    entity.url = model.url;
    entity.persistenID = model.persistenID;
    entity.name = model.name;
    return entity;
}
@end
