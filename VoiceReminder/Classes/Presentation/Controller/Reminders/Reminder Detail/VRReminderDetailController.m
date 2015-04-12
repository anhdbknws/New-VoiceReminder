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

@interface VRReminderDetailController () <AVAudioPlayerDelegate, UITextFieldDelegate>
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, assign) BOOL isPlaying;
@end

@implementation VRReminderDetailController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"diepnn";
        self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupTableView];
    [self configureNavigation];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isPlaying = NO;
}

- (void)configureNavigation {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor redColor],NSForegroundColorAttributeName,
                                    [UIColor redColor],NSBackgroundColorAttributeName,nil];
    [backButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)setupTableView {
    self.tableViewDetail.delegate = self;
    self.tableViewDetail.dataSource = self;
    self.tableViewDetail.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    self.tableViewDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableViewDetail registerNib:[UINib nibWithNibName:NSStringFromClass([VRReminderSettingCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([VRReminderSettingCell class])];
    [self.tableViewDetail registerClass:[VRPhotoListCell class] forCellReuseIdentifier:NSStringFromClass([VRPhotoListCell class])];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return REMINDER_DETAIL_ROW_TYPE_SOUND + 1;
    }
    else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        return [self getSettingInforAtIndexPath:indexPath];
    }
    else {
        return [self getPhotoCell];
    }
}

- (VRReminderSettingCell *)getSettingInforAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderSettingCell *cell = [self.tableViewDetail dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderSettingCell class]) forIndexPath:indexPath];
    cell.titleLabel.text = [self titleAtIndexPath:indexPath];
    cell.textfield.text = [self valueAtIndexPath:indexPath];
    cell.textfield.tag = indexPath.row;
    cell.textfield.delegate = self;
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
        case REMINDER_DETAIL_ROW_TYPE_SOUND:
            titleString = @"Sound";
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
        case REMINDER_DETAIL_ROW_TYPE_SOUND:
            valueString = _model.soundModel.name;
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
    if (textField.tag == REMINDER_DETAIL_ROW_TYPE_SOUND) {
        if (!self.isPlaying) {
            self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:[NSURL URLWithString:_model.soundModel.url] error:nil];
            self.isPlaying = YES;
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
    }
    
    return NO;
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.audioPlayer = nil;
    self.isPlaying = NO;
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
