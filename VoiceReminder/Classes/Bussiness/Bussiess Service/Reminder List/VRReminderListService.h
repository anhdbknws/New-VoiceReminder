//
//  VRRemiderListService.h
//  VoiceReminder
//
//  Created by GemCompany on 3/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <Foundation/Foundation.h>
@class VRReminderModel;
@interface VRReminderListService : NSObject
@property (nonatomic, strong) NSMutableArray *listReminder;
- (void)deleteReminderWithUUID:(NSString *)uuid completionHandler:(databaseHandler)completion;
- (void)getListReminderActive;
- (void)getListReminderAll;
- (void)getListReminderCompleted;
@end
