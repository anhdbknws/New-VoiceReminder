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
#import "VRRepeatCell.h"

@interface VRSoundViewController ()<UITableViewDataSource, UITableViewDelegate, MPMediaPickerControllerDelegate>
@property (nonatomic, strong) MPMusicPlayerController *musicPlayer;

@end

@implementation VRSoundViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Sound";
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self getListSoundFromDBLocal];
    [self configureNavigation];
    [self configureTableView];
}

- (void)configureNavigation {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor redColor],NSForegroundColorAttributeName,
                                    [UIColor redColor],NSBackgroundColorAttributeName,nil];
    [backButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)configureTableView {
    self.tableViewSound.delegate = self;
    self.tableViewSound.dataSource = self;
    self.tableViewSound.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableViewSound.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    [self.tableViewSound registerClass:[VRRepeatCell class] forCellReuseIdentifier:NSStringFromClass([VRRepeatCell class])];
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
    return SOUND_SECTION_TYPE_SONGS + 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == 0) {
        return _service.recordArray.count;
    }
    else
        return _service.songArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        VRRepeatCell *cell = [self.tableViewSound dequeueReusableCellWithIdentifier:NSStringFromClass([VRRepeatCell class]) forIndexPath:indexPath];
        cell.imageV.hidden = NO;
        
        VRSoundModel *model = [_service.recordArray objectAtIndex:indexPath.row];
        cell.titleLable.text = model.name;
        
        
        if (self.selectedSoundModel.isDefaultObject) {
            [cell.imageV setImage:[UIImage imageNamed:@"assesory"]];
        }
        else {
            if ([model.uuid isEqualToString:self.selectedSoundModel.uuid]) {
                [cell.imageV setImage:[UIImage imageNamed:@"assesory"]];
            }
            else
                [cell.imageV setImage:[UIImage imageNamed:@""]];
        }
        return cell;
    }
    else {
        VRRepeatCell *cell = [self.tableViewSound dequeueReusableCellWithIdentifier:NSStringFromClass([VRRepeatCell class]) forIndexPath:indexPath];
        VRSoundModel *model = [_service.songArray objectAtIndex:indexPath.row];
        cell.titleLable.text = model.name;
        
        [cell.imageV setImage:[UIImage imageNamed:@""]];
        if (indexPath.row == 0) {
            cell.imageV.hidden = YES;
            [cell.rightArrow setImage:[UIImage imageNamed:@"icon_arrow_right"]];
        }
        else {
            cell.imageV.hidden = NO;
            if ([model.uuid isEqualToString:self.selectedSoundModel.uuid]) {
                [cell.imageV setImage:[UIImage imageNamed:@"assesory"]];
            }
            else
                [cell.imageV setImage:[UIImage imageNamed:@""]];
        }
        
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44.0f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 50.0f;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view  = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 30)];
    view.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    UILabel *labelTitle = [[UILabel alloc] initWithFrame:CGRectMake(10, 10, view.frame.size.width - 20, 30)];
    labelTitle.textColor = [UIColor colorWithRed:149/255.0 green:148/255.0 blue:153/255.0 alpha:1];
    
    if (section == 0) {
        labelTitle.text = @"Records";
    }
    else{
        labelTitle.text = @"Songs";
    }

    [view addSubview:labelTitle];
    return view;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.tableViewSound deselectRowAtIndexPath:indexPath animated:YES];
    VRSoundModel *model = [_service.songArray objectAtIndex:indexPath.row];
    if (indexPath.section == 1 && model.isDefaultObject) {
        [self configureMediaPlayer];
        [self chooseSongFromLibrary];
    }
    else {
        self.selectedSoundModel = model;
        
        [self.tableViewSound reloadData];
    }
}

#pragma mark - Actions
- (void)backAction:(id)sender {
    if (self.selectedSoundCompleted) {
        self.selectedSoundCompleted (self.selectedSoundModel);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
    [self.musicPlayer stop];
    self.musicPlayer = nil;
}

#pragma mark - choose song from music library

- (void)configureMediaPlayer {
    self.musicPlayer = [MPMusicPlayerController applicationMusicPlayer];
}

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
        VRSoundModel *soundModel = [VRSoundModel new];
        soundModel.persistenID = [item valueForProperty:MPMediaItemPropertyPersistentID];
        soundModel.name = [item valueForProperty:MPMediaItemPropertyTitle];
        soundModel.isDefaultObject = NO;
        [_service saveSoundWithModel:soundModel toDatabaseLocalWithCompletionhandler:^(NSError *error, id result) {
            [_service.songArray insertObject:soundModel atIndex:1];
            _selectedSoundModel = soundModel;
            [self.tableViewSound reloadData];
        }];
        
//        NSNumber *persistenID = [item valueForProperty:MPMediaItemPropertyPersistentID];
//        MPMediaQuery *query = [MPMediaQuery songsQuery];
//        MPMediaPropertyPredicate *predicate = [MPMediaPropertyPredicate predicateWithValue:persistenID forProperty:MPMediaItemPropertyPersistentID];
//        [query addFilterPredicate:predicate];
//        NSArray *mediaItems = [query items];
//        //this array will consist of song with given persistentId. add it to collection and play it
//        MPMediaItemCollection *col = [[MPMediaItemCollection alloc] initWithItems:mediaItems];
        
        
        
        [_musicPlayer setQueueWithItemCollection: mediaItemCollection];
        [_musicPlayer play];
    }
    
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

- (void)mediaPickerDidCancel:(MPMediaPickerController *)mediaPicker {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

@end
