//
//  VCImageListView.h
//  Vaccinations
//
//  Created by Nguyen Le Duan on 12/25/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageListViewScrollIndicator) {
    ImageListViewHorizontalScrollIndicator = 0,
    ImageListViewVerticalScrollIndicator = 1
};

@interface VCImageListView : UIView
@property (assign, nonatomic) NSInteger height; // for horizontal
@property (assign, nonatomic) NSInteger width; // for vertical
@property (assign, nonatomic, getter=isEditingMode) BOOL editingMode;
@property (strong, nonatomic) NSArray * resource;
@property (assign, nonatomic) ImageListViewScrollIndicator scrollIndicatorType;
@property (copy, nonatomic) void(^deleteRowBlock)(NSInteger index);
@property (copy, nonatomic) void(^didDeleteCompletionHandler)(NSInteger index);
@property (copy, nonatomic) void(^didSelectImage)(NSInteger index);
- (void)deleteRowAtIndex:(NSInteger)index;
@end
