//
//  VRRepeatModel.h
//  VoiceReminder
//
//  Created by GemCompany on 3/28/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BaseModel.h"

@class VRReminderModel;
@interface VRRepeatModel : BaseModel
@property (nonatomic, assign) REPEAT_TYPE repeatType;
@property (nonatomic, strong) VRReminderModel *reminder;
@end
