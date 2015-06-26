//
//  ListReminderViewController.m
//  VoiceReminder
//
//  Created by GemCompany on 1/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VrListReminderViewController.h"
#import "VRReminderListCell.h"
#import "VRReminderModel.h"
#import "VRCommon.h"
#import <SWTableViewCell.h>
#import "VRMacro.h"
#import "VRReminderDetailController.h"
#import "VRReminderSettingViewController.h"

@interface VRListReminderViewController ()<UITableViewDataSource, UITableViewDelegate, SWTableViewCellDelegate>
@property (nonatomic, assign) BOOL isEditMode;
@end

@implementation VRListReminderViewController
{
    LIST_REMINDER_TYPE currentSegment;
}
- (instancetype)init {
    self = [super init];
    if (self) {
        self.view.backgroundColor = [UIColor whiteColor];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureUI];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.isEditMode = NO;
    [self getReminderFromDBLocalCompletionHandler:^(NSError *error, id result) {
        [self.listEventTableview reloadData];
    }];
}

#pragma mark - ConfigureUI
- (void)configureUI {
    self.isEditMode = NO;
    [self.view addSubview:self.segmentControl];
    [self.view addSubview:self.listEventTableview];
    [self.listEventTableview registerClass:[VRReminderListCell class] forCellReuseIdentifier:NSStringFromClass([VRReminderListCell class])];
    
    //layout
    [_segmentControl autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_segmentControl autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:5];
    [_segmentControl autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:5];
    [_segmentControl autoSetDimension:ALDimensionHeight toSize:30];
    
    [_listEventTableview autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [_listEventTableview autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [_listEventTableview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_listEventTableview autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:_segmentControl withOffset:3];
    
    currentSegment = LIST_REMINDER_TYPE_ACTIVE;
}

- (UISegmentedControl *)segmentControl {
    if (!_segmentControl) {
        _segmentControl = [[UISegmentedControl alloc] initWithItems:@[@"Active", @"All", @"Completed"]];
        self.segmentControl.selectedSegmentIndex = 0;
        [self.segmentControl setTintColor:[UIColor redColor]];
        [self.segmentControl addTarget:self action:@selector(selectedSegmentAtIndex:) forControlEvents:UIControlEventValueChanged];
    }
    
    return _segmentControl;
}

- (UITableView *)listEventTableview {
    if (!_listEventTableview) {
        _listEventTableview = [[UITableView alloc] initForAutoLayout];
        _listEventTableview.backgroundColor = [UIColor whiteColor];
        _listEventTableview.delegate = self;
        _listEventTableview.dataSource = self;
        _listEventTableview.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    
    return _listEventTableview;
}

#pragma mark - Tableview datasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (currentSegment == LIST_REMINDER_TYPE_ACTIVE) {
        return self.service.listReminderActive.count;
    }
    else if (currentSegment == LIST_REMINDER_TYPE_ALL) {
        return self.service.listReminderAll.count;
    }
    else {
        return self.service.listReminderCompleted.count;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([VRReminderListCell class]) forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.isEditMode) {
        [cell showLeftUtilityButtonsAnimated:YES];
    }

    VRReminderModel *model;
    if (currentSegment == LIST_REMINDER_TYPE_ACTIVE) {
        model = [self.service.listReminderActive objectAtIndex:indexPath.row];
    }
    else if (currentSegment == LIST_REMINDER_TYPE_ALL) {
        model = [self.service.listReminderAll objectAtIndex:indexPath.row];
    }
    else {
        model = [self.service.listReminderCompleted objectAtIndex:indexPath.row];
    }
    
    cell.leftUtilityButtons = [self leftButton];
    cell.name.text = model.name;
    cell.timeReminder.text = model.timeReminder;
    
    if (model.completed) {
        [cell.switchButton setOn:NO];
        cell.switchButton.userInteractionEnabled = NO;
    }
    else {
        [cell.switchButton setOn:model.isActive];
        cell.switchButton.userInteractionEnabled = YES;
    }
    
    __weak typeof (self)weak = self;
    cell.changeSwitch = ^(id sender) {
        [weak updateStatusFor:model CompletionHandler:^(NSError *error, id result) {
            if (currentSegment == LIST_REMINDER_TYPE_ACTIVE) {
                [self.service.listReminderActive replaceObjectAtIndex:indexPath.row withObject:result];
            }
            else if (currentSegment == LIST_REMINDER_TYPE_ALL) {
                [self.service.listReminderAll replaceObjectAtIndex:indexPath.row withObject:result];
            }
            else {
                [self.service.listReminderCompleted replaceObjectAtIndex:indexPath.row withObject:result];
            }
            
            [weak.listEventTableview reloadData];
        }];
    };
    
    [cell layoutSubviews];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderDetailController *vc = [[VRReminderDetailController alloc] initWithNibName:NSStringFromClass([VRReminderDetailController class]) bundle:nil];
    VRReminderModel *model;
    if (currentSegment == LIST_REMINDER_TYPE_ACTIVE) {
        model = [self.service.listReminderActive objectAtIndex:indexPath.row];
    }
    else if (currentSegment == LIST_REMINDER_TYPE_ALL) {
        model = [self.service.listReminderAll objectAtIndex:indexPath.row];
    }
    else {
        model = [self.service.listReminderCompleted objectAtIndex:indexPath.row];
    }
    
    vc.model = model;
    [self.rootViewController.navigationController pushViewController:vc animated:YES];
}

#pragma mark - action swipe cell
- (NSArray *)leftButton{
    NSMutableArray *leftUtilityButtons = [NSMutableArray new];
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:34.0f/255.0f green:38.0f/255.0f blue:41.0f/255.0f alpha:1] icon:[UIImage imageNamed:kImageEditBlue]];
    [leftUtilityButtons sw_addUtilityButtonWithColor:[UIColor colorWithRed:45.0f/255.0f green:50.0f/255.0f blue:53.0f/255.0f alpha:1] icon:[UIImage imageNamed:kImageDeleteBlue]];
    return leftUtilityButtons;
}

