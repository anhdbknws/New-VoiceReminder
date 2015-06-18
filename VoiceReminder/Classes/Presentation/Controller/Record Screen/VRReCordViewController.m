//
//  VRReCordViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/10/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReCordViewController.h"
#import "VRReminderSettingViewController.h"
#import "VRLocalizeKey.h"
#import "VRLocalizationCenter.h"
#import "Session.h"
#import "CircleProgressView.h"
#import "CircleShapeLayer.h"

static NSInteger minutesLimit = 1;

@interface VRReCordViewController () <AVAudioRecorderDelegate, AVAudioPlayerDelegate>
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic, strong) Session *session;
@property (strong, nonatomic) NSTimer *timer;
@property (nonatomic, assign) BOOL isPlaying;
@property (nonatomic, assign) NSTimeInterval durationRecording;
@property (nonatomic, assign) NSTimeInterval progessTimePlaying;
@property (nonatomic, strong) NSURL * audioRecordingUrl;
@end

@implementation VRReCordViewController
{
    int count;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Record";
    self.view.backgroundColor = [UIColor whiteColor];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    [self configureUI];
    [self configureNavigationBar];
    [self prepareData];
}

#pragma mark - ConfigureUI

- (void)configureUI {
    [self.view addSubview:self.circleView];
    [self.view addSubview:self.startButton];
    [self.view addSubview:self.stopButton];
    [self.view addSubview:self.reRecordButton];
    [self.view addSubview:self.playButton];
}

- (void)prepareData {
    // session
    _session = [[Session alloc] init];
    _session.state = kSessionStateStop;
}

