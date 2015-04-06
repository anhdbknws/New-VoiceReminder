//
//  VCPhotoListCell.m
//  Vaccinations
//
//  Created by Nguyen Le Duan on 12/25/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import "VCPhotoListCell.h"
#import "VCImageListView.h"
#import <PureLayout.h>
#import "VCLineDash.h"

@interface VCPhotoListCell ()
@property (strong, nonatomic) VCImageListView * listView;
@property (strong, nonatomic) VCLineDash * lineDash;
@end

@implementation VCPhotoListCell
- (void)layoutSubviews
{
    [super layoutSubviews];
    _listView.didDeleteCompletionHandler = self.didDeleteCompletionBlock;
    _listView.didSelectImage = self.didSelectImage;
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}
- (void)setPhotoList:(NSArray *)photoList
{
    _photoList = photoList;
    CGFloat height = 99;
    if (!_listView) {
        _listView = [[VCImageListView alloc] initForAutoLayout];
        [self.contentView addSubview:_listView];
        
        _lineDash = [[VCLineDash alloc] initForAutoLayout];
        [self.contentView addSubview:_lineDash];
        
        [_listView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [_listView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [_listView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:10];
        [_listView autoSetDimension:ALDimensionHeight toSize:height];
        
        [_lineDash autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [_lineDash autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [_lineDash autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_lineDash autoSetDimension:ALDimensionHeight toSize:1];
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
