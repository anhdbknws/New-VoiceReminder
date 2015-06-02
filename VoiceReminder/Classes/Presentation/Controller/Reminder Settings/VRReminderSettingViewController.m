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

static NSString * const kImageArrow = @"icon_arrow_right";
const NSInteger kPhotoActionSheetTag = 3249;

@interface VRReminderSettingViewController ()<UITableViewDataSource, UITableViewDelegate, IQDropDownTextFieldDelegate, UITextFieldDelegate, AVAudioPlayerDelegate, UIActionSheetDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate, CTAssetsPickerControllerDelegate, UITextViewDelegate>

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
    
    self.listRepeat = [NSMutableArray new];
//    self.model.notes = @"Notes";
    self.model.name = @"Name";
    self.model.repeats = [NSMutableArray new];
    self.model.alertReminder = ALERT_TYPE_AT_EVENT_TIME;
    self.model.timeReminder = [VRCommon commonFormatFromDateTime:[NSDate date]];
   
    VRSoundModel *musicModel = [[VRSoundModel alloc] init];
    musicModel.name = @"Audio recorded"; // get sound default
    musicModel.url = [self.audioRecordingURL absoluteString];
    musicModel.isSystemSound = YES;
    
    [self.model.soundModels addObject:musicModel];
    
    VRSoundModel *shortSoundModel = [[VRSoundModel alloc] init];
    shortSoundModel.name = @"background";
    shortSoundModel.isShortSound = YES;
    
    [self.model.soundModels addObject:shortSoundModel];
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
        return _model.photoList.count > 0 ? 1:0;
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
    cell.textfield.text = [self.service getRepeatStringFrom:_listRepeat];
    
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
    cell.titleLabel.text = @"Music/sound";
    cell.textfield.font = H1_FONT;
    cell.textfield.tag = REMINDER_SETTING_TYPE_MUSIC_SOUND;
    cell.textfield.delegate = self;
    for (VRSoundModel *model in self.model.soundModels) {
        if (!model.isShortSound) {
            cell.textfield.text = model.name;
        }
    }
    
    
    [cell.arrowView setImage:[UIImage imageNamed:kImageArrow]];
    
    return cell;
}

- (VRReminderSettingCell *)configureShortSoundAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = @"Short sound";
    cell.textfield.font = H1_FONT;
    for (VRSoundModel *model in self.model.soundModels) {
        if (model.isShortSound) {
            cell.textfield.text = model.name;
        }
    }
    
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
    cell.textViewNotes.placeholder = @"Name";
    cell.textViewNotes.text = self.model.notes;
    return cell;
}

- (VRPhotoListCell *)getPhotoCellAtIndexPath:(NSIndexPath *)indexPath {
    VRPhotoListCell * cell = [self.settingTableview dequeueReusableCellWithIdentifier:NSStringFromClass([VRPhotoListCell class])];
    cell.photoList = _model.photoList;
    cell.editingMode  = YES;
    
    __weak typeof(self)weak = self;
    cell.didDeleteCompletionBlock = ^(NSInteger index){
        __strong typeof(weak)strong = weak;
        if (strong) {
            [strong.model.photoList removeObjectAtIndex:index];
            if ([strong.model.photoList count] == 0) {
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

#pragma  mark - dismiss keyboard
- (BOOL) textFieldShouldReturn:(UITextField *)textField{
    [self.view endEditing:YES];
    [textField resignFirstResponder];
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
    else if (textField.tag == REMINDER_SETTING_TYPE_MUSIC_SOUND) {
        [self setMusicSound];
        return NO;
    }
    
    return YES;
}

#pragma mark - set value setting

- (void) datePickerDateChanged:(UIDatePicker *)paramDatePicker{
    if ([paramDatePicker isEqual:self.datePicker]){
        NSLog(@"Selected date = %@", paramDatePicker.date);
        _model.timeReminder = [VRCommon commonFormatFromDateTime:paramDatePicker.date];
    }
}
- (void)setName {
    VRNameViewController *Vc = [[VRNameViewController alloc] initWithNibName:NSStringFromClass([VRNameViewController class]) bundle:nil];
    Vc.nameValue = self.model.name;
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
        strong.model.repeats = [strong saveListRepeatToModel:listRepeatSelected];
        dispatch_async(dispatch_get_main_queue(), ^{
            [strong.settingTableview reloadData];
        });
    };
    
    [self.navigationController pushViewController:VC animated:YES];
}

- (NSMutableArray *)saveListRepeatToModel:(NSMutableArray *)listRepeat {
    NSMutableArray *listEnum = [NSMutableArray new];
    VRRepeatModel *model = [[VRRepeatModel alloc] init];
    if (listRepeat.count == 7) {
        model.repeatType = REPEAT_TYPE_EVERYDAY;
        [listEnum addObject:model];
    }
    else if (!listRepeat.count) {
        model.repeatType = REPEAT_TYPE_NERER;
        [listEnum addObject:model];
    }
    else {
        for (NSString *item in listRepeat) {
            model.repeatType = [VREnumDefine repeatTypeIntegerFromString:item];
            [listEnum addObject:model];
        }
    }
    
    return listEnum;
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

- (void)setMusicSound {
    VRSoundViewController *vc = [[VRSoundViewController alloc] initWithNibName:NSStringFromClass([VRSoundViewController class]) bundle:nil];
    for (VRSoundModel *model in self.model.soundModels) {
        if (!model.isShortSound) {
            vc.selectedSoundModel = model;
        }
    }

    __weak typeof (self)weak = self;
    vc.selectedSoundCompleted = ^(VRSoundModel *soundModel) {
        __strong typeof (weak)strong = weak;
        if (!strong) {
            return ;
        }
        for (VRSoundModel *model in self.model.soundModels) {
            if (!model.isShortSound) {
                [self.model.soundModels replaceObjectAtIndex:[self.model.soundModels indexOfObject:model] withObject:soundModel];
            }
        }
        [strong.settingTableview reloadData];
    };
    [self.navigationController pushViewController:vc animated:YES];
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
                [_model.photoList addObject:url];
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
                [_model.photoList addObject:url];
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
    VRPhotoPageController * photoPageController = [[VRPhotoPageController alloc] initWithPhotos:_model.photoList];
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
    noteVC.notesValue = self.model.notes;
    
    __weak typeof (self)weak = self;
    noteVC.doneNotesCompleted = ^(NSString *notes) {
        __strong typeof (weak)strong = weak;
        if (!strong) {
            return ;
        }
        strong.model.notes = notes;
        
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
        calculationView.text = self.model.notes;
        CGRect frame = calculationView.frame;
        frame.size.width = self.settingTableview.bounds.size.width - 42 - 10;
        calculationView.frame = frame;
    }
    CGFloat textViewWidth = calculationView.frame.size.width;
    CGSize size = [calculationView sizeThatFits:CGSizeMake(textViewWidth, FLT_MAX)];
    return size.height + 10;
}


@end
