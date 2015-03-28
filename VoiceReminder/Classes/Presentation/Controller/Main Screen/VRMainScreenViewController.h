//
//  VRMainScreenViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 1/10/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SBTickerView.h"

@interface VRMainScreenViewController : UIViewController
@property (weak, nonatomic) IBOutlet UIButton *recordButton;
@property (weak, nonatomic) IBOutlet UIButton *remindersButton;
@property (weak, nonatomic) IBOutlet SBTickerView *clockTickerHour1;
@property (weak, nonatomic) IBOutlet SBTickerView *clockTickerHour2;
@property (weak, nonatomic) IBOutlet SBTickerView *clockTickerMinutes1;
@property (weak, nonatomic) IBOutlet SBTickerView *clockTickerMinutes2;
@property (weak, nonatomic) IBOutlet SBTickerView *clockTickerSecond1;
@property (weak, nonatomic) IBOutlet SBTickerView *clockTickerSecond2;

@end
