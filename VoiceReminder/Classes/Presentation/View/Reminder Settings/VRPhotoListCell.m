//
//  VRPhotoListCell.m
//  VoiceReminder
//
//  Created by GemCompany on 4/4/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRPhotoListCell.h"
#import "VRImageListView.h"

@interface VRPhotoListCell ()
@property (nonatomic, strong) VRImageListView *listView;
@property (nonatomic, strong) UIView *bottomLine;
@end

@implementation VRPhotoListCell

- (void)layoutSubviews {
    [super layoutSubviews];
    _listView.didDeleteCompletionHandler = self.didDeleteCompletionBlock;
    _listView.didSelectImage = self.didSelectImage;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setPhotoList:(NSArray *)photoList {
    _photoList = photoList;
    CGFloat height = 99;
    if (!_listView) {
        _listView = [[VRImageListView alloc] initForAutoLayout];
        [self.contentView addSubview:_listView];
        
        _bottomLine = [[UIView alloc] initForAutoLayout];
        [self.contentView addSubview:_bottomLine];
        
        [_listView autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:10];
        [_listView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [_listView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [_listView autoSetDimension:ALDimensionHeight toSize:height];
        
        [_bottomLine autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [_bottomLine autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [_bottomLine autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_bottomLine autoSetDimension:ALDimensionHeight toSize:1];
    }
    _listView.height = height;
    if (![self photoListEqual:_listView.resource]) {
        _listView.resource = [photoList copy];
    }
}

- (BOOL)photoListEqual:(NSArray *)resource
{
    if (resource.count != _photoList.count) {
        return NO;
    }
    BOOL isEqual = YES;
    for (id object in resource) {
        id object1 = _photoList[[resource indexOfObject:object]];
        if ([object isKindOfClass:[NSString class]]) {
            NSString * objectStr = object;
            NSString * object1Str = object1;
            isEqual = [objectStr isEqualToString:object1Str];
        }
        if (!isEqual) {
            break;
        }
    }
    return isEqual;
}

- (void)setEditingMode:(BOOL)editingMode
{
    _editingMode = editingMode;
    _listView.editingMode = editingMode;
}
+ (NSInteger)height
{
    return 120;
}

@end
