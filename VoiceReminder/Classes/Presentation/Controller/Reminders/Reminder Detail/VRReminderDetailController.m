//
//  ViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 4/7/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReminderDetailController.h"
#import "VRReminderSettingCell.h"
#import "VRSoundModel.h"
#import "VRRepeatModel.h"
#import "VRPhotoListCell.h"
#import "VRPhotoPageController.h"
#import "VRReminderSettingViewController.h"
#import "VRSettingNotesCell.h"

@interface VRReminderDetailController () <AVAudioPlayerDelegate, UITextFieldDelegate, UITextViewDelegate>
@property (nonatomic, strong) UIPlaceHolderTextView * noteTextView;
@end

@implementation VRReminderDetailController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Reminder detail";
        self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self leftNavigationItem:nil andTitle:@"Back" orImage:nil];
    [self rightNavigationItem:@selector(editAction:) andTitle:nil orImage:[UIImage imageNamed:@"icon_edit_blue"]];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    self.isPlaying = NO;
}

- (void)setupTableView {
    self.tableViewDetail.delegate = self;
    self.tableViewDetail.dataSource = self;
    self.tableViewDetail.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    self.tableViewDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableViewDetail registerNib:[UINib nibWithNibName:NSStringFromClass([VRReminderSettingCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([VRReminderSettingCell class])];
    [self.tableViewDetail registerClass:[VRPhotoListCell class] forCellReuseIdentifier:NSStringFromClass([VRPhotoListCell class])];
    
    [self.tableViewDetail registerClass:[VRSettingNotesCell class] forCellReuseIdentifier:NSStringFromClass([VRSettingNotesCell class])];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return REMINDER_DETAIL_ROW_TYPE_NOTES + 1;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == REMINDER_DETAIL_ROW_TYPE_NOTES) {
            return [self getNotesCell];
        }
        return [self getSettingInforAtIndexPath:indexPath];
    }
    else {
        return [self getPhotoCell];
    }
}

- (VRReminderSettingCell *)getSettingInforAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.tableViewDetail dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.titleLabel.text = [self titleAtIndexPath:indexPath];
    cell.textfield.text = [self valueAtIndexPath:indexPath];
    cell.textfield.tag = indexPath.row;
    cell.textfield.delegate = self;
    [cell.arrowView setImage:[UIImage imageNamed:@"icon_arrow_right"]];
    return cell;
}

- (VRSettingNotesCell *)getNotesCell {
    VRSettingNotesCell *cell = [self.tableViewDetail dequeueReusableCellWithIdentifier:NSStringFromClass([VRSettingNotesCell class])];
    cell.labelTitle.text = @"Notes:";
    cell.arrowView.image = [UIImage imageNamed:@"icon_arrow_right"];
    cell.textViewNotes.delegate = self;
    _noteTextView = (UIPlaceHolderTextView*)cell.textViewNotes;
    cell.textViewNotes.tag = REMINDER_SETTING_TYPE_NOTES;
    cell.textViewNotes.text = self.model.notes;
    cell.textViewNotes.font = VRFontRegular(17);
    return cell;
}

- (VRPhotoListCell *)getPhotoCell {
    VRPhotoListCell * cell = [self.tableViewDetail dequeueReusableCellWithIdentifier:NSStringFromClass([VRPhotoListCell class])];
    cell.photoList = _model.photoList;
    __weak typeof(self)weak = self;
    cell.didSelectImage = ^(NSInteger index) {
        [weak showPhotoPageControllerAtIndex:index];
    };
    
    return cell;
}

- (void)showPhotoPageControllerAtIndex:(NSInteger)index
{
    VRPhotoPageController * photoPageController = [[VRPhotoPageController alloc] initWithPhotos:_model.photoList];
    [photoPageController setPageIndex:index];
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:photoPageController];
    [self.navigationController presentViewController:navController animated:YES completion:NULL];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        if (indexPath.row == REMINDER_DETAIL_ROW_TYPE_NOTES) {
            return MAX(44, [self caculateHeightOfTextView]);
            return 44;
        }
        return 44;
    }
    else {
        if (_model.photoList.count) {
            return 115;
        }
        else {
            return 0;
        }
    }
}

