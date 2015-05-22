//
//  VRPhotoListCell.h
//  VoiceReminder
//
//  Created by GemCompany on 4/4/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VRPhotoListCell : UITableViewCell
@property (assign, nonatomic, getter=isEditingMode) BOOL editingMode;
@property (weak, nonatomic) NSArray * photoList;
@property (copy, nonatomic) void(^didDeleteCompletionBlock)(NSInteger index);
@property (copy, nonatomic) void(^didSelectImage)(NSInteger index);
+ (NSInteger)height;
@end
