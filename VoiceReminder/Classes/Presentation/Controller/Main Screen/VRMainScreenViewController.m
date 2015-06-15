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
    NSDate *currentDate; // is date displaying
}
- (void)viewDidLoad {
    [super viewDidLoad];
    //1.prepare data
    [self prepareData];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureUI];
    [self configureClockTicker];
    [self setupGesture];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:kSaveShortSoundToDBLocal]) {
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
    //1.get current date
    currentDate = [NSDate date];
    //1. list image background
    self.listImageBackground = [NSMutableArray arrayWithArray:[VREnumDefine listBackgroundImages]];
}

#pragma mark - ConfigureUI

- (void)configureUI {
    // tick view
    [NSTimer scheduledTimerWithTimeInterval:.1 target:self selector:@selector(numberTick:) userInfo:nil repeats:YES];
    
    [self.backGroundImageView setImage:[self getRandomBackgroundImage]];
    
    [self setupMidleView];
    [self setupNearBottomView];
    [self setupBottomView];
}

- (void)setupMidleView {
    // middle view
    self.buttonZodiac.layer.cornerRadius = 14;
    self.buttonZodiac.layer.borderWidth = 2.0f;
    self.buttonZodiac.layer.borderColor = [UIColor redColor].CGColor;
    self.buttonZodiac.backgroundColor = [UIColor clearColor];
    [self.buttonZodiac setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [self.buttonHoroscope addTarget:self action:@selector(horoscopeDetail) forControlEvents:UIControlEventTouchUpInside];
    
    [self updateDataFromMidleView];
}

- (void)updateDataFromMidleView {
    // month year
    self.labelGregorianDate.text = [_service getMonthYearStringFromDate:currentDate];
    // day
    self.labelGregorianDay.text = [NSString stringWithFormat:@"%d", [_service getDayFromDate:currentDate]];
    // day of week
    self.labelGregorianWeek.text = [NSString stringWithFormat:@"Thứ %d", [_service getDayOfWeekFromDate:currentDate]];
    
    [self.buttonZodiac setTitle:[_service getCungHoangDao:currentDate] forState:UIControlStateNormal];
    self.labelIdiom.text = [self getIDomsRadom];
}

- (void)setupNearBottomView {
    self.viewLunar.backgroundColor = [UIColor colorWithWhite:1 alpha:0.7];
    self.webview.opaque = NO;
    self.webview.backgroundColor = [UIColor clearColor];
    NSString *indexPath = [[NSBundle mainBundle] pathForResource:@"www/index" ofType:@"html" inDirectory:nil];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
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
    [button setBackgroundColor:[UIColor redColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

- (void)horoscopeDetail {
    NSArray* subString = [[_service getCungHoangDao:currentDate] componentsSeparatedByString: @"("];
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

#pragma mark - gesture
- (void)setupGesture{
    // Swipe Left detect
    UISwipeGestureRecognizer *swipeLeftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detectSwiped:)];
    swipeLeftRecognizer.direction = UISwipeGestureRecognizerDirectionLeft;
    [self.viewOverlay addGestureRecognizer:swipeLeftRecognizer];
    [swipeLeftRecognizer setDelegate:self];
    
    // Swipe Right detect
    UISwipeGestureRecognizer *swipeRightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(detectSwiped:)];
    swipeRightRecognizer.direction = UISwipeGestureRecognizerDirectionRight;
    [self.viewOverlay addGestureRecognizer:swipeRightRecognizer];
    [swipeRightRecognizer setDelegate:self];
}

- (void)detectSwiped:(UISwipeGestureRecognizer *)gesture {
    if (gesture.direction == UISwipeGestureRecognizerDirectionRight) {
        NSLog(@"swipe right");
        //1.setback ground
        [self.backGroundImageView setImage:[self getRandomBackgroundImage]];
        //2.update lunarview
        [self.webview stringByEvaluatingJavaScriptFromString:@"_flipRight()"];
        //3.previuous date
        currentDate = [VRCommon minusOneDayFromDate:currentDate];
        [self updateDataFromMidleView];
        
    }
    else if (gesture.direction == UISwipeGestureRecognizerDirectionLeft){
        NSLog(@"swipe left");
        //1. set backgroun
        [self.backGroundImageView setImage:[self getRandomBackgroundImage]];
        //2.update lunarview
        [self.webview stringByEvaluatingJavaScriptFromString:@"_flipLeft()"];
        //3.next date
        currentDate =[VRCommon addOneDayToDate:currentDate];
        [self updateDataFromMidleView];
    }
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
