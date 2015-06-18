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
#import "VRSoundViewController.h"
#import "VRPhotoListCell.h"
#import <AssetsLibrary/AssetsLibrary.h>
#import "CTAssetsPickerController.h"
#import "VCAppearanceConfig.h"
#import "VCUtilities.h"
#import "CTAssetItemViewController.h"
#import "VCAssetAccessory.h"
#import "VRPhotoPageController.h"
#import "VRSoundModel.h"
#import "VRRepeatModel.h"
#import "VRSettingNotesCell.h"
#import "NSString+VR.h"
#import "VRNotesController.h"
#import "VRShortSoundController.h"
#import "Sound.h"
#import "VRShortSoundModel.h"

static NSString * const kImageArrow = @"icon_arrow_right";
const NSInteger kPhotoActionSheetTag = 3249;

@interface VRReminderSettingViewController ()<UITableViewDataSource, UITableViewDelegate, IQDropDownTextFieldDelegate, UITextFieldDelegate, AVAudioPlayerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, CTAssetsPickerControllerDelegate, UITextViewDelegate>

@property (nonatomic, strong)AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) BOOL isLoading;
@property (nonatomic, strong) VRReminderSettingService *service;
@end

@implementation VRReminderSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    [self configureUI];
    [self configureDatePicker];
    [self configureTableview];
    [self addTapgestureForDismissKeyboard];
    [self prepareData];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

#pragma mark - Configure UI
- (void)configureUI {
    if (self.isEditMode) {
        self.title = @"New Alarm";
    }
    else {
        self.title = @"Edit Alarm" ;
    }
    
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationController.navigationBar.translucent = NO;
    [self leftNavigationItem:nil andTitle:@"Cancel" orImage:nil];
    [self rightNavigationItem:@selector(saveAction:) andTitle:@"Save" orImage:nil];
}

- (void)configureDatePicker {
    self.datePicker.minimumDate = [NSDate date];
    self.datePicker.backgroundColor = [UIColor whiteColor];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self.datePicker addTarget:self action:@selector(datePickerDateChanged:) forControlEvents:UIControlEventValueChanged];
}

- (void)configureTableview {
    self.settingTableview.backgroundColor = [UIColor whiteColor];
    self.settingTableview.scrollEnabled = YES
    ;
    self.settingTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.settingTableview.dataSource = self;
    self.settingTableview.delegate   = self;
    
    [self.settingTableview registerNib:[UINib nibWithNibName:NSStringFromClass([VRReminderSettingCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([VRReminderSettingCell class])];
    [self.settingTableview registerClass:[VRPhotoListCell class] forCellReuseIdentifier:NSStringFromClass([VRPhotoListCell class])];
    [self.settingTableview registerNib:[UINib nibWithNibName:NSStringFromClass([VRSettingNotesCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([VRSettingNotesCell class])];
}


- (void)addTapgestureForDismissKeyboard {
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]
                                   initWithTarget:self
                                   action:@selector(dismissKeyboard)];
    
    [self.view addGestureRecognizer:tap];
}

- (void)prepareData{
    if (!_service) {
        _service = [[VRReminderSettingService alloc] init];
    }
    
    [_service performFetchReminderWith:_uuid];
    
    _service.modelCopy = [_service.modelOringinal copy];
    if (_audioRecordingURL) {
        _service.modelCopy.soundModel.url = [_audioRecordingURL absoluteString];
        _service.modelCopy.soundModel.isRecordSound = YES;
    }
    
}

- (void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
}

#pragma mark - tableview datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return REMINDER_SETTING_TYPE_NOTES + 1;
    }
    else
        return _service.modelCopy.photoList.count > 0 ? 1:0;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.settingTableview) {
        return 2;
    }
    else
        return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 1) {
        return [self getPhotoCellAtIndexPath:indexPath];
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
        else if (indexPath.row == REMINDER_SETTING_TYPE_MUSIC_SOUND){
            return [self getsoundCellAtIndexPath:indexPath];
        }
        else if (indexPath.row == REMINDER_SETTING_TYPE_SHORT_SOUND){
            return [self configureShortSoundAtIndexPath:indexPath];
        }
        else {
            return [self configureNotesCellAtIndexPath:indexPath];
        }
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 30;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    headerView.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    if (section == 1) {
        UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(headerView.frame.origin.x + 15, 0, 60, 30)];
        labelTitle.textColor = [UIColor redColor];
        labelTitle.text = @"Photos";
        [headerView addSubview:labelTitle];
        
        
        UIButton *buttonRight = [[UIButton alloc] initWithFrame:CGRectMake(headerView.frame.size.width - 40, 0, 30, 30)];
        [buttonRight setImage:[UIImage imageNamed:@"icon_camera"] forState:UIControlStateNormal];
        [buttonRight addTarget:self action:@selector(choosePhoto:) forControlEvents:UIControlEventTouchUpInside];
        [headerView addSubview:buttonRight];
    }
    
    return headerView;
}

