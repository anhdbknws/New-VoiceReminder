//
//  VRReminderSettingViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/11/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderSettingViewController.h"
#import "VRReminderSettingCell.h"
#import "VREnumDefine.h"
#import "VRCommon.h"
#import "IQDropDownTextField.h"
#import "VRLocalizeKey.h"
#import "VRLocalizationCenter.h"
#import "VRReminderModel.h"
#import "VRReminderSettingService.h"
#import "VRMainScreenViewController.h"
#import "VRNameViewController.h"
#import "VRRepeatViewController.h"
#import "VRAlertViewController.h"

static NSString * const kImageArrow = @"icon_arrow_right";

@interface VRReminderSettingViewController ()<UITableViewDataSource, UITableViewDelegate, IQDropDownTextFieldDelegate, UITextFieldDelegate, AVAudioPlayerDelegate>
@property (nonatomic, strong)AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) VRReminderModel *model;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) VRReminderSettingService *service;
@property (nonatomic, strong) NSMutableArray *listRepeat;
@end

@implementation VRReminderSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureUI];
    [self configureDatePicker];
    [self configureTableview];
    [self addTapgestureForDismissKeyboard];
    
    if (!self.model) {
        self.model = [[VRReminderModel alloc] init];
    }
    
    if (!self.service) {
        self.service = [[VRReminderSettingService alloc] init];
    }
    
    [self prepareData];
}

#pragma mark - Configure UI
- (void)configureUI {
    self.title = @"Reminder Setting " ;
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor redColor],NSForegroundColorAttributeName,
                                    [UIColor redColor],NSBackgroundColorAttributeName,nil];
    [cancelButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    [saveButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];

}

- (void)configureDatePicker {
    self.datePicker.minimumDate = [NSDate date];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
}

- (void)configureTableview {
    self.settingTableview.backgroundColor = [UIColor whiteColor];
    self.settingTableview.scrollEnabled = NO;
    self.settingTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.settingTableview.dataSource = self;
    self.settingTableview.delegate   = self;
    
    [self.settingTableview registerNib:[UINib nibWithNibName:NSStringFromClass([VRReminderSettingCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([VRReminderSettingCell class])];
}


- (void)addTapgestureForDismissKeyboard {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)prepareData{
    self.model.name = @"Name";
    self.listRepeat = [NSMutableArray new];
    self.model.alertReminder = ALERT_TYPE_AT_EVENT_TIME;
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return REMINDER_SETTING_TYPE_SOUND + 1;
    }
    else
        return 1;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.settingTableview) {
        return 1;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return [self getsoundCellAtIndexPath:indexPath];
    }
    else {
        if (indexPath.row == REMINDER_SETTING_TYPE_NAME) {
            return [self getNameCellAtIndexPath:indexPath];
        }
        else if (indexPath.row == REMINDER_SETTING_TYPE_REPEAT) {
            return [self getRepeatCellAtIndexPath:indexPath];
        }
        else if (indexPath.row == REMINDER_SETTING_TYPE_ALERT) {
            return [self getAlertCellAtIndexPath:indexPath];
        }
        else {
            return [self getsoundCellAtIndexPath:indexPath];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (VRReminderSettingCell *)getNameCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = @"Name";
    cell.textfield.font = H1_FONT;
    cell.textfield.tag = REMINDER_SETTING_TYPE_NAME;
    cell.textfield.delegate = self;
    [cell.arrowView setImage:[UIImage imageNamed:kImageArrow]];
    cell.textfield.text = self.model.name;
    return cell;
}

- (VRReminderSettingCell *)getRepeatCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = @"Repeat";
    cell.textfield.font = H1_FONT;
    cell.textfield.tag = REMINDER_SETTING_TYPE_REPEAT;
    cell.textfield.delegate = self;
    cell.textfield.text = [self getRepeatString];
    
    [cell.arrowView setImage:[UIImage imageNamed:@"icon_arrow_right"]];
    return cell;
}

- (VRReminderSettingCell *)getAlertCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    
    cell.titleLabel.text = @"Alert";
    cell.textfield.font = H1_FONT;
    cell.textfield.tag = REMINDER_SETTING_TYPE_ALERT;
    cell.textfield.delegate = self;
    cell.textfield.text = [VREnumDefine alertTypeStringFrom:self.model.alertReminder];
    [cell.arrowView setImage:[UIImage imageNamed:kImageArrow]];
    
    return cell;
}

- (VRReminderSettingCell *)getsoundCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = @"Sound";
    cell.textfield.font = H1_FONT;
    cell.textfield.tag = REMINDER_SETTING_TYPE_SOUND;
    cell.textfield.delegate = self;
    cell.textfield.text = @"Default";
    
    [cell.arrowView setImage:[UIImage imageNamed:kImageArrow]];
    
    return cell;
}

