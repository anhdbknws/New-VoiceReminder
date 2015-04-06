//
//  VRSoundViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 3/28/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRSoundService.h"
@class VRSoundModel;
typedef NS_ENUM(NSInteger, SOUND_SECTION_TYPE) {
    SOUND_SECTION_TYPE_RECORD = 0,
    SOUND_SECTION_TYPE_SONGS = 1,
};

@interface VRSoundViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tableViewSound;
@property (nonatomic, strong) VRSoundService *service;
@property (nonatomic, strong) VRSoundModel *selectedSoundModel;
@property (nonatomic, strong) void (^selectedSoundCompleted)(VRSoundModel *model);
@end
