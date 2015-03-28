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

@interface VRMainScreenViewController ()

@end

@implementation VRMainScreenViewController
{
    NSString *_currentClock;
    NSArray *_clockTickers;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureUI];
    [self configureClockTicker];
}

#pragma mark - ConfigureUI

- (void)configureUI {
    self.view.backgroundColor = [UIColor whiteColor];
    NSLog(@"%@", VRLocalizationString(klocalizeKeyRecord));
    [self.recordButton setTitle:[VRLocalizationString(klocalizeKeyRecord) uppercaseString] forState:UIControlStateNormal];
    [self.recordButton setBackgroundColor:[UIColor blueColor]];
    [self.recordButton addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
    self.recordButton.layer.cornerRadius = 8;
    self.recordButton.layer.borderColor = [UIColor blueColor].CGColor;
    self.recordButton.layer.borderWidth = 1.0f;
    [self.recordButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    
    [self.remindersButton setTitle:@"REMINDERS" forState:UIControlStateNormal];
    [self.remindersButton setBackgroundColor:[UIColor blueColor]];
    [self.remindersButton addTarget:self action:@selector(remindersAction:) forControlEvents:UIControlEventTouchUpInside];
    self.remindersButton.layer.cornerRadius = 8;
    self.remindersButton.layer.borderWidth = 1.0f;
    self.remindersButton.layer.borderColor = [UIColor blueColor].CGColor;
    [self.remindersButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(numberTick:) userInfo:nil repeats:YES];
    
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

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
