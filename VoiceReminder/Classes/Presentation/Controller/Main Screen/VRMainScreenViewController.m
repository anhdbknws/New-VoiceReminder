//
//  VRMainScreenViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/10/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRMainScreenViewController.h"
#import "VRReCordViewController.h"
#import "VRRemindersViewController.h"
#import "VRLocalizeKey.h"
#import "VRLocalizationCenter.h"
#import "SBTickerView.h"
#import "SBTickView.h"
#import "VRReminderSettingViewController.h"
#import "VRSoundMapping.h"
#import "VRSoundModel.h"

@interface VRMainScreenViewController ()

@end

@implementation VRMainScreenViewController
{
    NSString *_currentClock;
    NSArray *_clockTickers;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self getdate];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureUI];
    [self configureClockTicker];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kSaveShortSoundToDBLocal]) {
        [self saveShortSoundModelToDB];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

-(void)getdate {
    NSDateFormatter *dateFormat = [[NSDateFormatter alloc] init];
    [dateFormat setDateFormat:@"yyyy-MM-dd"];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    [format setDateFormat:@"MMM dd, yyyy HH:mm"];
    NSDateFormatter *timeFormat = [[NSDateFormatter alloc] init];
    [timeFormat setDateFormat:@"HH:mm:ss"];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init] ;
    [dateFormatter setDateFormat:@"EEEE"];
    
    NSDate *now = [[NSDate alloc] init];
    NSString *dateString = [VRCommon commonFormatFromDate:now];
    NSString *theDate = [dateFormat stringFromDate:now];
    NSString *theTime = [timeFormat stringFromDate:now];
    
    NSString *week = [dateFormatter stringFromDate:now];
    NSLog(@"\n"
          "theDate: |%@| \n"
          "theTime: |%@| \n"
          "Now: |%@| \n"
          "Week: |%@| \n"
          , theDate, theTime,dateString,week);
}



#pragma mark - ConfigureUI

- (void)configureUI {
    self.view.backgroundColor = [UIColor whiteColor];
    
    // button view
    [self configButton:self.recordButton WithTittle:[@"Record" uppercaseString]];
    [self.recordButton addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];

    [self configButton:self.remindersButton WithTittle:[@"Reminder" uppercaseString]];
    [self.remindersButton addTarget:self action:@selector(remindersAction:) forControlEvents:UIControlEventTouchUpInside];
    [self configButton:self.buttonAlarm WithTittle:[@"alarm" uppercaseString]];
    [self.buttonAlarm addTarget:self action:@selector(alarmAction:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *views = @[self.recordButton, self.buttonAlarm, self.remindersButton];
    [views autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:0.0 insetSpacing:YES matchedSizes:YES];
    // tick view
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(numberTick:) userInfo:nil repeats:YES];
    [self.backGroundImageView setImage:[UIImage imageNamed:@"q0.jpg"]];
    
    // near button view
    self.lineView.backgroundColor = [UIColor colorWithRed:215/255.0 green:215/255.0 blue:215/255.0 alpha:1];
    
    // middle view
    self.buttonZodiac.layer.cornerRadius = 14;
    self.buttonZodiac.layer.borderWidth = 2.0f;
    self.buttonZodiac.layer.borderColor = [UIColor redColor].CGColor;
    self.buttonZodiac.backgroundColor = [UIColor whiteColor];
    [self.buttonZodiac setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
}

- (void)configButton:(UIButton *)button WithTittle:(NSString *)title {
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor redColor]];
//    button.layer.cornerRadius = 8;
//    button.layer.borderWidth = 1.0f;
//    button.layer.borderColor = [UIColor blueColor].CGColor;
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)configureClockTicker {
    //Init
    _currentClock = @"000000";
    _clockTickers = [NSArray arrayWithObjects:
                     _clockTickerHour1,
                     _clockTickerHour2,
                     _clockTickerMinutes1,
                     _clockTickerMinutes2,
                     _clockTickerSecond1,
                     _clockTickerSecond2, nil];
    
    for (SBTickerView *ticker in _clockTickers)
        [ticker setFrontView:[SBTickView tickViewWithTitle:@"0" fontSize:30.]];
}


#pragma mark - Actions
- (void)recordAction:(id)sender {
    VRReCordViewController *recordViewController = [[VRReCordViewController alloc] init];
    [self.navigationController pushViewController:recordViewController animated:YES];
}

- (void)remindersAction:(id)sender {
    VRRemindersViewController *remindersViewController = [[VRRemindersViewController alloc] init];
    [self.navigationController pushViewController:remindersViewController animated:YES];
}

- (void)alarmAction:(UIButton *)sender {
    VRReminderSettingViewController *vc = [[VRReminderSettingViewController alloc] initWithNibName:NSStringFromClass([VRReminderSettingViewController class]) bundle:nil];
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - ticker
- (void)numberTick:(id)sender {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HHmmss"];
    NSString *newClock = [formatter stringFromDate:[NSDate date]];
    
    [_clockTickers enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        if (![[_currentClock substringWithRange:NSMakeRange(idx, 1)] isEqualToString:[newClock substringWithRange:NSMakeRange(idx, 1)]]) {
            [obj setBackView:[SBTickView tickViewWithTitle:[newClock substringWithRange:NSMakeRange(idx, 1)] fontSize:30.]];
            [obj tick:SBTickerViewTickDirectionDown animated:YES completion:nil];
        }
    }];
    
    _currentClock = newClock;
}

#pragma mark - save shortsound to database
- (void)saveShortSoundModelToDB {
    NSMutableArray *listShortSoundModel = [NSMutableArray new];
    for (NSString *string in [VREnumDefine listShortSound]) {
        VRSoundModel *model = [VRSoundModel new];
        model.isShortSound  = YES;
        model.name = string;
        [listShortSoundModel addObject:model];
    }
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        for (VRSoundModel *model in listShortSoundModel) {
            [VRSoundMapping entityFromModel:model andReminderName:nil inContext:localContext];
        }
    } completion:^(BOOL success, NSError *error) {
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:kSaveShortSoundToDBLocal];
        [[NSUserDefaults standardUserDefaults] synchronize];
    }];
    
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
