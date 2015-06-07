//
//  VRReminderListBaseController.h
//  VoiceReminder
//
//  Created by GemCompany on 6/7/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRReminderListService.h"

@interface VRReminderListBaseController : UIViewController
@property (nonatomic, strong) VRReminderListService *service;
/*
 * get list reminder from db local
 */
- (void)getReminderFromDBLocalCompletionHandler:(databaseHandler)completion;

/*
 * update status reminder (active or not active)
 */

- (void)updateStatus:(BOOL)status;
@end
