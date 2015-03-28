//
//  VRReCordViewController.h
//  VoiceReminder
//
//  Created by GemCompany on 1/10/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>
@class CircleProgressView;
@interface VRReCordViewController : UIViewController
@property (nonatomic, strong) CircleProgressView *circleView;
@property (nonatomic, strong) UIButton *startButton;
@property (nonatomic, strong) UIButton *doneButton;
@property (nonatomic, strong) UIButton *reRecordButton;
@property (nonatomic, strong) UIButton *playButton;
@end
