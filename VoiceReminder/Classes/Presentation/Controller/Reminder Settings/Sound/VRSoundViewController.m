//
//  VRSoundViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 3/28/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRSoundViewController.h"
#import <MediaPlayer/MediaPlayer.h>
#import "VRSoundModel.h"
#import "VRReCordViewController.h"
#import "VRSoundCell.h"

@interface VRSoundViewController ()<UITableViewDataSource, UITableViewDelegate, MPMediaPickerControllerDelegate, AVAudioPlayerDelegate>
@property (nonatomic, strong) MPMusicPlayerController *musicPlayer;
@property (assign) BOOL isPlaying;
@end

@implementation VRSoundViewController
{
    SOUND_TYPE currentType;
}
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Music/sound";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getListSoundFromDBLocal];
    [self leftNavigationItem:@selector(backAction) andTitle:@"Back" orImage:nil];
    [self rightNavigationItem:@selector(addAction:) andTitle:nil orImage:[UIImage imageNamed:@"bt_add"]];
    [self configureTableView];
    [self setupSegment];
    [self getRightBarItem];
    [self hideAddButton];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
}

- (void)setupSegment {
    [self.segment addTarget:self action:@selector(segmentChanged:) forControlEvents:UIControlEventValueChanged];
    [self.segment setTintColor:[UIColor redColor]];
    
    [self.segment setTitle:@"Short sound" forSegmentAtIndex:0];
    [self.segment setTitle:@"Songs" forSegmentAtIndex:1];
    [self.segment setTitle:@"Records" forSegmentAtIndex:2];
    
    [self.segment setTitleTextAttributes:@{NSFontAttributeName:VRFontRegular(17),
                                           NSForegroundColorAttributeName:[UIColor redColor]}
                                forState:UIControlStateNormal];
    currentType = SOUND_TYPE_SHORT_SOUND;
}

- (void)configureTableView {
    self.tableViewSound.delegate = self;
    self.tableViewSound.dataSource = self;
    self.tableViewSound.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewSound.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    [self.tableViewSound registerClass:[VRSoundCell class] forCellReuseIdentifier:NSStringFromClass([VRSoundCell class])];
}

- (void)getListSoundFromDBLocal {
    
    _service = [[VRSoundService alloc] init];
    
    __weak typeof (self)weak = self;
    _service.getSoundListCompleted = ^(){
        __strong typeof (weak)strong = weak;
        [strong.tableViewSound reloadData];
    };
    [_service getListSounds];
}

#pragma mark - tableview Delegate && datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (currentType == SOUND_TYPE_RECORD) {
        return _service.recordSoundArray.count;
    }
    else if (currentType == SOUND_TYPE_SHORT_SOUND) {
        return [VREnumDefine listShortSound].count;
    }
    else
        return _service.mp3SoundArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VRSoundCell *cell = [self.tableViewSound dequeueReusableCellWithIdentifier:NSStringFromClass([VRSoundCell class]) forIndexPath:indexPath];
    VRSoundModel *model;
    cell.arrowImage.hidden = NO;
    if (currentType == SOUND_TYPE_RECORD) {
        model = [_service.recordSoundArray objectAtIndex:indexPath.row];
    }
    else if (currentType == SOUND_TYPE_SHORT_SOUND) {
        model = [_service.shortSoundArray objectAtIndex:indexPath.row];
    }
    else {
        model = [_service.mp3SoundArray objectAtIndex:indexPath.row];
    }
    cell.labelTitle.text = model.name;
    [cell.imageV setImage:[UIImage imageNamed:@"icon_sound"]];
    if ([model.name isEqualToString:self.soundModel.name]) {
        [cell.arrowImage setImage:[UIImage imageNamed:@"assesory"]];
    }
    else {
        cell.arrowImage.hidden = YES;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableViewSound deselectRowAtIndexPath:indexPath animated:YES];
    if (currentType == SOUND_TYPE_RECORD) {
        self.soundModel = [_service.recordSoundArray objectAtIndex:indexPath.row];
    }
    else if (currentType == SOUND_TYPE_SHORT_SOUND) {
        self.soundModel = [_service.shortSoundArray objectAtIndex:indexPath.row];
    }
    else {
        self.soundModel = [_service.mp3SoundArray objectAtIndex:indexPath.row];
    }
    
    [self.tableViewSound reloadData];
    
    /*play audio*/
    if (currentType == SOUND_TYPE_SHORT_SOUND) {
        if (self.isPlaying) {
            [self.audioPlayer stop];
            self.audioPlayer = nil;
        }
        
        [self setupAudioPlayerForShortSound:self.soundModel.name];
        [self playSound];
    }
}

