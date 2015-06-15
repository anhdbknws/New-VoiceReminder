//
//  VRShortSoundController.h
//  VoiceReminder
//
//  Created by GemCompany on 6/2/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRSettingBaseViewController.h"
#import "VRShortSoundModel.h"
#import "VRSoundService.h"

@interface VRShortSoundController : VRSettingBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableViewShortSound;
@property (nonatomic, strong) void (^selectShortSoundCompleted)(VRShortSoundModel *shortSoundModel);
@property (nonatomic, strong) VRShortSoundModel *soundModel;
@property (nonatomic, strong) VRSoundService *service;
@end
