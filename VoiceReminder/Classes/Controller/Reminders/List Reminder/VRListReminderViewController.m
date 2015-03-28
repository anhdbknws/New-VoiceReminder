//
//  ListReminderViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VrListReminderViewController.h"

@interface VRListReminderViewController ()<UITableViewDataSource, UITableViewDelegate>

@end

@implementation VRListReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

#pragma mark - ConfigureUI
- (void)configureUI {
    self.title = @"List";
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"Active", @"All", @"Completed"]];
    [self.segmentControl setFrame:CGRectMake(10, 65, self.view.frame.size.width - 20, 30)];
    self.segmentControl.selectedSegmentIndex = 0;
    [self.segmentControl addTarget:self action:@selector(selectedSegmentAtIndex:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentControl];
    
    self.listEvents = [[UITableView alloc] initWithFrame:CGRectMake(0, 96, self.view.frame.size.width, self.view.frame.size.height - 140) style:UITableViewStylePlain];
    self.listEvents.backgroundColor = [UIColor whiteColor];
    self.listEvents.delegate = self;
    self.listEvents.dataSource = self;
    [self.view addSubview:self.listEvents];
}

- (void)configureNavigationBar {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
                                   
}

#pragma mark - Tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 100;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row];
    return cell;
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 44;
}
#pragma mark - actions
- (void)backAction:(id)sender {
    NSLog(@"back");
}

- (void)selectedSegmentAtIndex:(UISegmentedControl *)segment {
    NSLog(@"%@", [segment titleForSegmentAtIndex:segment.selectedSegmentIndex]);
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

@end
