//
//  VCImageListView.m
//  Vaccinations
//
//  Created by Nguyen Le Duan on 12/25/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import "VCImageListView.h"
#import <PureLayout.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import "AspectRatioImageView.h"
#import "VCAssetAccessory.h"
#import "VCMacro.h"
#import "VCPhotoContentView.h"

const NSInteger kImageViewTag = 9353;
const NSInteger kDeleteButtonTag = 3921;
const NSInteger widthOfDeleteButton = 38;

@interface VCImageListView ()
@property (strong, nonatomic) UIScrollView * scrollView;
@property (strong, nonatomic) NSMutableArray * subViews;
@property (strong, nonatomic) NSMutableArray * constraints;
@end

@implementation VCImageListView
- (instancetype)init
{
    self = [super init];
    if (self) {
        _scrollView = [[UIScrollView alloc] initForAutoLayout];
        [self addSubview:_scrollView];
        
        [_scrollView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [_scrollView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [_scrollView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [_scrollView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    }
    return self;
}
- (void)setResource:(NSArray *)resource
{
    _resource = resource;
    
    if (_subViews.count) {
        [_subViews makeObjectsPerformSelector:@selector(removeFromSuperview)];
        [_subViews removeAllObjects];
    }
    else
        _subViews = [NSMutableArray new];
    for (id object in resource)
        @autoreleasepool {
            UIImage * image = [self imageFromResource:object];
            AspectRatioImageView * imageView = [[AspectRatioImageView alloc] initWithImage:image];
            imageView.tag = kImageViewTag;
            imageView.contentMode = UIViewContentModeScaleAspectFill;
            
            UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
            button.hidden = !self.isEditingMode;
            button.frame = CGRectMake(0, 0, widthOfDeleteButton, widthOfDeleteButton);
            button.tag = kDeleteButtonTag;
            [button setImage:[UIImage imageNamed:@"icon_delete_photo"] forState:UIControlStateNormal];
            [button addTarget:self action:@selector(deleteClicked:) forControlEvents:UIControlEventTouchUpInside];
            
            VCPhotoContentView * view = [[VCPhotoContentView alloc] initForAutoLayout];
            view.layer.borderWidth = 1;
            view.layer.borderColor = RGBCOLOR(0, 0, 0, 0.15f).CGColor;
            [view addSubview:imageView];
            [view addSubview:button];
            
            UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClicked:)];
            [view addGestureRecognizer:tap];
            
            [_scrollView addSubview:view];
            [_subViews addObject:view];
        }
    
    // autolayout subviews
    [self updateScrollViewConstraintsWithAnimated:NO];
}
- (void)updateScrollViewConstraintsWithAnimated:(BOOL)animated
{
    VCPhotoContentView * previousView;
    for (VCPhotoContentView * view in _subViews) {
        
        // 1. remove constraints
        [view removeConstraints:view.constraints];
        
        // 2. update constraint subviews
        UIImageView * imageView = (UIImageView *)[view viewWithTag:kImageViewTag];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeBottom];
        [imageView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        
        UIButton * button = (UIButton *)[view viewWithTag:kDeleteButtonTag];
        [button autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
        [button autoPinEdgeToSuperviewEdge:ALEdgeTop];
        [button autoSetDimension:ALDimensionHeight toSize:widthOfDeleteButton];
        [button autoSetDimension:ALDimensionWidth toSize:widthOfDeleteButton];
        
        // 3. add constraint to scrollview and subviews of scrollview
        if (_scrollIndicatorType == ImageListViewHorizontalScrollIndicator) {
            
            if (_subViews.firstObject == view) {
                [view autoPinEdgeToSuperviewEdge:ALEdgeLeading];
            }
            else {
                [view autoPinEdge:ALEdgeLeading toEdge:ALEdgeTrailing ofView:previousView withOffset:10];
            }
            AspectRatioImageView * imageView = (AspectRatioImageView *)[view viewWithTag:kImageViewTag];
            if (view.widthConstraint) {
                imageView.constraintOfWidth = [view autoSetDimension:ALDimensionWidth toSize:view.widthConstraint.constant];
            }
            else {
                imageView.constraintOfWidth = [view autoSetDimension:ALDimensionWidth toSize:1];
            }
            view.widthConstraint = imageView.constraintOfWidth;
            
            [view autoPinEdgeToSuperviewEdge:ALEdgeTop];
            [view autoSetDimension:ALDimensionHeight toSize:self.height];
            previousView = view;
        }
    }
    VCPhotoContentView * lastView = ((VCPhotoContentView *)_subViews.lastObject);
    [lastView autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    if (animated) {
        [UIView animateWithDuration:0.3f delay:0 options:UIViewAnimationOptionBeginFromCurrentState animations:^{
            [_scrollView layoutIfNeeded];
        } completion:NULL];
    }
    else
        [_scrollView layoutIfNeeded];
}
- (UIImage *)imageFromResource:(id)resource
{
    UIImage * image;
    if ([resource isKindOfClass:[ALAsset class]]) {
        image = [UIImage imageWithCGImage:((ALAsset *)resource).thumbnail];
    }
    else if ([resource isKindOfClass:[NSString class]]) {
        image = [VCAssetAccessory getImageThumnailWithName:resource];
    }
    else
        image = (UIImage *)resource;
    return image;
}
- (void)deleteClicked:(id)sender
{
    UIView * view = [sender superview];
    NSInteger index = [_subViews indexOfObject:view];
    if (self.deleteRowBlock) {
        self.deleteRowBlock(index);
    }
    else {
        [self deleteRowAtIndex:index];
    }
}
- (void)deleteRowAtIndex:(NSInteger)index
{
    VCPhotoContentView * view = [_subViews objectAtIndex:index];
    [self removeSubView:view];
    [self updateScrollViewConstraintsWithAnimated:YES];
    if (self.didDeleteCompletionHandler) {
        self.didDeleteCompletionHandler(index);
    }
}
- (void)setEditingMode:(BOOL)editingMode
{
    _editingMode = editingMode;
    for (VCPhotoContentView * view in _subViews) {
        UIButton * deleteButton = (UIButton *)[view viewWithTag:kDeleteButtonTag];
        deleteButton.hidden = !editingMode;
    }
}
- (void)removeSubView:(UIView *)view {
    [view removeFromSuperview];
    [_subViews removeObject:view];
}
- (NSInteger)height
{
    if (!_height) {
        _height = 99;
    }
    return _height;
}
- (void)tapClicked:(UIGestureRecognizer *)ges
{
    if (self.didSelectImage) {
        self.didSelectImage([_subViews indexOfObject:ges.view]);
    }
}
@end
