//
//  VRReCordViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/10/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRReCordViewController.h"
#import "VRReminderSettingViewController.h"

static float widthButton = 70;
static float marginLeftRight = 15;

@interface VRReCordViewController ()

@end

@implementation VRReCordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

#pragma mark - ConfigureUI

- (void)configureUI {
    self.title = @"Record";
    self.view.backgroundColor = [UIColor whiteColor];
    
    // progress label
    UILabel *progressLabel = [[UILabel alloc] initWithFrame:CGRectMake(10.0f, self.view.frame.size.height/4, self.view.frame.size.width - 20, 44.0f)];
    progressLabel.backgroundColor = [UIColor whiteColor];
    progressLabel.textAlignment = NSTextAlignmentCenter;
    progressLabel.text = @"10h 5h 1s";
    [self.view addSubview:progressLabel];
    
    // progress view
    UIProgressView *progressView = [[UIProgressView alloc] initWithFrame:CGRectMake(10.0, progressLabel.frame.origin.y + 60, self.view.frame.size.width - 20, 44)];
    CGAffineTransform transform = CGAffineTransformMakeScale(1.0f, 5.0f);
    progressView.transform = transform;
    [self.view addSubview:progressView];
    
    // button control
    UIButton *startButton = [[UIButton alloc] initWithFrame:CGRectMake(marginLeftRight, progressView.frame.origin.y + 60, widthButton, 44)];
    [self configureButton:startButton withTitle:@"Start"];
    
    float distanceBetweenButtons = (self.view.frame.size.width - marginLeftRight*2 - widthButton*3)/2;
    UIButton *pauseButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + marginLeftRight + widthButton + distanceBetweenButtons, progressView.frame.origin.y + 60, widthButton, 44)];
    [self configureButton:pauseButton withTitle:@"Pause"];
    [pauseButton addTarget:self action:@selector(pauseAction:) forControlEvents:UIControlEventTouchUpInside];
    
    
    UIButton *doneButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.origin.x + marginLeftRight + widthButton*2 + distanceBetweenButtons*2, progressView.frame.origin.y + 60, widthButton, 44)];
    [self configureButton:doneButton withTitle:@"Done"];
    [doneButton addTarget:self action:@selector(doneAction:) forControlEvents:UIControlEventTouchUpInside];
    
   
    [startButton addTarget:self action:@selector(startAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:startButton];
    
    
}

- (void)configureButton:(UIButton *)button withTitle:(NSString *)title {
    [button setTitle:title forState:UIControlStateNormal];
    [button setBackgroundColor:[UIColor blueColor]];
    [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    button.layer.cornerRadius = 8;
    button.layer.borderWidth = 1.0f;
    button.layer.borderColor = [UIColor blueColor].CGColor;
    [self.view addSubview:button];
}

#pragma mark - Actions
- (void)startAction:(id)sender {

}

- (void)pauseAction:(id)sender {

}

- (void)doneAction:(id)sender {
    VRReminderSettingViewController *reminderSettingViewController = [[VRReminderSettingViewController alloc] initWithNibName:NSStringFromClass([VRReminderSettingViewController class]) bundle:nil];
    [self.navigationController pushViewController:reminderSettingViewController animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