- (VRReminderSettingCell *)getNameCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = @"Label";
    cell.textfield.font = VRFontRegular(17);
    cell.textfield.tag = REMINDER_SETTING_TYPE_NAME;
    cell.textfield.delegate = self;
    [cell.arrowView setImage:[UIImage imageNamed:kImageArrow]];
    cell.textfield.text = _service.modelCopy.name;
    return cell;
}

- (VRReminderSettingCell *)getRepeatCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = @"Repeat";
    cell.textfield.font = VRFontRegular(17);
    cell.textfield.tag = REMINDER_SETTING_TYPE_REPEAT;
    cell.textfield.delegate = self;
    cell.textfield.text = [self.service getRepeatStringFrom:_service.modelCopy.repeats];
    
    [cell.arrowView setImage:[UIImage imageNamed:kImageArrow]];
    return cell;
}

- (VRReminderSettingCell *)getAlertCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    
    cell.titleLabel.text = @"Alert";
    cell.textfield.font = VRFontRegular(17);
    cell.textfield.tag = REMINDER_SETTING_TYPE_ALERT;
    cell.textfield.delegate = self;
    cell.textfield.text = [VREnumDefine alertTypeStringFrom:_service.modelCopy.alertReminder];
    [cell.arrowView setImage:[UIImage imageNamed:kImageArrow]];
    
    return cell;
}

- (VRReminderSettingCell *)getsoundCellAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = @"Music/sound";
    cell.textfield.font = VRFontRegular(17);
    cell.textfield.tag = REMINDER_SETTING_TYPE_MUSIC_SOUND;
    cell.textfield.delegate = self;
    VRSoundModel *model = _service.modelCopy.soundModel;
    cell.textfield.text = model.name;
    [cell.arrowView setImage:[UIImage imageNamed:kImageArrow]];
    
    return cell;
}

- (VRReminderSettingCell *)configureShortSoundAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    
    cell.titleLabel.text = @"Short sound";
    cell.textfield.font = VRFontRegular(17);
    VRShortSoundModel *model = _service.modelCopy.shortSoundModel;
    cell.textfield.text = model.name;
    cell.textfield.tag = REMINDER_SETTING_TYPE_SHORT_SOUND;
    cell.textfield.delegate = self;
    
    [cell.arrowView setImage:[UIImage imageNamed:kImageArrow]];
    return cell;
}

- (VRSettingNotesCell *)configureNotesCellAtIndexPath:(NSIndexPath *)indexPath {
    VRSettingNotesCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRSettingNotesCell class]) forIndexPath:indexPath];
    cell.labelTitle.text = @"Notes:";
    cell.arrowView.image = [UIImage imageNamed:kImageArrow];
    cell.textViewNotes.delegate = self;
    _noteTextView = (UIPlaceHolderTextView*)cell.textViewNotes;
    cell.textViewNotes.tag = REMINDER_SETTING_TYPE_NOTES;
    cell.textViewNotes.text = _service.modelCopy.notes;
    cell.textViewNotes.font = VRFontRegular(17);
    return cell;
}

