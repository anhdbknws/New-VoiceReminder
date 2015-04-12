//
//  VRReminderModel.h
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
#import "Reminder.h"

@class VRSoundModel;
@interface VRReminderModel : BaseModel <NSCopying>
@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) VRSoundModel *soundModel;
@property (nonatomic, strong) NSString *nameOfSound;
@property (nonatomic, strong) NSString *timeReminder;
@property (nonatomic, strong) NSMutableArray *repeats;
@property (strong, nonatomic) NSMutableArray * photoList;
@property (nonatomic, assign) ALERT_TYPE alertReminder;
@property (nonatomic, assign) BOOL isActive;
@property (nonatomic, strong) Reminder *entity;
- (instancetype)initWithEntity:(Reminder *)entity;
@end
