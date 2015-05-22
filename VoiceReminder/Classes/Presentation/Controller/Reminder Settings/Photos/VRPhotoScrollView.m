//
//  VRPhotoScrollView.m
//  VoiceReminder
//
//  Created by GemCompany on 4/5/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRPhotoScrollView.h"

NSString * const VRPhotoScrollViewTappedNotification = @"VCPhotoScrollViewTappedNotification";
@interface VRPhotoScrollView ()<UIScrollViewDelegate>
@property (nonatomic, strong) UIImageView   *imageView;
@property (nonatomic, assign) CGSize        imageSize;

@property (nonatomic, assign) CGPoint       pointToCenterAfterResize;
@property (nonatomic, assign) CGFloat       scaleToRestoreAfterResize;
@end
@implementation VRPhotoScrollView
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self)
    {
        self.showsVerticalScrollIndicator   = NO;
        self.showsHorizontalScrollIndicator = NO;
        self.bouncesZoom                    = YES;
        self.decelerationRate               = UIScrollViewDecelerationRateFast;
        self.delegate                       = self;
        self.backgroundColor = [UIColor clearColor];
    }
    
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    // center the zoom view as it becomes smaller than the size of the screen
    CGSize boundsSize       = self.bounds.size;
    CGRect frameToCenter    = self.imageView.frame;
    
    // center horizontally
    if (frameToCenter.size.width < boundsSize.width)
        frameToCenter.origin.x = (boundsSize.width - frameToCenter.size.width) / 2;
    else
        frameToCenter.origin.x = 0;
    
    // center vertically
    if (frameToCenter.size.height < boundsSize.height)
        frameToCenter.origin.y = (boundsSize.height - frameToCenter.size.height) / 2;
    else
        frameToCenter.origin.y = 0;
    
    self.imageView.frame    = frameToCenter;
}

- (void)setIndex:(NSUInteger)index
{
    _index = index;
    [self displayImageAtIndex:index];
    [self addGestureRecognizers];
}

- (void)setFrame:(CGRect)frame
{
    BOOL sizeChanging = !CGSizeEqualToSize(frame.size, self.frame.size);
    
    if (sizeChanging)
        [self prepareToResize];
    
    [super setFrame:frame];
    
    if (sizeChanging)
        [self recoverFromResizing];
}


#pragma mark - UIScrollViewDelegate

- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView
{
    return self.imageView;
}



#pragma mark - Configure scrollView to display new image

- (void)displayImageAtIndex:(NSUInteger)index
{
    if ([self.dataSource respondsToSelector:@selector(photoAtIndex:)])
    {
        // scale image properly
        UIImage *image = [self.dataSource photoAtIndex:index];
        
        // clear the previous image
        [self.imageView removeFromSuperview];
        self.imageView = nil;
        
        // reset our zoomScale to 1.0 before doing any further calculations
        self.zoomScale = 1.0;
        
        // make a new UIImageView for the new image
        self.imageView = [[UIImageView alloc] initWithImage:image];
        
        self.imageView.isAccessibilityElement   = YES;
        self.imageView.accessibilityTraits      = UIAccessibilityTraitImage;
        //self.imageView.accessibilityLabel       = asset.accessibilityLabel;
        self.imageView.tag                      = 1;
        
        [self addSubview:self.imageView];
        [self configureForImageSize:image.size];
    }
}


- (void)configureForImageSize:(CGSize)imageSize
{
    self.imageSize      = imageSize;
    self.contentSize    = imageSize;
    
    [self setMaxMinZoomScalesForCurrentBounds];
    
    self.zoomScale      = self.minimumZoomScale;
}

- (void)setMaxMinZoomScalesForCurrentBounds
{
    CGSize boundsSize = self.bounds.size;
    
    CGFloat xScale = boundsSize.width  / self.imageSize.width;    // the scale needed to perfectly fit the image width-wise
    CGFloat yScale = boundsSize.height / self.imageSize.height;   // the scale needed to perfectly fit the image height-wise
    
    CGFloat minScale = MIN(xScale, yScale);
    CGFloat maxScale = 2.0 * minScale;
    
    self.minimumZoomScale = minScale;
    self.maximumZoomScale = maxScale;
}