- (VRPhotoListCell *)getPhotoCellAtIndexPath:(NSIndexPath *)indexPath {
    VRPhotoListCell * cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRPhotoListCell class])];
    cell.photoList = _service.modelCopy.photoList;
    cell.editingMode  = YES;
    
    __weak typeof(self)weak = self;
    cell.didDeleteCompletionBlock = ^(NSInteger index){
        __strong typeof(weak)strong = weak;
        if (strong) {
            [_service.modelCopy.photoList removeObjectAtIndex:index];
            if ([_service.modelCopy.photoList count] == 0) {
                [weak.settingTableview reloadData];
            }
        }
    };
    
    cell.didSelectImage = ^(NSInteger index) {
        [weak showPhotoPageControllerAtIndex:index];
    };
    return cell;
}

- (void)doneClicked:(id)sender {
    [self.view endEditing:YES];
}

#pragma mark - tableview delegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.settingTableview) {
        if (indexPath.section == 1) {
            return [VRPhotoListCell height];
        }
        else {
            if (indexPath.row == REMINDER_SETTING_TYPE_NOTES) {
                return MAX(44, [self caculateHeightOfTextView]);
            }
            else
                return 44;
        }
    }
    else
        return 0;
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
    BOOL validate = [_service validateModel:_service.modelCopy errorMessage:&errorMessage];
    if (validate) {
        _isLoading = YES;
        __weak typeof (self)weak = self;
        [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        [_service addReminder:_service.modelCopy toDatabaseLocalWithCompletionhandler:^(NSError *error, VRReminderModel *result) {
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

#pragma  mark - dismiss keyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
    return YES;
}


- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField {
    
    if (textField.tag == REMINDER_SETTING_TYPE_NAME) {
        [self chooseName];
        return NO;
    }
    else if (textField.tag == REMINDER_SETTING_TYPE_REPEAT) {
        [self chooseRepeatType];
        return NO;
    }
    else if (textField.tag== REMINDER_SETTING_TYPE_ALERT) {
        [self chooseAlertType];
        return NO;
    }
    else if (textField.tag == REMINDER_SETTING_TYPE_MUSIC_SOUND) {
        [self chooseMusicSound];
        return NO;
    }
    else if (textField.tag == REMINDER_SETTING_TYPE_SHORT_SOUND) {
        [self chooseShortSound];
        return NO;
    }
    
    return YES;
}

#pragma mark - set value setting

- (void) datePickerDateChanged:(UIDatePicker *)paramDatePicker{
    if ([paramDatePicker isEqual:self.datePicker]){
        NSLog(@"Selected date = %@", paramDatePicker.date);
        _service.modelCopy.timeReminder = [VRCommon commonFormatFromDateTime:paramDatePicker.date];
    }
}
- (void)chooseName {
    VRNameViewController *Vc = [[VRNameViewController alloc] initWithNibName:NSStringFromClass([VRNameViewController class]) bundle:nil];
    Vc.nameValue = _service.modelCopy.name;
    __weak typeof (self)weak = self;
    Vc.doneNameCompleted = ^(NSString *name) {
        __strong typeof (weak)strong = weak;
        strong.service.modelCopy.name = name;
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [strong.settingTableview reloadSections:[NSIndexSet indexSetWithIndex:0] withRowAnimation:UITableViewRowAnimationAutomatic];
        });
    };
    
    [self.navigationController pushViewController:Vc animated:YES];
}

- (void)chooseRepeatType {
    VRRepeatViewController *VC = [[VRRepeatViewController alloc] initWithNibName:NSStringFromClass([VRRepeatViewController class]) bundle:nil];
    [VC.arrayRepeatSelected removeAllObjects];
    VC.arrayRepeatSelected = [_service.modelCopy.repeats mutableCopy];
    __weak typeof (self)weak = self;
    VC.selectedCompleted = ^(NSMutableArray *listRepeatSelected) {
        __strong typeof (weak)strong = weak;
        [strong.service.modelCopy.repeats removeAllObjects];
        [strong saveListRepeatToModel:listRepeatSelected];
        dispatch_async(dispatch_get_main_queue(), ^{
            [strong.settingTableview reloadData];
        });
    };
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)saveListRepeatToModel:(NSMutableArray *)listRepeat {
    VRRepeatModel *model = [[VRRepeatModel alloc] init];
    if (listRepeat.count == 7) {
        model.repeatType = REPEAT_TYPE_EVERYDAY;
        [self.service.modelCopy.repeats addObject:model];
    }
    else if (!listRepeat.count) {
        model.repeatType = REPEAT_TYPE_NERER;
        [self.service.modelCopy.repeats addObject:model];
    }
    else {
        self.service.modelCopy.repeats = [listRepeat mutableCopy];
    }

}

- (void)chooseAlertType {
    VRAlertViewController *VC = [[VRAlertViewController alloc] initWithNibName:NSStringFromClass([VRAlertViewController class]) bundle:nil];
    VC.alertSelected = [VREnumDefine alertTypeStringFrom:self.service.modelCopy.alertReminder];
    
    __weak typeof (self)weak = self;
    VC.selectedAlertCompleted = ^(NSString *alert) {
        __strong typeof (weak)strong = weak;
        strong.service.modelCopy.alertReminder = [VREnumDefine alertTypeIntegerFromString:alert];
        dispatch_async(dispatch_get_main_queue(), ^{
            [strong.settingTableview reloadData];
        });
    };
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)chooseMusicSound {
    VRSoundViewController *vc = [[VRSoundViewController alloc] initWithNibName:NSStringFromClass([VRSoundViewController class]) bundle:nil];
    vc.soundModel = _service.modelCopy.soundModel;

    __weak typeof (self)weak = self;
    vc.selectedSoundCompleted = ^(VRSoundModel *soundModel) {
        __strong typeof (weak)strong = weak;
        if (!strong) {
            return ;
        }

        strong.service.modelCopy.soundModel = soundModel;
        [strong.settingTableview reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (void)chooseShortSound {
    VRShortSoundController *shortSoundVC = [[VRShortSoundController alloc] initWithNibName:NSStringFromClass([VRShortSoundController class]) bundle:nil];
    
    __weak typeof (self)weak = self;
    shortSoundVC.selectShortSoundCompleted = ^(VRShortSoundModel *soundModel) {

        weak.service.modelCopy.shortSoundModel = soundModel;
        [weak.settingTableview reloadData];
    };
    
    shortSoundVC.soundModel = _service.modelCopy.shortSoundModel;
    
    [self.navigationController pushViewController:shortSoundVC animated:YES];
}

#pragma mark -photos
- (void)choosePhoto:(id)sender {
    [self.view endEditing:YES];
    [self showPhotoActionSheet];
}

- (void)showPhotoActionSheet {
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"Take Photo", @"Choose From Library", nil];
    actionSheet.tag = kPhotoActionSheetTag;
    actionSheet.delegate = self;
    [actionSheet showInView:self.view];
}

#pragma mark - actionsheet delegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    if ([actionSheet cancelButtonIndex] == buttonIndex) {
        return;
    }
    else {
        switch (buttonIndex) {
            case 0:
                [self showCameraPicker];
                break;
            case 1:
                [self chooseImageFromLibrary];
                break;
            default:
                break;
        }
    }
}

- (void)showCameraPicker {
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.delegate = self;
        picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        picker.showsCameraControls = YES;
        
        [self.navigationController presentViewController:picker animated:YES completion:^ {
        }];
    }
}

