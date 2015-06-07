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
@property (nonatomic, strong) NSMutableArray *listReminderAll;
@property (nonatomic, strong) NSMutableArray *listReminderActive;
@property (nonatomic, strong) NSMutableArray *listReminderCompleted;
- (void)deleteReminderWithUUID:(NSString *)uuid completionHandler:(databaseHandler)completion;
- (void)getListReminderFromDB;
- (void)setStatusForReminder:(VRReminderModel *)model withState:(BOOL)active completionHandler:(databaseHandler)completion;
@end
