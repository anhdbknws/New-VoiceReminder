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
#import "VRMacro.h"
#import "VRLocalization.h"
#import "VRLocalizationCenter.h"

@interface VRReminderSettingViewController ()<UITableViewDataSource, UITableViewDelegate, IQDropDownTextFieldDelegate, UITextFieldDelegate>

@end

@implementation VRReminderSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureUI];
    [self configureTableview];
    [self addTapgestureForDismissKeyboard];
}

#pragma mark - Configure UI
- (void)configureUI {
    self.title = @"Reminder Setting " ;
    self.navigationController.navigationBar.translucent = NO;
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancelAction:)];
    
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    UIBarButtonItem *saveButton = [[UIBarButtonItem alloc] initWithTitle:@"Save" style:UIBarButtonItemStylePlain target:self action:@selector(saveAction:)];
    self.navigationItem.rightBarButtonItem = saveButton;
    
    
    [self.playButton setTitle:@"Play" forState:UIControlStateNormal];
    [self.playButton setBackgroundColor:[UIColor blueColor]];
    [self.playButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.playButton.layer.cornerRadius  = 8;
    self.playButton.layer.borderColor   = [UIColor blueColor].CGColor;
    self.playButton.layer.borderWidth   = 1.0f;
    
    CGAffineTransform transform         = CGAffineTransformMakeScale(1.0f, 5.0f);
    _progressView.transform             = transform;
    _progressView.progressTintColor     = [UIColor blueColor];
    
    self.nameTextfield.delegate = self;
}

- (void)configureTableview {
    self.settingTableview.scrollEnabled = NO;
    self.settingTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.settingTableview.backgroundColor = [UIColor whiteColor];
    
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

#pragma mark - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.settingTableview) {
        return 4;
    }
    else
        return 0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.settingTableview) {
        return 1;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == REMINDER_SETTING_TYPE_REMINDER_TIME) {
        return [self getReminderTimeCellAtIndexPath:indexPath];
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

- (VRReminderSettingCell *)getReminderTimeCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
  
    cell.titleLabel.text = @"Reminder time:";
    cell.textfield.font = H1_FONT;
    __weak typeof (self)weak = self;
    cell.pressDoneAction = ^(id sender) {
        __strong typeof (weak)strong = weak;
        [strong doneClicked:sender];
    };
    [cell.textfield setDropDownMode:IQDropDownModeDatePicker];
    return cell;
}

- (VRReminderSettingCell *)getRepeatCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    
    cell.titleLabel.text = @"Repeat:";
    cell.textfield.font = H1_FONT;
    cell.textfield.isOptionalDropDown = NO;
    
    __weak typeof (self)weak = self;
    cell.pressDoneAction = ^(id sender) {
        __strong typeof (weak)strong = weak;
        [strong doneClicked:sender];
    };
    
    [cell.textfield setItemList:[VREnumDefine listRepeatType]];
    
    return cell;
}

- (VRReminderSettingCell *)getAlertCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    
    cell.titleLabel.text = @"Alert:";
    cell.textfield.font = H1_FONT;
    cell.textfield.isOptionalDropDown = NO;
    
    __weak typeof (self)weak = self;
    cell.pressDoneAction = ^(id sender) {
        __strong typeof (weak)strong = weak;
        [strong doneClicked:sender];
    };
    [cell.textfield setItemList:[VREnumDefine listAlertType]];
    
    return cell;
}

- (VRReminderSettingCell *)getsoundCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    
    cell.titleLabel.text = @"Sound:";
    cell.textfield.font = H1_FONT;
    cell.textfield.isOptionalDropDown = NO;
    __weak typeof (self)weak = self;
    cell.pressDoneAction = ^(id sender) {
        __strong typeof (weak)strong = weak;
        [strong doneClicked:sender];
    };
    [cell.textfield setItemList:[NSArray arrayWithObjects:@"London",@"Johannesburg",@"Moscow",@"Mumbai",@"Tokyo",@"Sydney", nil]];
    
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

- (void)implementActionAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case REMINDER_SETTING_TYPE_REMINDER_TIME:
            break;
        case REMINDER_SETTING_TYPE_REPEAT:
            break;
        case REMINDER_SETTING_TYPE_ALERT:
            break;
        case REMINDER_SETTING_TYPE_SOUND:
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

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma  mark - dismiss keyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    return YES;
}

-(void)dismissKeyboard {
    [self.nameTextfield resignFirstResponder];
}

@end
