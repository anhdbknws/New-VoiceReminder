//
//  VRSoundModel.h
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"
@class VRReminderModel, Sound;

@interface VRSoundModel : BaseModel
@property (nonatomic, strong) NSString * name;
@property (nonatomic, strong) NSString * url;
@property (nonatomic, strong) NSNumber * persistenID;
@property (nonatomic, strong) VRReminderModel *reminder;
@property (nonatomic, assign) BOOL isDefaultObject;
- (instancetype)initWithEntity:(Sound *)entity;
@end
