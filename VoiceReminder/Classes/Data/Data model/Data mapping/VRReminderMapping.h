//
//  VRReminderMapping.h
//  VoiceReminder
//
//  Created by GemCompany on 2/1/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reminder.h"
#import "BaseObject.h"
#import "VRReminderModel.h"

@class NSManagedObjectContext;
@interface VRReminderMapping : BaseObject
+ (Reminder *)entityFromModel:(VRReminderModel *)model inContext:(NSManagedObjectContext *)context;
@end
