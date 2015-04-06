/*
 CTAssetsViewController.m
 
 The MIT License (MIT)
 
 Copyright (c) 2013 Clement CN Tsang
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "CTAssetsPickerCommon.h"
#import "CTAssetsPickerController.h"
#import "CTAssetsViewController.h"
#import "CTAssetsViewCell.h"
#import "CTAssetsSupplementaryView.h"
#import "CTAssetsPageViewController.h"
#import "CTAssetsViewControllerTransition.h"
#import "CTAssetsGroupViewController.h"
#import <PureLayout.h>
#import "VCAppearanceConfig.h"
#import <WYPopoverController.h>
#import "CTAssetsPickerController.h"


NSString * const CTAssetsViewCellIdentifier = @"CTAssetsViewCellIdentifier";
NSString * const CTAssetsSupplementaryViewIdentifier = @"CTAssetsSupplementaryViewIdentifier";



@interface CTAssetsPickerController ()

- (void)finishPickingAssets:(id)sender;

- (NSString *)toolbarTitle;
- (UIView *)noAssetsView;

@end



@interface CTAssetsViewController ()

@property (nonatomic, weak) CTAssetsPickerController *picker;
@property (nonatomic, strong) NSMutableArray *assets;
@property (nonatomic, strong) WYPopoverController * popOverVC;
@end





@implementation CTAssetsViewController


- (id)init
{
    UICollectionViewFlowLayout *layout = [self collectionViewFlowLayoutOfOrientation:[UIApplication sharedApplication].statusBarOrientation];
    
    if (self = [super initWithCollectionViewLayout:layout])
    {
        
        [self.collectionView registerClass:CTAssetsViewCell.class
                forCellWithReuseIdentifier:CTAssetsViewCellIdentifier];
        
        [self.collectionView registerClass:CTAssetsSupplementaryView.class
                forSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                       withReuseIdentifier:CTAssetsSupplementaryViewIdentifier];
        
        self.preferredContentSize = CTAssetPickerPopoverContentSize;
    }
    
    [self addNotificationObserver];
    
    
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupViews];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    __weak typeof(self)weak = self;
    self.groupViewController.view.backgroundColor = [UIColor whiteColor];
    self.groupViewController.didSelectGroup = ^(ALAssetsGroup * assetsGroup){
        weak.assetsGroup = assetsGroup;
        [weak.popOverVC dismissPopoverAnimated:YES completion:^{
            [weak reloadAssets];
        }];
    };
    if (!self.picker.isSingleSelection) {
        [self addGestureRecognizer];
    }
    self.collectionView.allowsMultipleSelection = !self.picker.isSingleSelection;
    [self setupButtons];
    [self setupToolbar];
    [self setupAssets];
}

- (void)dealloc
{
    [self removeNotificationObserver];
}

#pragma mark - Actions

- (void)changeGroup:(id)sender
{
    if (!self.popOverVC) {
        NSInteger width = self.groupViewController.view.bounds.size.width;
        NSInteger maximumNumberOfRows = (self.view.bounds.size.height - self.navigationController.navigationBar.frame.size.height - [UIApplication sharedApplication].statusBarFrame.size.height)/self.groupViewController.tableView.rowHeight;
        maximumNumberOfRows = MIN(maximumNumberOfRows, [self.groupViewController.tableView numberOfRowsInSection:0]);
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            width = 400;
        }
        NSInteger height = MIN(maximumNumberOfRows, 5) * self.groupViewController.tableView.rowHeight;
        
        [self.groupViewController setPreferredContentSize:CGSizeMake(width, height)];
        self.popOverVC = [[WYPopoverController alloc] initWithContentViewController:self.groupViewController];
    }
    [self.popOverVC presentPopoverFromRect:[sender bounds] inView:sender permittedArrowDirections:WYPopoverArrowDirectionUp animated:YES options:WYPopoverAnimationOptionFadeWithScale];
}

#pragma mark - Accessors

- (CTAssetsPickerController *)picker
{
    return (CTAssetsPickerController *)self.groupViewController.picker;
}


#pragma mark - Rotation

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    UICollectionViewFlowLayout *layout = [self collectionViewFlowLayoutOfOrientation:toInterfaceOrientation];
    [self.collectionView setCollectionViewLayout:layout animated:YES];
}


#pragma mark - Setup

- (void)setupViews
{
    self.view.backgroundColor = [UIColor blackColor];
    self.collectionView.backgroundColor = [UIColor clearColor];
    self.collectionView.alwaysBounceVertical = YES;
}

- (void)setupButtons
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:[VCAppearanceConfig sharedConfig].cancelAssetPickerImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self.picker action:@selector(finishPickingAssets:)];
    if (!self.picker.isSingleSelection) {
        self.navigationItem.rightBarButtonItem =
        [[UIBarButtonItem alloc] initWithImage:[[UIImage imageNamed:[VCAppearanceConfig sharedConfig].doneAssetPickerImageName] imageWithRenderingMode:UIImageRenderingModeAlwaysOriginal] style:UIBarButtonItemStylePlain target:self.picker action:@selector(finishPickingAssets:)];
        
        if (self.picker.alwaysEnableDoneButton)
            self.navigationItem.rightBarButtonItem.enabled = YES;
        else
            self.navigationItem.rightBarButtonItem.enabled = (self.picker.selectedAssets.count > 0);
    }
}

- (void)setupToolbar
{
    self.toolbarItems = self.picker.toolbarItems;
}

- (void)configureTitleViewWithGroupName:(NSString *)name
{
    UIView * titleView = [UIView new];
    UILabel * prefixTitle;
    if ([VCAppearanceConfig sharedConfig].prefixAssetsPickerTitle.length > 0) {
        prefixTitle = [UILabel new];
        prefixTitle.text = [VCAppearanceConfig sharedConfig].prefixAssetsPickerTitle;
        prefixTitle.font = [VCAppearanceConfig sharedConfig].prefixAssetPickerTitleFont;
        prefixTitle.textColor = [VCAppearanceConfig sharedConfig].prefixAssetPickerTitleColor;
        [prefixTitle sizeToFit];
        [titleView addSubview:prefixTitle];
        
        [prefixTitle autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:2];
        [prefixTitle autoAlignAxisToSuperviewAxis:ALAxisVertical];
    }
    // arrow
    UIImageView * arrow = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[VCAppearanceConfig sharedConfig].assetPickerArrowDownImageName]];
    arrow.tintColor = [UIColor whiteColor];
    [titleView addSubview:arrow];
    
    [arrow autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [arrow autoSetDimension:ALDimensionWidth toSize:arrow.bounds.size.width];
    if (prefixTitle) {
        [arrow autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:prefixTitle withOffset:8];
    }
    else
        [arrow autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
    
    UILabel * groupNameTitle;
    if (name.length > 0) {
        // group name
        groupNameTitle = [UILabel new];
        groupNameTitle.text = name;
        groupNameTitle.font = [VCAppearanceConfig sharedConfig].assetPickerTitleFont;
        groupNameTitle.textColor = [VCAppearanceConfig sharedConfig].assetPickerTitleColor;
        [groupNameTitle sizeToFit];
        
        [titleView addSubview:groupNameTitle];
        
        // autolayout
        [groupNameTitle autoPinEdgeToSuperviewEdge:ALEdgeLeading];
        
        [groupNameTitle autoPinEdge:ALEdgeTrailing toEdge:ALEdgeLeading ofView:arrow withOffset:5];
        [@[groupNameTitle, arrow] autoAlignViewsToAxis:ALAxisHorizontal];
    }
    
    // hidden button
    UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
    [btn addTarget:self action:@selector(changeGroup:) forControlEvents:UIControlEventTouchUpInside];
    [titleView addSubview:btn];
    
    [btn autoPinEdgeToSuperviewEdge:ALEdgeLeading];
    [btn autoPinEdgeToSuperviewEdge:ALEdgeTrailing];
    [btn autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [btn autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    
    // correct titleView frame
    CGRect frame = titleView.frame;
    frame.size.width = MAX(prefixTitle.bounds.size.width, groupNameTitle.bounds.size.width + 5 + arrow.bounds.size.width);
    frame.size.height = 44;
    titleView.frame = frame;
    
    [titleView layoutIfNeeded];
    
    self.navigationItem.titleView = titleView;
}

- (void)setupAssets
{
    if (!self.assets)
        self.assets = [[NSMutableArray alloc] init];
    else
        return;
    if (self.assetsGroup) {
        [self configureTitleViewWithGroupName:[self.assetsGroup valueForProperty:ALAssetsGroupPropertyName]];
    }
    else
        self.navigationItem.titleView = Nil;
    ALAssetsGroupEnumerationResultsBlock resultsBlock = ^(ALAsset *asset, NSUInteger index, BOOL *stop)
    {
        if (asset)
        {
            BOOL shouldShowAsset;
            
            if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldShowAsset:)])
                shouldShowAsset = [self.picker.delegate assetsPickerController:self.picker shouldShowAsset:asset];
            else
                shouldShowAsset = YES;
            
            if (shouldShowAsset)
                [self.assets addObject:asset];
        }
        else
        {
            [self reloadData];
        }
    };
    
    [self.assetsGroup enumerateAssetsUsingBlock:resultsBlock];
}


#pragma mark - Collection View Layout

- (UICollectionViewFlowLayout *)collectionViewFlowLayoutOfOrientation:(UIInterfaceOrientation)orientation
{
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    
    layout.itemSize             = CTAssetThumbnailSize;
    layout.footerReferenceSize  = CGSizeMake(0, 47.0);
    
    if (UIInterfaceOrientationIsLandscape(orientation) && (UI_USER_INTERFACE_IDIOM() != UIUserInterfaceIdiomPad))
    {
        layout.sectionInset            = UIEdgeInsetsMake(9.0, 2.0, 0, 2.0);
        layout.minimumInteritemSpacing = (CTIPhone6Plus) ? 1.0 : ( (CTIPhone6) ? 2.0 : 3.0 );
        layout.minimumLineSpacing      = (CTIPhone6Plus) ? 1.0 : ( (CTIPhone6) ? 2.0 : 3.0 );
    }
    else
    {
        layout.sectionInset            = UIEdgeInsetsMake(9.0, 0, 0, 0);
        layout.minimumInteritemSpacing = (CTIPhone6Plus) ? 0.5 : ( (CTIPhone6) ? 1.0 : 2.0 );
        layout.minimumLineSpacing      = (CTIPhone6Plus) ? 0.5 : ( (CTIPhone6) ? 1.0 : 2.0 );
    }
    
    return layout;
}


#pragma mark - Notifications

- (void)addNotificationObserver
{
    NSNotificationCenter *center = [NSNotificationCenter defaultCenter];
    
    [center addObserver:self
               selector:@selector(assetsLibraryChanged:)
                   name:ALAssetsLibraryChangedNotification
                 object:nil];
    
    [center addObserver:self
               selector:@selector(selectedAssetsChanged:)
                   name:CTAssetsPickerSelectedAssetsChangedNotification
                 object:nil];
}

- (void)removeNotificationObserver
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:ALAssetsLibraryChangedNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:CTAssetsPickerSelectedAssetsChangedNotification object:nil];
}


#pragma mark - Assets Library Changed

- (void)assetsLibraryChanged:(NSNotification *)notification
{
    // Reload all assets
    if (notification.userInfo == nil)
        [self performSelectorOnMainThread:@selector(reloadAssets) withObject:nil waitUntilDone:NO];
    
    // Reload effected assets groups
    if (notification.userInfo.count > 0)
        [self reloadAssetsGroupForUserInfo:notification.userInfo];
}


#pragma mark - Reload Assets Group

- (void)reloadAssetsGroupForUserInfo:(NSDictionary *)userInfo
{
    NSSet *URLs = [userInfo objectForKey:ALAssetLibraryUpdatedAssetGroupsKey];
    NSURL *URL  = [self.assetsGroup valueForProperty:ALAssetsGroupPropertyURL];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF == %@", URL];
    NSArray *matchedGroups = [URLs.allObjects filteredArrayUsingPredicate:predicate];
    
    // Reload assets if current assets group is updated
    if (matchedGroups.count > 0)
        [self performSelectorOnMainThread:@selector(reloadAssets) withObject:nil waitUntilDone:NO];
}



#pragma mark - Selected Assets Changed

- (void)selectedAssetsChanged:(NSNotification *)notification
{
    NSArray *selectedAssets = (NSArray *)notification.object;
    
    [[self.toolbarItems objectAtIndex:1] setTitle:[self.picker toolbarTitle]];
    
    if (!self.picker.isSingleSelection) {
        [self.navigationController setToolbarHidden:(selectedAssets.count == 0) animated:YES];
    }
}



#pragma mark - Gesture Recognizer

- (void)addGestureRecognizer
{
    UILongPressGestureRecognizer *longPress =
    [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(pushPageViewController:)];
    
    [self.collectionView addGestureRecognizer:longPress];
}


#pragma mark - Push Assets Page View Controller

- (void)pushPageViewController:(UILongPressGestureRecognizer *)longPress
{
    if (longPress.state == UIGestureRecognizerStateBegan)
    {
        CGPoint point           = [longPress locationInView:self.collectionView];
        NSIndexPath *indexPath  = [self.collectionView indexPathForItemAtPoint:point];

        CTAssetsPageViewController *vc = [[CTAssetsPageViewController alloc] initWithAssets:self.assets];
        vc.pageIndex = indexPath.item;

        [self.navigationController pushViewController:vc animated:YES];
    }
}



#pragma mark - Reload Assets

- (void)reloadAssets
{
    self.assets = nil;
    [self setupAssets];
}



#pragma mark - Reload Data

- (void)reloadData
{
    if (self.assets.count > 0)
    {
        [self.collectionView reloadData];
        [self.collectionView setContentOffset:CGPointZero];
        // remove no asset notice
        [self.collectionView.backgroundView removeFromSuperview];
        UIView *blankView = [UIView new];
        blankView.backgroundColor = [UIColor clearColor];
        self.collectionView.backgroundView = blankView;
    }
    else
    {
        [self showNoAssets];
    }
}


#pragma mark - Not allowed / No assets

- (void)showNotAllowed
{
    self.navigationItem.titleView = Nil;
    [self.collectionView reloadData];
    [self.collectionView.backgroundView removeFromSuperview];
    self.collectionView.backgroundView = [self.picker notAllowedView];
    [self setAccessibilityFocus];
}


- (void)showNoAssets
{
    [self.collectionView reloadData];
    [self.collectionView.backgroundView removeFromSuperview];
    self.collectionView.backgroundView = [self.picker noAssetsView];
    [self setAccessibilityFocus];
}

- (void)setAccessibilityFocus
{
    self.collectionView.isAccessibilityElement  = YES;
    self.collectionView.accessibilityLabel      = self.collectionView.backgroundView.accessibilityLabel;
    UIAccessibilityPostNotification(UIAccessibilityScreenChangedNotification, self.collectionView);
}


#pragma mark - Collection View Data Source

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.assets.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    CTAssetsViewCell *cell =
    [collectionView dequeueReusableCellWithReuseIdentifier:CTAssetsViewCellIdentifier
                                              forIndexPath:indexPath];
    
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldEnableAsset:)])
        cell.enabled = [self.picker.delegate assetsPickerController:self.picker shouldEnableAsset:asset];
    else
        cell.enabled = YES;
    
    // XXX
    // Setting `selected` property blocks further deselection.
    // Have to call selectItemAtIndexPath too. ( ref: http://stackoverflow.com/a/17812116/1648333 )
    if ([self.picker.selectedAssets containsObject:asset])
    {
        cell.selected = YES;
        [collectionView selectItemAtIndexPath:indexPath animated:NO scrollPosition:UICollectionViewScrollPositionNone];
    }
    
    [cell bind:asset];
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
    CTAssetsSupplementaryView *view =
    [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter
                                       withReuseIdentifier:CTAssetsSupplementaryViewIdentifier
                                              forIndexPath:indexPath];
    [view bind:self.assets];
    
    if (self.assets.count == 0)
        view.hidden = YES;
    
    return view;
}


#pragma mark - Collection View Delegate

- (BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    CTAssetsViewCell *cell = (CTAssetsViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.shouldShowSelectionState = !self.picker.isSingleSelection;
    if (!cell.isEnabled)
        return NO;
    else if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldSelectAsset:)])
        return [self.picker.delegate assetsPickerController:self.picker shouldSelectAsset:asset];
    else
        return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.picker.isSingleSelection) {
        CTAssetsPageViewController *vc = [[CTAssetsPageViewController alloc] initWithAssets:self.assets];
        vc.pageIndex = indexPath.row;
        vc.picker = self.picker;
        [self.navigationController pushViewController:vc animated:YES];
    }
    else {
        ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
        
        [self.picker selectAsset:asset];
        
        if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:didSelectAsset:)])
            [self.picker.delegate assetsPickerController:self.picker didSelectAsset:asset];
    }
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldDeselectAsset:)])
        return [self.picker.delegate assetsPickerController:self.picker shouldDeselectAsset:asset];
    else
        return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    [self.picker deselectAsset:asset];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:didDeselectAsset:)])
        [self.picker.delegate assetsPickerController:self.picker didDeselectAsset:asset];
}

- (BOOL)collectionView:(UICollectionView *)collectionView shouldHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:shouldHighlightAsset:)])
        return [self.picker.delegate assetsPickerController:self.picker shouldHighlightAsset:asset];
    else
        return YES;
}

- (void)collectionView:(UICollectionView *)collectionView didHighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:didHighlightAsset:)])
        [self.picker.delegate assetsPickerController:self.picker didHighlightAsset:asset];
}

- (void)collectionView:(UICollectionView *)collectionView didUnhighlightItemAtIndexPath:(NSIndexPath *)indexPath
{
    ALAsset *asset = [self.assets objectAtIndex:indexPath.row];
    
    if ([self.picker.delegate respondsToSelector:@selector(assetsPickerController:didUnhighlightAsset:)])
        [self.picker.delegate assetsPickerController:self.picker didUnhighlightAsset:asset];
}


@end