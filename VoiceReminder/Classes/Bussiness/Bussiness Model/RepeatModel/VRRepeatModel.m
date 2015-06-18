//
//  VRRepeatModel.m
//  VoiceReminder
//
//  Created by GemCompany on 3/28/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRRepeatModel.h"
#import "Repeat.h"
@implementation VRRepeatModel
- (instancetype)initWithEntity:(Repeat *)entity {
    self = [super init];
    if (self) {
        self.repeatType = entity.repeatType.integerValue;
    }
    
    return self;
}

- (id)copyWithZone:(NSZone *)zone {
    VRRepeatModel *object  = [VRRepeatModel new];
    object.repeatType = self.repeatType;
    
    return object;
}
@end
