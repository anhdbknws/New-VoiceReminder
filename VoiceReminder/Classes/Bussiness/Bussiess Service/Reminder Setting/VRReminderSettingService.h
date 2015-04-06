//
//  VRReminderSettingService.h
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reminder.h"
#import "VRReminderMapping.h"
#import "VRReminderModel.h"

@interface VRReminderSettingService : NSObject
- (void)addReminder:(VRReminderModel *)model toDatabaseLocalWithCompletionhandler:(databaseHandler)completion;
- (BOOL)validateModel:(VRReminderModel *)model errorMessage:(NSString **)errorMessage;
- (NSString *)getRepeatStringFrom:(NSMutableArray *)listRepeat;
@end
