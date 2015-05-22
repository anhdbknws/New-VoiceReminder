//
//  VCPhotoListCell.h
//  Vaccinations
//
//  Created by Nguyen Le Duan on 12/25/14.
//  Copyright (c) 2014 Gem Vietnam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VCPhotoListCell : UITableViewCell
@property (assign, nonatomic, getter=isEditingMode) BOOL editingMode;
@property (weak, nonatomic) NSArray * photoList;
@property (copy, nonatomic) void(^didDeleteCompletionBlock)(NSInteger index);
@property (copy, nonatomic) void(^didSelectImage)(NSInteger index);
+ (NSInteger)height;
@end
