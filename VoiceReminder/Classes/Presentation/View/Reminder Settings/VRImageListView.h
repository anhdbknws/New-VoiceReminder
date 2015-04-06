//
//  VRImageListView.h
//  VoiceReminder
//
//  Created by GemCompany on 4/4/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, ImageListViewScrollIndicator) {
    ImageListViewHorizontalScrollIndicator = 0,
    ImageListViewVerticalScrollIndicator = 1
};

@interface VRImageListView : UIView
@property (nonatomic, assign) NSInteger height;
@property (nonatomic, assign) NSInteger width;
@property (nonatomic, assign, getter = isEditingMode) BOOL editingMode;
@property (nonatomic, strong) NSArray *resource;
@property (nonatomic, assign) ImageListViewScrollIndicator scrollIndicatortype;
@property (copy, nonatomic) void(^deleteRowBlock)(NSInteger index);
@property (copy, nonatomic) void(^didDeleteCompletionHandler)(NSInteger index);
@property (copy, nonatomic) void(^didSelectImage)(NSInteger index);
- (void)deleteRowAtIndex:(NSInteger)index;
@end