- (void)chooseImageFromLibrary {
    [VCAppearanceConfig sharedConfig].prefixAssetsPickerTitle = @"Upload From";
    CTAssetsPickerController *picker = [[CTAssetsPickerController alloc] initWithAssetFilterType:ALAssetTypePhoto];
    picker.delegate = self;
    [self.navigationController presentViewController:picker animated:YES completion:nil];
}

#pragma mark - Assets Picker Delegate

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker isDefaultAssetsGroup:(ALAssetsGroup *)group
{
    return ([[group valueForProperty:ALAssetsGroupPropertyType] integerValue] == ALAssetsGroupSavedPhotos);
}

- (void)assetsPickerController:(CTAssetsPickerController *)picker didFinishPickingAssets:(NSArray *)assets
{
    if (picker.selectedAssets.count > 0) {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading...";
        [picker dismissViewControllerAnimated:YES completion:^{
            for (ALAsset * asset in picker.selectedAssets) {
                NSString * url = [VCAssetAccessory saveAssetToDocument:asset];
                [_service.modelCopy.photoList addObject:url];
            }
            [MBProgressHUD hideHUDForView:self.view animated:YES];
            [self.settingTableview reloadData];
            [self.settingTableview scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:1] atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        }];
    }
    else {
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldEnableAsset:(ALAsset *)asset
{
    if ([[asset valueForProperty:ALAssetPropertyType] isEqual:ALAssetTypeVideo])
    {
        return NO;
    }
    else
    {
        return YES;
    }
}

- (BOOL)assetsPickerController:(CTAssetsPickerController *)picker shouldSelectAsset:(ALAsset *)asset
{
    return (asset.defaultRepresentation != nil);
}

#pragma mark - photo controller delegate

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *img = [info objectForKey:UIImagePickerControllerEditedImage];
    if(!img)
        img = [info objectForKey:UIImagePickerControllerOriginalImage];
    if (img) {
        MBProgressHUD * hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
        hud.labelText = @"Loading ...";
        [picker dismissViewControllerAnimated:YES completion:^{
            NSString * url = [VCAssetAccessory saveImageToDocument:img];
            if (url.length) {
                [_service.modelCopy.photoList addObject:url];
            }
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.settingTableview reloadData];
        }];
    }
    else {
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
    }
}

