//
//  VRShortSoundModel.h
//  VoiceReminder
//
//  Created by GemCompany on 6/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "VRReminderModel.h"
#import "ShortSound.h"
@interface VRShortSoundModel : BaseModel <NSCopying>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) VRReminderModel *reminderModel;
- (instancetype)initWithEntity:(ShortSound *)entity;
@end