- (void)doneClicked:(id)sender {
    [self.view endEditing:YES];
}
#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.settingTableview) {
        return 44;
    }
    else
        return 0;
}

#pragma mark - store data to model
- (void)storeDataToModel:(UITextField *)textField {
    switch (textField.tag) {
        case REMINDER_SETTING_TYPE_REPEAT:
            _model.repeatReminder = [VREnumDefine repeatTypeIntegerFromString:textField.text];
            break;
        case REMINDER_SETTING_TYPE_ALERT:
            _model.alertReminder = [VREnumDefine alertTypeIntegerFromString:textField.text];
            break;
        case REMINDER_SETTING_TYPE_SOUND:
            _model.nameOfSound = textField.text;
            break;
        case REMINDER_SETTING_TYPE_NAME:
            _model.name = textField.text;
            break;
        default:
            break;
    }
}

#pragma mark - Actions
- (void)cancelAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)saveAction:(id)sender {
    [self.view endEditing:YES];
    if (self.isLoading) {
        return;
    }
    
    NSString *errorMessage = nil;
    BOOL validate = [_service validateModel:_model errorMessage:&errorMessage];
    if (validate) {
        _isLoading = YES;
        __weak typeof (self)weak = self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_service addReminder:_model toDatabaseLocalWithCompletionhandler:^(NSError *error, VRReminderModel *result) {
            __strong typeof (weak)strong = weak;
            if (!strong) {
                return ;
            }
            [MBProgressHUD hideAllHUDsForView:strong.view animated:YES];
            if (!error) {
                NSLog(@"%@", result.name);
            }
            
            for (UIViewController *Vc in strong.navigationController.viewControllers) {
                if ([Vc isKindOfClass:[VRMainScreenViewController class]]) {
                    [strong.navigationController popToViewController:Vc animated:YES];
                }
            }
        }];
    }
    else {
        
    }
}

- (void)playAction:(id)sender {
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:self.audioRecordingURL error:nil];
    /* Did we get an instance of AVAudioPlayer? */
    if (self.audioPlayer != nil){
        /* Set the delegate and start playing */
        self.audioPlayer.delegate = self;
        if ([self.audioPlayer prepareToPlay] &&
            [self.audioPlayer play]){
            /* Successfully started playing */
        }
        else {
            NSLog(@"failed to play");
        }
    }
    else {
        NSLog(@"failed to instantiate avaudioplayer");
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma  mark - dismiss keyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    [self storeDataToModel:textField];
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == REMINDER_SETTING_TYPE_NAME) {
        [self setName];
        return NO;
    }
    else if (textField.tag == REMINDER_SETTING_TYPE_REPEAT) {
        [self setRepeatValue];
        return NO;
    }
    else if (textField.tag== REMINDER_SETTING_TYPE_ALERT) {
        [self setAlertValue];
        return NO;
    }
    
    return YES;
}