- (CGFloat)caculateHeightOfTextView {
    UIPlaceHolderTextView *calculationView = _noteTextView;
    if (!calculationView) {
        calculationView = [[UIPlaceHolderTextView alloc] init];
        calculationView.font = H6_FONT;
        calculationView.contentInset = UIEdgeInsetsMake(1, -2, 0, 0);
        calculationView.textContainer.maximumNumberOfLines = 0;
        calculationView.text = self.model.notes;
        CGRect frame = calculationView.frame;
        frame.size.width = self.tableViewDetail.bounds.size.width - 42 - 10;
        calculationView.frame = frame;
    }
    CGFloat textViewWidth = calculationView.frame.size.width;
    CGSize size = [calculationView sizeThatFits:CGSizeMake(textViewWidth, FLT_MAX)];
    return size.height + 10;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    if (section == 1) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(view.frame.origin.x + 15, 5, 60, 34)];
        label.text = @"Photos";
        label.textColor = [UIColor redColor];
        
        [view addSubview:label];
    }

    return view;
}


#pragma mark - cell helper
- (NSString *)titleAtIndexPath:(NSIndexPath *)indexPath {
    NSString *titleString = nil;
    switch (indexPath.row) {
        case REMINDER_DETAIL_ROW_TYPE_TIME:
            titleString = @"Time";
            break;
        case REMINDER_DETAIL_ROW_TYPE_NAME:
            titleString = @"Name";
            break;
        case REMINDER_DETAIL_ROW_TYPE_REPEAT:
            titleString = @"Repeat";
            break;
        case REMINDER_DETAIL_ROW_TYPE_ALERT:
            titleString = @"Alert";
            break;
        case REMINDER_DETAIL_ROW_TYPE_MUSIC_SOUND:
            titleString = @"Music/sound";
            break;
        case REMINDER_DETAIL_ROW_TYPE_SHORT_SOUND:
            titleString = @"Short sound";
            break;
        case REMINDER_DETAIL_ROW_TYPE_PHOTO:
            titleString = @"Photo";
            break;
        default:
            break;
    }
    
    return titleString;
}

- (NSString *)valueAtIndexPath:(NSIndexPath *)indexPath {
    NSString *valueString = nil;
    switch (indexPath.row) {
        case REMINDER_DETAIL_ROW_TYPE_TIME:
            valueString = _model.timeReminder;
            break;
        case REMINDER_DETAIL_ROW_TYPE_NAME:
            valueString = _model.name;
            break;
        case REMINDER_DETAIL_ROW_TYPE_REPEAT:
        {
            VRRepeatModel *model = _model.repeats.firstObject;
            valueString = [VREnumDefine repeatTypeStringFrom:model.repeatType];
        }
            break;
        case REMINDER_DETAIL_ROW_TYPE_ALERT:
            valueString = [VREnumDefine alertTypeStringFrom:_model.alertReminder];
            break;
        case REMINDER_DETAIL_ROW_TYPE_MUSIC_SOUND:
        {
            VRSoundModel *model = self.model.soundModel;
            valueString = model.name;
        }
            break;
        case REMINDER_DETAIL_ROW_TYPE_SHORT_SOUND:
        {
            VRShortSoundModel *model = self.model.shortSoundModel;
            valueString = model.name;
        }
            break;
        case REMINDER_DETAIL_ROW_TYPE_PHOTO:
            valueString = nil;
            break;
        default:
            break;
    }
    
    return valueString;
}

#pragma mark - Actions
- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    return NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.audioPlayer = nil;
    self.isPlaying = NO;
}

#pragma mark - Actions
- (void) editAction:(id)sender {
    VRReminderSettingViewController *vc = [[VRReminderSettingViewController alloc] initWithUUID:self.model.uuid];
    vc.isEditMode = YES;
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
