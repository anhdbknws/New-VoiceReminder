//
//  VRShortSoundController.h
//  VoiceReminder
//
//  Created by GemCompany on 6/2/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRSettingBaseViewController.h"
#import "VRSoundModel.h"
#import "VRSoundService.h"

@interface VRShortSoundController : VRSettingBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableViewShortSound;
@property (nonatomic, strong) void (^selectShortSoundCompleted)(VRSoundModel *shortSoundModel);
@property (nonatomic, strong) VRSoundModel *soundModel;
@property (nonatomic, strong) VRSoundService *service;
@end
