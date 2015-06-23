//
//  VRPopupViewController.m
//  VoiceReminder
//
//  Created by Điệp Nguyễn on 6/23/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRPopupViewController.h"
#import "VRPhotoListCell.h"
#import "VRPhotoPageController.h"
#import "VRSettingNotesCell.h"
#import "UIPlaceHolderTextView.h"

@interface VRPopupViewController () <UITableViewDataSource, UITableViewDelegate, UITextViewDelegate>
@property (nonatomic, strong) UIPlaceHolderTextView * noteTextView;
@end

@implementation VRPopupViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.labelDate.text = @"23/06/2015";
    self.labelDate.font = VRFontRegular(17);
    
    self.labelName.text = @"Diepnn";
    self.labelName.font = VRFontRegular(17);
    
    [self setupTableView];
}

- (void)setupTableView {
    self.tableviewPopup.delegate = self;
    self.tableviewPopup.dataSource = self;
    
    [self.tableviewPopup registerClass:[VRPhotoListCell class] forCellReuseIdentifier:NSStringFromClass([VRPhotoListCell class])];
    [self.tableviewPopup registerNib:[UINib nibWithNibName:NSStringFromClass([VRSettingNotesCell class]) bundle:nil] forCellReuseIdentifier:NSStringFromClass([VRSettingNotesCell class])];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    return [self getPhotoCell];
}

- (VRPhotoListCell *)getPhotoCell {
    VRPhotoListCell * cell = [self.tableviewPopup dequeueReusableCellWithIdentifier:NSStringFromClass([VRPhotoListCell class])];
    cell.photoList = _model.photoList;
    __weak typeof(self)weak = self;
    cell.didSelectImage = ^(NSInteger index) {
        [weak showPhotoPageControllerAtIndex:index];
    };
    
    return cell;
}

- (VRSettingNotesCell *)getNotesCell {
    VRSettingNotesCell *cell = [self.tableviewPopup dequeueReusableCellWithIdentifier:NSStringFromClass([VRSettingNotesCell class])];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.labelTitle.text = @"Notes:";
    cell.textViewNotes.delegate = self;
    _noteTextView = (UIPlaceHolderTextView*)cell.textViewNotes;

    cell.textViewNotes.text = self.model.notes;
    cell.textViewNotes.font = VRFontRegular(15);
    cell.arrowView.hidden = YES;
    cell.textViewNotes.editable = NO;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 1) {
        return MAX(44, [self caculateHeightOfTextView]);
    }
    else {
        if (_model.photoList.count) {
            return 115;
        }
        else {
            return 0;
        }
    }
}

- (CGFloat)caculateHeightOfTextView {
    UIPlaceHolderTextView *calculationView = _noteTextView;
    if (!calculationView) {
        calculationView = [[UIPlaceHolderTextView alloc] init];
        calculationView.font = H6_FONT;
        calculationView.contentInset = UIEdgeInsetsMake(1, -2, 0, 0);
        calculationView.textContainer.maximumNumberOfLines = 0;
        calculationView.text = self.model.notes;
        CGRect frame = calculationView.frame;
        frame.size.width = self.tableviewPopup.bounds.size.width - 42 - 10;
        calculationView.frame = frame;
    }
    CGFloat textViewWidth = calculationView.frame.size.width;
    CGSize size = [calculationView sizeThatFits:CGSizeMake(textViewWidth, FLT_MAX)];
    return size.height + 10;
}

- (void)showPhotoPageControllerAtIndex:(NSInteger)index
{
    VRPhotoPageController * photoPageController = [[VRPhotoPageController alloc] initWithPhotos:_model.photoList];
    [photoPageController setPageIndex:index];
    UINavigationController * navController = [[UINavigationController alloc] initWithRootViewController:photoPageController];
    [self.navigationController presentViewController:navController animated:YES completion:NULL];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)actionExit:(id)sender {
}

- (IBAction)actionDetail:(id)sender {
}
@end
