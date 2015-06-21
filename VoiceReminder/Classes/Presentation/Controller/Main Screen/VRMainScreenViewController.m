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
#import "VRShortSoundMapping.h"
#import "VRShortSoundModel.h"
#import "VRLunarHelper.h"
#import "NSString+VR.h"
#import "VRHoroscopeController.h"

@interface VRMainScreenViewController () <UIGestureRecognizerDelegate>
@property (nonatomic, strong) VRLunarHelper *service;
@end

@implementation VRMainScreenViewController
{
    NSString *_currentClock;
    NSArray *_clockTickers;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.prepare data
    [self prepareData];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureUI];
    [self configureClockTicker];
    
    NSArray *listObject = [ShortSound MR_findAll];
    if (!listObject.count) {
        [self saveShortSoundModelToDB];
    }
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
}

#pragma mark prepare date
- (void)prepareData {
    if (!_service) {
        _service = [[VRLunarHelper alloc] init];
    }
    
    //1. list image background
    self.listImageBackground = [NSMutableArray arrayWithArray:[VREnumDefine listBackgroundImages]];
}

#pragma mark - ConfigureUI

- (void)configureUI {
    // tick view
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(numberTick:) userInfo:nil repeats:YES];
    
    [self.backGroundImageView setImage:[self getRandomBackgroundImage]];
    
    [self setupMidleView];
    [self setupBottomView];
}

- (void)setupMidleView {
    // middle view
    self.buttonZodiac.layer.cornerRadius = 14;
    self.buttonZodiac.layer.borderWidth = 2.0f;
    self.buttonZodiac.layer.borderColor = [UIColor redColor].CGColor;
    self.buttonZodiac.backgroundColor = [UIColor clearColor];
    [self.buttonZodiac setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.buttonZodiac.titleLabel.font = VRFontRegular(17);
    [self.buttonHoroscope addTarget:self action:@selector(horoscopeDetail) forControlEvents:UIControlEventTouchUpInside];
    
    self.labelGregorianDate.font = VRFontRegular(20);
    self.labelGregorianDate.textColor = [UIColor whiteColor];
    
    self.labelGregorianDay.font = VRFontBold(50);
    self.labelGregorianDay.textColor = [UIColor whiteColor];
    self.labelGregorianWeek.font = VRFontRegular(20);
    self.labelGregorianWeek.textColor = [UIColor whiteColor];
    
    self.labelIdiom.font = VRFontRegular(17);
    self.labelIdiom.textColor = [UIColor whiteColor];
    
    [self updateDataFromMidleView];
}

- (void)updateDataFromMidleView {
    // month year
    self.labelGregorianDate.text = [_service getMonthYearStringFromDate:self.displayDate];
    // day
    self.labelGregorianDay.text = [NSString stringWithFormat:@"%d", [_service getDayFromDate:self.displayDate]];
    // day of week
    int thu = [_service getDayOfWeekFromDate:self.displayDate];
    if (thu == 1) {
        self.labelGregorianWeek.text = [NSString stringWithFormat:@"%@", @"Chủ nhật"];
    }
    else {
        self.labelGregorianWeek.text = [NSString stringWithFormat:@"Thứ %d", [_service getDayOfWeekFromDate:self.displayDate]];
        
    }
       
    [self.buttonZodiac setTitle:[_service getCungHoangDao:self.displayDate] forState:UIControlStateNormal];
    self.labelIdiom.text = [self getIDomsRadom];
}

- (void)setupBottomView {
    // button view
    [self configButton:self.recordButton WithTittle:[@"Record" uppercaseString]];
    [self.recordButton addTarget:self action:@selector(recordAction:) forControlEvents:UIControlEventTouchUpInside];
    
    [self configButton:self.remindersButton WithTittle:[@"Reminder" uppercaseString]];
    [self.remindersButton addTarget:self action:@selector(remindersAction:) forControlEvents:UIControlEventTouchUpInside];
    [self configButton:self.buttonAlarm WithTittle:[@"alarm" uppercaseString]];
    [self.buttonAlarm addTarget:self action:@selector(alarmAction:) forControlEvents:UIControlEventTouchUpInside];
    NSArray *views = @[self.recordButton, self.buttonAlarm, self.remindersButton];
    [views autoDistributeViewsAlongAxis:ALAxisHorizontal alignedTo:ALAttributeHorizontal withFixedSpacing:0.0 insetSpacing:YES matchedSizes:YES];
}

- (void)configButton:(UIButton *)button WithTittle:(NSString *)title {
    [button setTitle:title forState:UIControlStateNormal];
    button.titleLabel.font = VRFontRegular(17);
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)horoscopeDetail {
    NSArray* subString = [[_service getCungHoangDao:self.displayDate] componentsSeparatedByString: @"("];
    VRHoroscopeController *vc = [[VRHoroscopeController alloc] init];
    vc.horoscope = [_service horoscopeEngFromVi:[[subString objectAtIndex: 0] removeWhitespace]];
    [self.navigationController pushViewController:vc animated:YES];
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

- (UIImage *)getRandomBackgroundImage {
    UIImage *image = [UIImage imageNamed:[self.listImageBackground objectAtIndex:(arc4random() % self.listImageBackground.count)]];
    return image;
}

- (NSString *)getIDomsRadom {
    NSString *idomString = nil;
    NSDictionary *dict = [_service.listIdoms objectAtIndex:(arc4random() % self.listImageBackground.count)];
    idomString = [dict objectForKey:@"content"];
    return idomString;
}

#pragma mark - Actions
- (void)recordAction:(id)sender {
    VRReCordViewController *recordViewController = [[VRReCordViewController alloc] init];
    recordViewController.isComeFromMainScreen = YES;
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
        VRShortSoundModel *model = [VRShortSoundModel new];
        model.name = string;
        [listShortSoundModel addObject:model];
    }
    
    [MagicalRecord saveWithBlock:^(NSManagedObjectContext *localContext) {
        for (VRShortSoundModel *model in listShortSoundModel) {
            [VRShortSoundMapping entityFromModel:model inContext:localContext];
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
