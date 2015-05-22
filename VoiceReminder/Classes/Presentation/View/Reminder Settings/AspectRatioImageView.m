//
//  AspectRatioImageView.m
//  DynamicScrollView
//
//  Created by NguyenLeDuan on 8/28/14.
//  Copyright (c) 2014 QSoft Vietnam. All rights reserved.
//

#import "AspectRatioImageView.h"
#import "UIImageView+AFNetworking.h"
#import "PureLayout.h"

@implementation AspectRatioImageView

- (void)setImageWithUrl:(NSString *)urlStr
{
    __weak typeof(self)weak = self;
    [self setImageWithURLRequest:[NSURLRequest requestWithURL:[NSURL URLWithString:urlStr]] placeholderImage:Nil success:^(NSURLRequest *request, NSHTTPURLResponse *response, UIImage *image) {
        __weak typeof(weak)strong = weak;
        if (strong.constaintOfHeight) {
            float ratio = strong.bounds.size.width/image.size.width;
            float scaledHeight = image.size.height * ratio;
            strong.constaintOfHeight.constant = scaledHeight;
        }
        else {
            float ratio = strong.bounds.size.height/image.size.height;
            float scaledWidth = image.size.width * ratio;
            strong.constraintOfWidth.constant = scaledWidth;
        }
        strong.image = image;
    } failure:^(NSURLRequest *request, NSHTTPURLResponse *response, NSError *error) {
        
    }];
}
- (void)layoutSubviews
{
    UIImage * image = self.image;
    if (self.constaintOfHeight) {
        float ratio = self.superview.bounds.size.width/image.size.width;
        float scaledHeight = image.size.height * ratio;
        self.constaintOfHeight.constant = scaledHeight;
    }
    else {
        float ratio = self.superview.bounds.size.height/image.size.height;
        float scaledWidth = image.size.width * ratio;
        self.constraintOfWidth.constant = scaledWidth;
    }
    [super layoutSubviews];
}
@end
