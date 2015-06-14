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
@property (weak, nonatomic) IBOutlet UIView *hourView;
@property (weak, nonatomic) IBOutlet UIView *minutesView;
@property (weak, nonatomic) IBOutlet UIView *secondView;
@property (weak, nonatomic) IBOutlet UIButton *buttonAlarm;
@property (weak, nonatomic) IBOutlet UIImageView *backGroundImageView;

// view near bottom
@property (weak, nonatomic) IBOutlet UIView *lineView;
@property (weak, nonatomic) IBOutlet UILabel *labelGoodHours;
@property (weak, nonatomic) IBOutlet UILabel *labelLunarYear;
@property (weak, nonatomic) IBOutlet UILabel *labelLunarDay;
@property (weak, nonatomic) IBOutlet UILabel *labelLunarMonth;

// view middle
@property (weak, nonatomic) IBOutlet UILabel *labelGregorianDate;
@property (weak, nonatomic) IBOutlet UILabel *labelGregorianDay;
@property (weak, nonatomic) IBOutlet UILabel *labelGregorianWeek;

@property (weak, nonatomic) IBOutlet UIButton *buttonZodiac;
@property (weak, nonatomic) IBOutlet UILabel *labelIdiom;

// overlay view
@property (weak, nonatomic) IBOutlet UIView *viewOverlay;

// data
@property (nonatomic, strong) NSMutableArray *listImageBackground;
@property (weak, nonatomic) IBOutlet UIWebView *webview;

@end
