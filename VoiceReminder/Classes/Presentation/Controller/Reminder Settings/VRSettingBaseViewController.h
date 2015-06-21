//
//  VRSettingBaseViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 6/6/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRSettingBaseViewController : UIViewController
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@property (nonatomic,assign) BOOL isPlaying;

- (void)leftNavigationItem:(SEL)selector andTitle:(NSString *)title orImage:(UIImage *)image;
- (void)rightNavigationItem:(SEL)selector andTitle:(NSString *)title orImage:(UIImage *)image;

- (void)getRightBarItem;
- (void)hideAddButton;
- (void)showAddButton;

// play audio
- (void)setupAudioPlayerForShortSound:(NSString *)shortSoundName;
- (void)setupPlayRecordSound:(NSString *)recordFileName;
- (void)playSound;

- (void)addTapgestureForDismissKeyboard;
@end
