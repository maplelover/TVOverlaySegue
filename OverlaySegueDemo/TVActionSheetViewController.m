//
//  TVActionSheetViewController.m
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/14.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "TVActionSheetViewController.h"
#import "TVOverlayAnimationDelegate.h"

@interface TVActionSheetViewController () <TVOverlayAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *bottomConstraint;

@end

@implementation TVActionSheetViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDimmingView:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - TVOverlayAnimationDelegate
- (void)overlayPresentationTransitionWillBegin:(id<UIViewControllerContextTransitioning>)context
{
    self.bottomConstraint.constant = -self.contentView.frame.size.height;
    [self.view layoutIfNeeded];
}

- (void)overlayAnimateAlongsidePresentationTransition:(id<UIViewControllerContextTransitioning>)context
{
    self.bottomConstraint.constant = 0;
    [self.view layoutIfNeeded];
}

- (void)overlayAnimateAlongsideDismissalTransition:(id<UIViewControllerContextTransitioning>)context
{
    self.bottomConstraint.constant = -self.contentView.frame.size.height;
    
    [self.contentView setNeedsLayout]; // iOS7.x bug
    [self.contentView layoutIfNeeded];
    [self.view layoutIfNeeded];
}

#pragma mark - Event Handler
- (void)tapDimmingView:(UITapGestureRecognizer *)g
{
    CGPoint pt = [g locationInView:self.view];
    if (!CGRectContainsPoint(self.contentView.frame, pt))
    {
        [self close];
    }
}

- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
