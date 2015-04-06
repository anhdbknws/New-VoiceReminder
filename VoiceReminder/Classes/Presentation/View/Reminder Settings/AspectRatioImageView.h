//
//  AspectRatioImageView.h
//  DynamicScrollView
//
//  Created by NguyenLeDuan on 8/28/14.
//  Copyright (c) 2014 QSoft Vietnam. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AspectRatioImageView : UIImageView
@property (strong, nonatomic) NSLayoutConstraint * constaintOfHeight;
@property (strong, nonatomic) NSLayoutConstraint * constraintOfWidth;
- (void)setImageWithUrl:(NSString *)urlStr;
@end
