//
//  VRReCordViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 1/10/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "VRSettingBaseViewController.h"
#import "VRSoundService.h"

@class CircleProgressView, VRSoundModel;
@interface VRReCordViewController : VRSettingBaseViewController
@property (nonatomic, strong) CircleProgressView *circleView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *stopButton;
@property (nonatomic, strong) UIButton *reRecordButton;
@property (nonatomic, strong) UIButton *playButton;

@property (nonatomic, assign) BOOL isComeFromMainScreen;
@property (nonatomic, copy) void (^recordCompleted)(VRSoundModel *fileName);
@property (nonatomic, strong) VRSoundService *soundService;

@end
