//
//  VRShortSoundController.m
//  VoiceReminder
//
//  Created by GemCompany on 6/2/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRShortSoundController.h"
#import "VRSoundCell.h"

@interface VRShortSoundController () <UITableViewDataSource, UITableViewDelegate>

@end

@implementation VRShortSoundController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Short sound";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self leftNavigationItem:nil andTitle:@"Back" orImage:nil];
    [self rightNavigationItem:@selector(doneAction:) andTitle:@"Done" orImage:nil];
    [self setupTableView];
    [self getDataFromDB];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self.audioPlayer stop];
}

- (void)getDataFromDB {
    if (!_service) {
        _service = [[VRSoundService alloc] init];
    }

    __weak typeof (self)weak = self;
    _service.getSoundListCompleted = ^(){
        [weak.tableViewShortSound reloadData];
    };
    
    [_service getListSounds];
}

- (void)setupTableView {
    self.tableViewShortSound.backgroundColor = H5_COLOR;
    self.tableViewShortSound.delegate = self;
    self.tableViewShortSound.dataSource = self;
    self.tableViewShortSound.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableViewShortSound registerClass:[VRSoundCell class] forCellReuseIdentifier:NSStringFromClass([VRSoundCell class])];
}

#pragma mark - table view datasource and delegate

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 44)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _service.shortSoundArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VRSoundCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VRSoundCell class]) forIndexPath:indexPath];
    VRSoundModel *model = [_service.shortSoundArray objectAtIndex:indexPath.row];
    cell.labelTitle.text = model.name;
    [cell.imageV setImage:[UIImage imageNamed:@"icon_sound.png"]];
    
    if ([cell.labelTitle.text isEqualToString:self.soundModel.name]) {
        cell.arrowImage.hidden = NO;
        [cell.arrowImage setImage:[UIImage imageNamed:@"assesory"]];
    }
    else {
        cell.arrowImage.hidden = YES;
    }

    [cell layoutIfNeeded];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableViewShortSound deselectRowAtIndexPath:indexPath animated:YES];
    self.soundModel = [_service.shortSoundArray objectAtIndex:indexPath.row];
    
    [self.tableViewShortSound reloadData];
    [self setupAudioPlayerForShortSound:self.soundModel.name];
    [self playSound];
}

- (void)doneAction:(id)sender {
    [self.audioPlayer stop];
    
    [self.view endEditing:YES];
    if (self.selectShortSoundCompleted) {
        self.selectShortSoundCompleted(self.soundModel);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - manage memory
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
