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
        self.persistenID = entity.persistenID;
        self.name = entity.name;
    }
    
    return self;
}
@end
