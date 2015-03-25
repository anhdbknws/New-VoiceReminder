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

@interface VRReCordViewController () <AVAudioRecorderDelegate>
@property (nonatomic, strong) AVAudioRecorder *audioRecorder;
@property (nonatomic, strong) AVAudioRecorder *audioPlayer;
@property (nonatomic, strong) Session *session;
@property (strong, nonatomic) NSTimer *timer;
@end

@implementation VRReCordViewController

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
    [self.view addSubview:self.doneButton];
    [self.view addSubview:self.reRecordButton];
    [self.view addSubview:self.playButton];
}

- (void)prepareData {
    // session
    _session = [[Session alloc] init];
    _session.state = kSessionStateStop;
}

- (void)configureNavigationBar {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
    
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor redColor],NSForegroundColorAttributeName,
                                    [UIColor redColor],NSBackgroundColorAttributeName,nil];
    [backButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
}

- (void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
    self.navigationController.navigationBar.translucent = NO;
    
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
    
    [_doneButton autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:35.0f];
    [_doneButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:50.0f];
    [_doneButton autoSetDimension:ALDimensionWidth toSize:100];
    [_doneButton autoSetDimension:ALDimensionHeight toSize:44];
}

- (UIButton *)startButton {
    if (!_startButton) {
        _startButton = [[UIButton alloc] initForAutoLayout];
        [self configureButton:_startButton withTitle:@"Start"];
        [_startButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _startButton;
}

- (UIButton *)doneButton {
    if (!_doneButton) {
        _doneButton = [[UIButton alloc] initForAutoLayout];
        [self configureButton:_doneButton withTitle:@"Done"];
        [_doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    return _doneButton;
}

- (UIButton *)reRecordButton {
    if (!_reRecordButton) {
        _reRecordButton = [[UIButton alloc] initForAutoLayout];
        [_reRecordButton setImage:[UIImage imageNamed:@"speaker"] forState:UIControlStateNormal];
    }
    
    return _reRecordButton;
}

- (UIButton *)playButton {
    if (!_playButton) {
        _playButton = [[UIButton alloc] initForAutoLayout];
        [_playButton setImage:[UIImage imageNamed:@"speaker"] forState:UIControlStateNormal];
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
    
    if (self.session.state == kSessionStateStop) {
        self.session.startDate = [NSDate date];
        self.session.finishDate = nil;
        self.session.state = kSessionStateStart;
        
        UIColor *tintColor = [UIColor colorWithRed:184/255.0 green:233/255.0 blue:134/255.0 alpha:1.0];
        self.circleView.status = @"Recording";
        self.circleView.tintColor = tintColor;
        self.circleView.elapsedTime = 0;
        [self.startButton setTitle:@"Stop" forState:UIControlStateNormal];
        [self.doneButton setEnabled:NO];
        [self startTimer];
        [self startRecordingAudio];
    }
    else {
        [self stopRecordingOnAudioRecorder:self.audioRecorder];
        
        self.session.finishDate = [NSDate date];
        self.session.state = kSessionStateStop;
        
        self.circleView.status = @"not started";
        self.circleView.tintColor = [UIColor whiteColor];
        self.circleView.elapsedTime = self.session.progressTime;
        [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    }

}

- (void)doneAction:(id)sender {
    [self.audioRecorder stop];
    
    if (![self.audioRecorder isRecording]) {
        VRReminderSettingViewController *reminderSettingViewController = [[VRReminderSettingViewController alloc] initWithNibName:NSStringFromClass([VRReminderSettingViewController class]) bundle:nil];
        reminderSettingViewController.audioRecordingURL = [self audioRecordingPath];
        [self.navigationController pushViewController:reminderSettingViewController animated:YES];
    }
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
}

#pragma  mark - record action
- (void)startRecordingAudio {
    NSError *error = nil;
    NSURL *audioRecordingURL = [self audioRecordingPath];
    if (!self.audioRecorder) {
        self.audioRecorder = [[AVAudioRecorder alloc]
                              initWithURL:audioRecordingURL
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
                               @"MyAudioMemo.m4a",
                               nil];
    
    NSURL *outputFileURL = [NSURL fileURLWithPathComponents:pathComponents];
    return outputFileURL;
}

- (NSDictionary *) audioRecordingSettings{
    NSDictionary *audioSetting = [NSDictionary dictionaryWithObjectsAndKeys:
                                  [NSNumber numberWithFloat:44100],AVSampleRateKey,
                                  [NSNumber numberWithInt: kAudioFormatAppleLossless],AVFormatIDKey,
                                  [NSNumber numberWithInt: 1],AVNumberOfChannelsKey,
                                  [NSNumber numberWithInt:AVAudioQualityMedium],AVEncoderAudioQualityKey,nil];
    return audioSetting;
}

- (void) stopRecordingOnAudioRecorder:(AVAudioRecorder *)paramRecorder{
    /* Just stop the audio recorder here */
    [paramRecorder stop];
}

#pragma audio record delegate;
- (void)audioRecorderDidFinishRecording:(AVAudioRecorder *)recorder successfully:(BOOL)flag {
    if (flag) {
        NSLog(@"Successfully stopped the audio recording process.");
        [self.doneButton setEnabled:YES];
        NSError *readingError = nil;
        NSData  *fileData = [NSData dataWithContentsOfURL:[self audioRecordingPath]
                              options:NSDataReadingMapped
                                error:&readingError];
        NSLog(@"%@", fileData);
        
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

}

- (void)playAction:(id)sender {

}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