- (void)configureNavigationBar {
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    if (self.isComeFromMainScreen) {
         [self leftNavigationItem:nil andTitle:@"Back" orImage:nil];
         [self rightNavigationItem:@selector(settingClick:) andTitle:@"Create alarm" orImage:nil];
    }
    else {
        [self leftNavigationItem:nil andTitle:@"Cancel" orImage:nil];
        [self rightNavigationItem:@selector(doneAction:) andTitle:@"Done" orImage:nil];
    }
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.backgroundColor = [UIColor whiteColor];
    // for autolayout
    
    [_reRecordButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_reRecordButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:15];
    [_reRecordButton autoSetDimension:ALDimensionWidth toSize:41.0f];
    [_reRecordButton autoSetDimension:ALDimensionHeight toSize:36];
    
    [_playButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:15];
    [_playButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:15];
    [_playButton autoSetDimension:ALDimensionWidth toSize:41.0f];
    [_playButton autoSetDimension:ALDimensionHeight toSize:36];
    
    
    [_circleView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:50.0f];
    [_circleView autoPinEdgeToSuperviewEdge:ALEdgeLeading ];
    [_circleView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [_circleView autoSetDimension:ALDimensionHeight toSize:220.0f];
    [_circleView autoSetDimension:ALDimensionWidth toSize:220.0f];
    
    [_startButton autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:35.0f];
    [_startButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50];
    [_startButton autoSetDimension:ALDimensionWidth toSize:100];
    [_startButton autoSetDimension:ALDimensionHeight toSize:44];
    
    [_stopButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:35.0f];
    [_stopButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50.0f];
    [_stopButton autoSetDimension:ALDimensionWidth toSize:100];
    [_stopButton autoSetDimension:ALDimensionHeight toSize:44];
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    self.session = nil;
    self.circleView = nil;
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [[UIButton alloc] initForAutoLayout];
        [self configureButton:_startButton withTitle:@"Start"];
        [_startButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _startButton;
}

- (UIButton *)stopButton {
    if (!_stopButton) {
        _stopButton = [[UIButton alloc] initForAutoLayout];
        [self configureButton:_stopButton withTitle:@"Stop"];
        [_stopButton addTarget:self action:@selector(stopAction:) forControlEvents:UIControlEventTouchUpInside];
        [_stopButton setEnabled:NO];
    }
    
    return _stopButton;
}

- (UIButton *)reRecordButton {
    if (!_reRecordButton) {
        _reRecordButton = [[UIButton alloc] initForAutoLayout];
        [_reRecordButton setImage:[[UIImage imageNamed:@"Re-record-icon.png"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_reRecordButton addTarget:self action:@selector(reRecordAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _reRecordButton;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [[UIButton alloc] initForAutoLayout];
        [_playButton setImage:[[UIImage imageNamed:@"speaker"] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] forState:UIControlStateNormal];
        [_playButton addTarget:self action:@selector(playAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _playButton;
}

- (CircleProgressView *)circleView {
    if(!_circleView) {
        _circleView = [[CircleProgressView alloc] initForAutoLayout];
        _circleView.backgroundColor = [UIColor clearColor];
        _circleView.status = @"Stop";
        _circleView.timeLimit = minutesLimit * 60;
        _circleView.elapsedTime = 0;
        _circleView.tintColor = [UIColor colorWithRed:184/255.0 green:233/255.0 blue:134/255.0 alpha:1.0];
    }
    
    return _circleView;
}

- (void)configureButton:(UIButton *)button withTitle:(NSString *)title {
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:H2_COLOR];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [button setShowsTouchWhenHighlighted:YES];
    button.layer.cornerRadius = 8;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [UIColor redColor].CGColor;
}

#pragma mark - Actions
- (void)startAction:(id)sender {
    /*start date and finish date to caculate progress time*/
    self.session.startDate = [NSDate date];
    self.session.finishDate = nil;
    self.session.state = kSessionStateStart;
    
    [self settingCircleView:@"Recording" andProgressTime:0];
    [self startTimer];
    [self startRecordingAudio];
    
    [_stopButton setEnabled:YES];
}

- (void)stopAction:(id)sender {
    [self stopRecordingOnAudioRecorder:self.audioRecorder];
    self.session.finishDate = [NSDate date];
    self.session.state = kSessionStateStop;
    [self settingCircleView:@"Not recording" andProgressTime:self.session.progressTime];
    self.durationRecording = self.session.progressTime;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - timer

- (void)startTimer {
    if ((!self.timer) || (![self.timer isValid])) {
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.00
                                                      target:self
                                                    selector:@selector(poolTimer)
                                                    userInfo:nil
                                                     repeats:YES];
    }
}

- (void)poolTimer
{
    if ((self.session) && (self.session.state == kSessionStateStart))
    {
        self.circleView.elapsedTime = self.session.progressTime;
    }
    else if(self.session && self.session.state == kSessionStatePlay) {
        self.circleView.elapsedTime = self.progessTimePlaying;
    }
}

#pragma  mark - record action
- (void)startRecordingAudio {
    NSError *error = nil;
    _audioRecordingUrl = [self audioRecordingPath];
    if (!self.audioRecorder) {
        self.audioRecorder = [[AVAudioRecorder alloc]
                              initWithURL:_audioRecordingUrl
                              settings:[self audioRecordingSettings]
                              error:&error];
    }
    
    if (self.audioRecorder) {
        self.audioRecorder.delegate = self;
        
        if (self.audioRecorder.recording) {
            [self.audioRecorder stop];
        }
    
        if ([self.audioRecorder prepareToRecord]) {
            AVAudioSession *session = [AVAudioSession sharedInstance];
            [session setCategory:AVAudioSessionCategoryPlayAndRecord error:nil];
            [session setActive:YES error:nil];
            
            [self.audioRecorder record];
        }
        else {
            self.audioRecorder = nil;
        }
    }
    else {
        NSLog(@"Failed to create an instance of the audio recorder.");
    }
}

- (NSURL*)audioRecordingPath {
    NSArray *pathComponents = [NSArray arrayWithObjects:
                               [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject],
                               [NSString stringWithFormat:@"%@.m4a", kNameDefaultAudioRecord],
                               nil];
    
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    return outputFileURL;
}

- (NSDictionary *) audioRecordingSettings{
    NSDictionary *audioSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat:44100],AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatAppleLossless],AVFormatIDKey,
                                  [NSNumber numberWithInt: 1],AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt:AVAudioQualityHigh],AVEncoderAudioQualityKey,nil];
    return audioSetting;
}

- (void) stopRecordingOnAudioRecorder:(AVAudioRecorder *)paramRecorder{
    [paramRecorder stop];
}

#pragma audio record delegate;
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        NSLog(@"Successfully stopped the audio recording process.");
        
        /* Let's try to retrieve the data for the recorded file */
//        NSError *readingError = nil;
//        NSData  *fileData = [NSData dataWithContentsOfURL:[self audioRecordingPath]
//                                                  options:NSDataReadingMapped
//                                                    error:&readingError];
//        NSLog(@"%@", fileData);
    }
    else {
        NSLog(@"Stopping the audio recording failed.");
    }
}

#pragma mark - Actions
- (void)backAction:(id)sender {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)reRecordAction:(id)sender {
    [self stopRecordingOnAudioRecorder:self.audioRecorder];
    [self startAction:nil];
}

- (void)playAction:(id)sender {
    if (!self.isPlaying && _audioRecordingUrl) {
        
        /* setting circle view */
        self.session.startDate = [NSDate date];
        self.session.finishDate = [self.session.startDate dateByAddingTimeInterval:self.durationRecording];
        self.session.state = kSessionStatePlay;
        
        count = 0;
        [self settingCircleView:@"Playing" andProgressTime:0];
        [self startTimer];
        
        self.isPlaying = YES;
        [self stopRecordingOnAudioRecorder:self.audioRecorder];
        self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:_audioRecordingUrl error:nil];
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
    else {
        self.isPlaying = NO;
        [self settingCircleView:@"Playing" andProgressTime:count + 1];
        self.session.state = kSessionStateStop;
        [self.audioPlayer stop];
    }
}

- (NSTimeInterval)progessTimePlaying {
    if (count <= self.durationRecording) {
        count ++;
        return count;
    }
    
    self.isPlaying = NO;
    
    return self.durationRecording + 1;
}

- (void)setImageForPlayButton:(UIImage *)image {
    
}

- (void)settingCircleView:(NSString *)progressString andProgressTime:(NSTimeInterval)progressTime {
    UIColor *tintColor = [UIColor colorWithRed:184/255.0 green:233/255.0 blue:134/255.0 alpha:1.0];
    self.circleView.status = progressString;
    self.circleView.tintColor = tintColor;
    self.circleView.elapsedTime = progressTime;
}

- (void)settingClick:(id)sender {
    [self stopRecordingOnAudioRecorder:self.audioRecorder];
    
    if (![self.audioRecorder isRecording]) {
        VRReminderSettingViewController *reminderSettingViewController = [[VRReminderSettingViewController alloc] initWithNibName:NSStringFromClass([VRReminderSettingViewController class]) bundle:nil];
        reminderSettingViewController.audioRecordingURL = _audioRecordingUrl;
        [self.navigationController pushViewController:reminderSettingViewController animated:YES];
    }
}

- (void)doneAction:(id)sender {
    [self.view endEditing:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
