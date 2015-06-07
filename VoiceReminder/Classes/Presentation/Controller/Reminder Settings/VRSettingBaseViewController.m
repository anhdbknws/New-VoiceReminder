//
//  VRSettingBaseViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 6/6/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRSettingBaseViewController.h"

@interface VRSettingBaseViewController ()<AVAudioPlayerDelegate>

@end

@implementation VRSettingBaseViewController
{
    UIBarButtonItem *addButton;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)leftNavigationItem:(SEL)selector andTitle:(NSString *)title orImage:(UIImage *)image {
    SEL backSelector;
    if (selector) {
        backSelector = selector;
    }
    else {
        backSelector = @selector(backAction:);
    }
    UIBarButtonItem *leftButton;
    
    if (title.length) {
        leftButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:backSelector];
    }
    else {
        leftButton = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:selector];
    }
    
    [leftButton setTitleTextAttributes:[self textAttributes] forState:UIControlStateNormal];
    self.navigationItem.leftBarButtonItem = leftButton;
}

- (void)rightNavigationItem:(SEL)selector andTitle:(NSString *)title orImage:(UIImage *)image{
    UIBarButtonItem *rightButton;
    if (title.length) {
        rightButton = [[UIBarButtonItem alloc] initWithTitle:title style:UIBarButtonItemStylePlain target:self action:selector];
    }
    else {
        rightButton = [[UIBarButtonItem alloc] initWithImage:[image imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self action:selector];
    }
    
    [rightButton setTitleTextAttributes:[self textAttributes] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = rightButton;
}

- (NSDictionary *)textAttributes {
    return [NSDictionary dictionaryWithObjectsAndKeys:
            [UIColor redColor],NSForegroundColorAttributeName,
            [UIColor redColor],NSBackgroundColorAttributeName,nil];
}

- (void)hideAddButton {
    [self.navigationItem setRightBarButtonItem:nil animated:YES];
}

- (void)showAddButton {
    [self.navigationItem setRightBarButtonItem:addButton animated:YES];
}

- (void)getRightBarItem {
    addButton = self.navigationItem.rightBarButtonItem;
}

- (void)backAction:(id)sender {
    [self.view endEditing:YES];
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - play audio
- (void)setupAudioPlayerForShortSound:(NSString *)shortSoundName {
    NSString *backgroundMusicPath = [[NSBundle mainBundle] pathForResource:shortSoundName ofType:@"caf"];
    NSURL *backgroundMusicURL = [NSURL fileURLWithPath:backgroundMusicPath];
    self.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:backgroundMusicURL error:nil];
    self.audioPlayer.delegate = self;  // We need this so we can restart after interruptions
    self.audioPlayer.numberOfLoops = -1;
}

- (void)playSound {
    if (self.isPlaying) {
        [self.audioPlayer stop];
    }
    
    if ([self.audioPlayer prepareToPlay]) {
        [self.audioPlayer play];
    }
    
    self.isPlaying = YES;
}

@end