#pragma mark - photo detail

- (void)showPhotoPageControllerAtIndex:(NSInteger)index
{
    VRPhotoPageController * photoPageController = [[VRPhotoPageController alloc] initWithPhotos:_service.modelCopy.photoList];
    [photoPageController setPageIndex:index];
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:photoPageController];
    [[VCUtilities topViewController] presentViewController:navController animated:YES completion:NULL];
}


-(void)dismissKeyboard {
    [self.view endEditing:YES];
}

#pragma mark - textview delegate
- (BOOL)textViewShouldBeginEditing:(UITextView *)textView {
    if (textView.tag == REMINDER_SETTING_TYPE_NOTES) {
        [self setNotesValue];
        return NO;
    }
    return YES;
}

- (void)setNotesValue {
    VRNotesController *noteVC = [[VRNotesController alloc] initWithNibName:NSStringFromClass([VRNotesController class]) bundle:nil];
    noteVC.notesValue = _service.modelCopy.notes;
    
    __weak typeof (self)weak = self;
    noteVC.doneNotesCompleted = ^(NSString *notes) {
        __strong typeof (weak)strong = weak;
        if (!strong) {
            return ;
        }
        strong.service.modelCopy.notes = notes;
        
        [strong.settingTableview reloadData];
    };
    
    [self.navigationController pushViewController:noteVC animated:YES];
}

- (CGFloat)caculateHeightOfTextView {
    UIPlaceHolderTextView *calculationView = _noteTextView;
    if (!calculationView) {
        calculationView = [[UIPlaceHolderTextView alloc] init];
        calculationView.font = H6_FONT;
        calculationView.contentInset = UIEdgeInsetsMake(1, -2, 0, 0);
        calculationView.textContainer.maximumNumberOfLines = 0;
        calculationView.text = self.service.modelCopy.notes;
        CGRect frame = calculationView.frame;
        frame.size.width = self.settingTableview.bounds.size.width - 42 - 10;
        calculationView.frame = frame;
    }
    CGFloat textViewWidth = calculationView.frame.size.width;
    CGSize size = [calculationView sizeThatFits:CGSizeMake(textViewWidth, FLT_MAX)];
    return size.height + 10;
}


@end
