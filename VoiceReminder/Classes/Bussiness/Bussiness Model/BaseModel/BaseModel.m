//
//  BaseModel.m
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "BaseModel.h"

@implementation BaseModel
- (instancetype)init
{
    if (self = [super init]) {
        self.uuid = [NSUUID UUID].UUIDString;
        self.createdDate = [NSDate date];
    }
    return self;
}
@end
