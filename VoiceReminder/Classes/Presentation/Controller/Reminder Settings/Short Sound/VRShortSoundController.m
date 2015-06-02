//
//  VRShortSoundController.m
//  VoiceReminder
//
//  Created by GemCompany on 6/2/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRShortSoundController.h"

@interface VRShortSoundController ()

@end

@implementation VRShortSoundController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"Short sound";
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)configureNavigation {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    NSDictionary *textAttributes = [NSDictionary dictionaryWithObjectsAndKeys:
                                    [UIColor redColor],NSForegroundColorAttributeName,
                                    [UIColor redColor],NSBackgroundColorAttributeName,nil];
    [backButton setTitleTextAttributes:textAttributes forState:UIControlStateNormal];
    
    self.navigationItem.leftBarButtonItem = backButton;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return (self.view.frame.size.height/2) - 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, (self.view.frame.size.height/2) - 44)];
    view.backgroundColor = [UIColor clearColor];
    
    return view;
}

#pragma mark - actions
- (void)backAction:(id)sender {

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