#pragma mark - Rotation support

- (void)prepareToResize
{
    CGPoint boundsCenter = CGPointMake(CGRectGetMidX(self.bounds), CGRectGetMidY(self.bounds));
    self.pointToCenterAfterResize = [self convertPoint:boundsCenter toView:self.imageView];
    
    self.scaleToRestoreAfterResize = self.zoomScale;
    
    // If we're at the minimum zoom scale, preserve that by returning 0, which will be converted to the minimum
    // allowable scale when the scale is restored.
    if (self.scaleToRestoreAfterResize <= self.minimumZoomScale + FLT_EPSILON)
        self.scaleToRestoreAfterResize = 0;
}

- (void)recoverFromResizing
{
    [self setMaxMinZoomScalesForCurrentBounds];
    
    // Step 1: restore zoom scale, first making sure it is within the allowable range.
    self.zoomScale = MIN(self.maximumZoomScale, MAX(self.minimumZoomScale, self.scaleToRestoreAfterResize));
    
    
    // Step 2: restore center point, first making sure it is within the allowable range.
    
    // 2a: convert our desired center point back to our own coordinate space
    CGPoint boundsCenter = [self convertPoint:self.pointToCenterAfterResize fromView:self.imageView];
    
    // 2b: calculate the content offset that would yield that center point
    CGPoint offset = CGPointMake(boundsCenter.x - self.bounds.size.width / 2.0,
                                 boundsCenter.y - self.bounds.size.height / 2.0);
    
    // 2c: restore offset, adjusted to be within the allowable range
    CGPoint maxOffset = [self maximumContentOffset];
    CGPoint minOffset = [self minimumContentOffset];
    offset.x = MAX(minOffset.x, MIN(maxOffset.x, offset.x));
    offset.y = MAX(minOffset.y, MIN(maxOffset.y, offset.y));
    self.contentOffset = offset;
}

- (CGPoint)maximumContentOffset
{
    CGSize contentSize = self.contentSize;
    CGSize boundsSize = self.bounds.size;
    return CGPointMake(contentSize.width - boundsSize.width, contentSize.height - boundsSize.height);
}

- (CGPoint)minimumContentOffset
{
    return CGPointZero;
}



#pragma mark - Gesture Recognizer

- (void)addGestureRecognizers
{
    UITapGestureRecognizer *singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapping:)];
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleTapping:)];
    
    [doubleTap setNumberOfTapsRequired:2.0];
    [singleTap requireGestureRecognizerToFail:doubleTap];
    
    [self addGestureRecognizer:singleTap];
    [self addGestureRecognizer:doubleTap];
}



#pragma mark - Handle Tapping

- (void)handleTapping:(UITapGestureRecognizer *)recognizer
{
    [[NSNotificationCenter defaultCenter] postNotificationName:VRPhotoScrollViewTappedNotification object:recognizer];
    
    if (recognizer.numberOfTapsRequired == 2)
        [self toggleZooming:recognizer];
}



#pragma mark - Toggle Zooming

- (void)toggleZooming:(UITapGestureRecognizer *)recognizer
{
    if (self.minimumZoomScale == self.maximumZoomScale)
    {
        return;
    }
    else if (self.zoomScale > self.minimumZoomScale)
    {
        [self setZoomScale:self.minimumZoomScale animated:YES];
    }
    else
    {
        CGRect zoomRect =
        [self zoomRectWithScale:self.maximumZoomScale
                     withCenter:[recognizer locationInView:recognizer.view]];
        
        [self zoomToRect:zoomRect animated:YES];
    }
}

- (CGRect)zoomRectWithScale:(float)scale withCenter:(CGPoint)center {
    
    CGRect zoomRect;
    
    zoomRect.size.height = [self.imageView frame].size.height / scale;
    zoomRect.size.width  = [self.imageView frame].size.width  / scale;
    
    center = [self.imageView convertPoint:center fromView:self];
    
    zoomRect.origin.x    = center.x - ((zoomRect.size.width / 2.0));
    zoomRect.origin.y    = center.y - ((zoomRect.size.height / 2.0));
    
    return zoomRect;
}
@end