#pragma mark - Actions
- (void)backAction {
    [self.audioPlayer stop];
    [self.view endEditing:YES];
    
    if (self.selectedSoundCompleted) {
        self.selectedSoundCompleted (self.soundModel);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)addAction:(id)sender {
    if (currentType == SOUND_TYPE_RECORD) {
        [self record];// next version
    }
    else {
        [self addMp3];
    }
}
- (void)addMp3 {
    [self chooseSongFromLibrary];
}

- (void)record {
    VRReCordViewController *Vc = [[VRReCordViewController alloc] init];
    [self.navigationController pushViewController:Vc animated:YES];
}

- (void)segmentChanged:(UISegmentedControl *)sender {
    [self.audioPlayer stop];
    
    NSInteger selectedSegmentIndex = [sender selectedSegmentIndex];
    switch (selectedSegmentIndex) {
        case SOUND_TYPE_RECORD:
            currentType = SOUND_TYPE_RECORD;
            [self showAddButton];
            break;
        case SOUND_TYPE_SONG:
            currentType = SOUND_TYPE_SONG;
            [self showAddButton];
            break;
        case SOUND_TYPE_SHORT_SOUND:
            currentType = SOUND_TYPE_SHORT_SOUND;
            [self hideAddButton];
            break;
        default:
            break;
    }
    
    [self.tableViewSound reloadData];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.musicPlayer stop];
    self.musicPlayer = nil;
}

#pragma mark - choose song from music library

- (void)chooseSongFromLibrary {
    MPMediaPickerController *pickerVC = [[MPMediaPickerController alloc] initWithMediaTypes:MPMediaTypeMusic];
    pickerVC.delegate                   = self;
    pickerVC.allowsPickingMultipleItems = NO;
    pickerVC.prompt                     = NSLocalizedString (@"Select any song from the list", @"Prompt to user to choose some songs to play");

    [self.navigationController presentViewController:pickerVC animated:YES completion:nil];
}

- (void)mediaPicker:(MPMediaPickerController *)mediaPicker didPickMediaItems:(MPMediaItemCollection *)mediaItemCollection{
    if (mediaItemCollection) {
        
        MPMediaItem *item = [mediaItemCollection.items firstObject];
        VRSoundModel *model = [VRSoundModel new];
        model.mp3Url = [item valueForKey:MPMediaItemPropertyAssetURL];
        model.name = [item valueForKey:MPMediaItemPropertyTitle];
        model.isMp3Sound = YES;
        
        BOOL isExisted = NO;
        for (VRSoundModel *object in _service.mp3SoundArray) {
            if ([object.name isEqualToString:self.soundModel.name]) {
                self.soundModel = object;
                isExisted = YES;
                break;
            }
        }
        
        if (!isExisted) {
            [_service.mp3SoundArray insertObject:model atIndex:0];
            self.soundModel = model;
        }
        
        [self.tableViewSound reloadData];
        
        if(!_musicPlayer){
            _musicPlayer = [MPMusicPlayerController iPodMusicPlayer];
        }
        
        [_musicPlayer setQueueWithItemCollection:mediaItemCollection];
        [_musicPlayer setNowPlayingItem:item];
        
        [_musicPlayer prepareToPlay];
        [_musicPlayer play];
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}


@end
