//
//  ListReminderViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VrListReminderViewController.h"
#import "VRReminderListCell.h"
#import "VRReminderListService.h"
#import "VRReminderModel.h"
#import "VRCommon.h"
#import <SWTableViewCell.h>
#import "VRMacro.h"
#import "VRReminderDetailController.h"

static NSString * const kImageEditBlue = @"icon_edit_blue";
static NSString * const kImageDeleteBlue = @"icon_delete_blue";

@interface VRListReminderViewController ()<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>
@property (nonatomic, strong) VRReminderListService *service;
@property (nonatomic, assign) BOOL isEditMode;
@end

@implementation VRListReminderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self prepareData];
    [self configureUI];
    [self configureTableView];
}

#pragma mark - ConfigureUI
- (void)configureUI {
    self.title = @"List";
    self.isEditMode = NO;
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"Active", @"All", @"Completed"]];
    [self.segmentControl setFrame:CGRectMake(10, 5, self.view.frame.size.width - 20, 30)];
    self.segmentControl.selectedSegmentIndex = 0;
    [self.segmentControl addTarget:self action:@selector(selectedSegmentAtIndex:) forControlEvents:UIControlEventValueChanged];
    [self.view addSubview:self.segmentControl];
}

- (void)configureTableView {
    self.listEvents = [[UITableView alloc] initWithFrame:CGRectMake(0, 35, self.view.frame.size.width, self.view.frame.size.height - 140) style:UITableViewStylePlain];
    self.listEvents.backgroundColor = [UIColor whiteColor];
    self.listEvents.delegate = self;
    self.listEvents.dataSource = self;
    [self.listEvents registerClass:[VRReminderListCell class] forCellReuseIdentifier:NSStringFromClass([VRReminderListCell class])];

    [self.view addSubview:self.listEvents];
}

- (void)configureNavigationBar {
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithTitle:@"Back" style:UIBarButtonItemStylePlain target:self action:@selector(backAction:)];
    self.navigationItem.leftBarButtonItem = backButton;
}

- (void)prepareData {
    if (!_service) {
        _service = [[VRReminderListService alloc] init];
    }
    
    [_service getListReminderActive];
}

#pragma mark - Tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _service.listReminder.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderListCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    NSLog(@"%d", indexPath.row);
    
    VRReminderModel *model = [_service.listReminder objectAtIndex:indexPath.row];
    cell.leftUtilityButtons = [self leftButton];
    cell.name.text = model.name;
    cell.timeReminder.text = model.timeReminder;
    [cell layoutSubviews];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderDetailController *vc = [[VRReminderDetailController alloc] initWithNibName:NSStringFromClass([VRReminderDetailController class]) bundle:nil];
    VRReminderModel *model = [_service.listReminder objectAtIndex:indexPath.row];
    vc.model = model;
    [self.rootViewController.navigationController pushViewController:vc animated:YES];
}

- (NSArray *)leftButton{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:45.0f/255.0f green:50.0f/255.0f blue:53.0f/255.0f alpha:1] icon:[UIImage imageNamed:kImageDeleteBlue]];
    
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:34.0f/255.0f green:38.0f/255.0f blue:41.0f/255.0f alpha:1] icon:[UIImage imageNamed:kImageEditBlue]];
    
    return leftUtilityButtons;
}

#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
#pragma mark - actions
- (void)backAction:(id)sender {
    NSLog(@"back");
}

- (void)selectedSegmentAtIndex:(UISegmentedControl *)segment {
    switch (segment.selectedSegmentIndex) {
        case 0:
            [_service getListReminderActive];
            break;
        case 1:
            [_service getListReminderAll];
            break;
        case 2:
            [_service getListReminderCompleted];
            break;
        default:
            break;
    }
    
    [self.listEvents reloadData];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - List reminder 
- (void)editAction {
    self.isEditMode = !self.isEditMode;
    [self.listEvents reloadData];
}
@end