- (void)swipeableTableViewCell:(SWTableViewCell *)cell didTriggerLeftUtilityButtonWithIndex:(NSInteger)index {
    NSIndexPath *indexPath = [self.listEventTableview indexPathForCell:cell];
    switch (index) {
        case 0:
            [self editAtIndexPath:indexPath];
            break;
        case 1:
            [self deleteAtIndexPath:indexPath];
            break;
        default:
            break;
    }
    
    [cell hideUtilityButtonsAnimated:YES];
}

- (void)editAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderModel *model;
    if (currentSegment == LIST_REMINDER_TYPE_ACTIVE) {
        model = [self.service.listReminderActive objectAtIndex:indexPath.row];
    }
    else if (currentSegment == LIST_REMINDER_TYPE_ALL) {
        model = [self.service.listReminderAll objectAtIndex:indexPath.row];
    }
    else {
        model = [self.service.listReminderCompleted objectAtIndex:indexPath.row];
    }
    
    VRReminderSettingViewController *vc = [[VRReminderSettingViewController alloc] initWithUUID:model.uuid];
    vc.isEditMode = YES;
    
    __weak typeof (self)weak = self;
    vc.editCompleted = ^(id object) {
        if (currentSegment == LIST_REMINDER_TYPE_ACTIVE) {
            [self.service.listReminderActive replaceObjectAtIndex:indexPath.row withObject:object];
        }
        else if (currentSegment == LIST_REMINDER_TYPE_ALL) {
            [self.service.listReminderAll replaceObjectAtIndex:indexPath.row withObject:object];
        }
        else {
            [self.service.listReminderCompleted replaceObjectAtIndex:indexPath.row withObject:object];
        }
        
        [weak.listEventTableview reloadData];
    };
    
    [self.rootViewController.navigationController pushViewController:vc animated:YES];
}

- (void)deleteAtIndexPath:(NSIndexPath *)indexPath {
    VRReminderModel *model;
    if (currentSegment == LIST_REMINDER_TYPE_ACTIVE) {
        model = [self.service.listReminderActive objectAtIndex:indexPath.row];
    }
    else if (currentSegment == LIST_REMINDER_TYPE_ALL) {
        model = [self.service.listReminderAll objectAtIndex:indexPath.row];
    }
    else {
        model = [self.service.listReminderCompleted objectAtIndex:indexPath.row];
    }
    
    if (!self.service) {
        self.service = [[VRReminderListService alloc] init];
    }
    
    [self.service deleteReminderWithUUID:model.uuid completionHandler:^(NSError *error, id result) {
        if (!error) {
            if (currentSegment == LIST_REMINDER_TYPE_ACTIVE) {
                [self.service.listReminderActive removeObjectAtIndex:indexPath.row];
            }
            else if (currentSegment == LIST_REMINDER_TYPE_ALL) {
                [self.service.listReminderAll removeObjectAtIndex:indexPath.row];
            }
            else {
                [self.service.listReminderCompleted removeObjectAtIndex:indexPath.row];
            }
            
            [self.listEventTableview reloadData];
        }
    }];
}


#pragma mark - tableview delegate

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 55;
}
#pragma mark - actions

- (void)selectedSegmentAtIndex:(UISegmentedControl *)segment {
    switch (segment.selectedSegmentIndex) {
        case LIST_REMINDER_TYPE_ACTIVE:
            currentSegment = LIST_REMINDER_TYPE_ACTIVE;
            break;
        case LIST_REMINDER_TYPE_ALL:
            currentSegment = LIST_REMINDER_TYPE_ALL;
            break;
        case LIST_REMINDER_TYPE_COMPLETED:
            currentSegment = LIST_REMINDER_TYPE_COMPLETED;
            break;
        default:
            break;
    }
    
    self.isEditMode = NO;
    [self.listEventTableview reloadData];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}

#pragma mark - List reminder 
- (void)editAction {
    self.isEditMode = !self.isEditMode;
    [self.listEventTableview reloadData];
}

- (void)doneAction {
    self.isEditMode = !self.isEditMode;
    [self.listEventTableview reloadData];
}
@end
