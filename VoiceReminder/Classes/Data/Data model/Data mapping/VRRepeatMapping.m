//
//  VRRepeatMapping.m
//  VoiceReminder
//
//  Created by GemCompany on 3/28/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRRepeatMapping.h"
#import "Repeat.h"
#import "VRRepeatModel.h"
#import "NSManagedObject+voiceReminder.h"

@implementation VRRepeatMapping
+ (Repeat *)entityFromModel:(VRRepeatModel *)model inContext:(NSManagedObjectContext *)context {
    Repeat *entity = [Repeat entityWithUuid:model.uuid inContext:context];
    entity.repeatType = [NSNumber numberWithInteger:model.repeatType];
    return entity;
}
@end
