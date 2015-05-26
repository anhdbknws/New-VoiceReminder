//
//  VRAlertView.m
//  VoiceReminder
//
//  Created by GemCompany on 4/10/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRAlertView.h"
static NSTimeInterval const kAnimationDuration = 1.0;
@implementation VRAlertView
- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self initView];
    }
    
    return self;
}

- (void)initView {
    [self addSubview:self.imageView];
    
    /* layout */
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [_imageView autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    [_imageView autoCenterInSuperview];
    [_imageView autoSetDimension:ALDimensionWidth toSize:self.frame.size.height];
}

- (UIImageView *)imageView {
    if (!_imageView) {
        _imageView = [[UIImageView alloc] initForAutoLayout];
        _imageView.layer.cornerRadius = _imageView.frame.size.width/2;
        _imageView.layer.borderWidth = 2.0f;
        _imageView.layer.borderColor = [UIColor blackColor].CGColor;
        _imageView.clipsToBounds = YES;
    }
    
    return _imageView;
}

#pragma mark - animation
- (void)animation {
    self.imageView.animationImages = nil;
    self.imageView.animationDuration = kAnimationDuration;
    self.imageView.animationRepeatCount  = 1;
    [self.imageView startAnimating];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, kAnimationDuration * NSEC_PER_SEC), dispatch_get_main_queue(), ^
                   {
                       [self stopAnimateImages];
                   });
}


- (void)stopAnimateImages
{
    [self.imageView stopAnimating];
    self.imageView.image = [self.imageView.animationImages lastObject];
    self.imageView.animationImages = nil;
}

#pragma mark - CreateImagesArray

- (NSArray *)createImagesArray
{
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index <= 16; index++)
    {
        NSString *imageName = [NSString stringWithFormat:@"frame_%03ld.png", (long)index];
        
        NSString *path = [[NSBundle mainBundle] pathForResource:imageName
                                                         ofType:nil];
        
        // Allocating images with imageWithContentsOfFile makes images to do not cache.
        UIImage *image = [UIImage imageWithContentsOfFile:path];
        
        [array addObject:image];
    }
    
    return array;
}
@end
