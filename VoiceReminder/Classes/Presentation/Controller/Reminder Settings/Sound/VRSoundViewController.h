//
//  VRSoundViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 3/28/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRSoundService.h"
#import "VRSettingBaseViewController.h"

@class VRSoundModel;
typedef NS_ENUM(NSInteger, SOUND_TYPE) {
    SOUND_TYPE_SONG = 1,
    SOUND_TYPE_SHORT_SOUND = 2,
    SOUND_TYPE_RECORD = 0
};

@interface VRSoundViewController : VRSettingBaseViewController
@property (weak, nonatomic) IBOutlet UITableView *tableViewSound;
@property (weak, nonatomic) IBOutlet UISegmentedControl *segment;

@property (nonatomic, strong) VRSoundService *service;
@property (nonatomic, strong) VRSoundModel *soundModel;
@property (nonatomic, strong) void (^selectedSoundCompleted)(VRSoundModel *model);
@end