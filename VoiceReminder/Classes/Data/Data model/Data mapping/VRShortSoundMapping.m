//
//  VRShortSoundMapping.m
//  VoiceReminder
//
//  Created by GemCompany on 6/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRShortSoundMapping.h"
#import "NSManagedObject+voiceReminder.h"

@implementation VRShortSoundMapping
+ (ShortSound *)entityFromModel:(VRShortSoundModel *)model inContext:(NSManagedObjectContext *)context {
    ShortSound *entity = [ShortSound entityWithUuid:model.uuid inContext:context];
    entity.name = model.name;
    entity.createdDate = model.createdDate;
    if (!entity.createdDate) {
        entity.createdDate = [NSDate date];
    }
    
    return entity;
}
@end