#pragma mark - set value setting
- (void)setName {
    VRNameViewController *Vc = [[VRNameViewController alloc] initWithNibName:NSStringFromClass([VRNameViewController class]) bundle:nil];
    
    __weak typeof (self)weak = self;
    Vc.doneNameCompleted = ^(NSString *name) {
        __strong typeof (weak)strong = weak;
        strong.model.name = name;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [strong.settingTableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        });
    };
    
    [self.navigationController pushViewController:Vc animated:YES];
}

- (void)setRepeatValue {
    VRRepeatViewController *VC = [[VRRepeatViewController alloc] initWithNibName:NSStringFromClass([VRRepeatViewController class]) bundle:nil];
    VC.arrayRepeatSelected = [NSMutableArray new];
    VC.arrayRepeatSelected = self.listRepeat;
    __weak typeof (self)weak = self;
    VC.selectedCompleted = ^(NSMutableArray *listRepeatSelected) {
        __strong typeof (weak)strong = weak;
        
        strong.listRepeat = listRepeatSelected;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [strong.settingTableview reloadData];
        });
    };
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)setAlertValue {
    VRAlertViewController *VC = [[VRAlertViewController alloc] initWithNibName:NSStringFromClass([VRAlertViewController class]) bundle:nil];
    VC.alertSelected = [VREnumDefine alertTypeStringFrom:self.model.alertReminder];
    
    __weak typeof (self)weak = self;
    VC.selectedAlertCompleted = ^(NSString *alert) {
        __strong typeof (weak)strong = weak;
        strong.model.alertReminder = [VREnumDefine alertTypeIntegerFromString:alert];
        dispatch_async(dispatch_get_main_queue(), ^{
            [strong.settingTableview reloadData];
        });
    };
    
    [self.navigationController pushViewController:VC animated:YES];
}


#pragma mark - dissmiss keyboard
-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - helper
- (NSString *)getRepeatString {
    NSString *fullString = nil;
    if (self.listRepeat.count == 7) {
        fullString = @"Every day";
    }
    else if (!self.listRepeat.count) {
        fullString = @"Never";
    }
    else if (self.listRepeat.count == 1) {
        fullString = [self.listRepeat objectAtIndex:0];
    }
    else {
        NSMutableArray *temp = [NSMutableArray new];
        NSMutableArray *tempRepeat = [self sortOrderDayInWeekly];
        for (NSString *item in tempRepeat) {
            if ([item isEqualToString:@"Every Monday"]) {
               [temp addObject:@"Mon"];
            }
            else if ([item isEqualToString:@"Every Tuesday"]) {
                [temp addObject:@"Tue"];
            }
            else if ([item isEqualToString:@"Every Wednesday"]) {
                [temp addObject:@"Wed"];
            }
            else if ([item isEqualToString:@"Every Thursday"]) {
                [temp addObject:@"Thu"];
            }
            else if ([item isEqualToString:@"Every Friday"]) {
                [temp addObject:@"Fri"];
            }
            else if ([item isEqualToString:@"Every Saturday"]) {
                [temp addObject:@"Sat"];
            }
            else {
                [temp addObject:@"Sun"];
            }
        }
        
        fullString = [temp componentsJoinedByString:@" "];
    }
    
    return fullString;
}

- (NSMutableArray *)sortOrderDayInWeekly {
    NSMutableArray *temp = [NSMutableArray new];
    for (NSString *item in self.listRepeat) {
        if ([item isEqualToString:@"Every Monday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in self.listRepeat) {
        if ([item isEqualToString:@"Every Tuesday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in self.listRepeat) {
        if ([item isEqualToString:@"Every Wednesday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in self.listRepeat) {
        if ([item isEqualToString:@"Every Thursday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in self.listRepeat) {
        if ([item isEqualToString:@"Every Friday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in self.listRepeat) {
        if ([item isEqualToString:@"Every Saturday"]) {
            [temp addObject:item];
        }
    }
    
    for (NSString *item in self.listRepeat) {
        if ([item isEqualToString:@"Every Sunday"]) {
            [temp addObject:item];
        }
    }
    
    return temp;
}

#pragma mark -photos

@end
