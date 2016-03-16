//
//  TVAlertViewController.m
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/14.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "TVAlertViewController.h"
#import "TVOverlayAnimationDelegate.h"

@interface TVAlertViewController () <TVOverlayAnimationDelegate>

@property (weak, nonatomic) IBOutlet UIView *contentView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerConstraint;

@end

@implementation TVAlertViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.contentView.layer.cornerRadius = 10;
    self.contentView.layer.masksToBounds = YES;
    self.contentView.layer.borderColor = [UIColor whiteColor].CGColor;
    self.contentView.layer.borderWidth = 1;
}

#pragma mark - TVOverlayAnimationDelegate
- (void)overlayPresentationTransitionDidPrepare:(id<UIViewControllerContextTransitioning>)context dimmingView:(UIView *)dimmingView
{
    dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.6];
}

- (void)overlayPresentationTransitionWillBegin:(id<UIViewControllerContextTransitioning>)context
{
    self.centerConstraint.constant = (self.view.frame.size.height + self.contentView.frame.size.height) / 2;
    [self.view layoutIfNeeded];
}

- (void)overlayAnimateAlongsidePresentationTransition:(id<UIViewControllerContextTransitioning>)context
{
    self.centerConstraint.constant = 0;
    [self.view layoutIfNeeded];
}

- (void)overlayAnimateAlongsideDismissalTransition:(id<UIViewControllerContextTransitioning>)context
{
    self.centerConstraint.constant = (self.view.frame.size.height + self.contentView.frame.size.height) / 2;
    
    [self.contentView setNeedsLayout]; // iOS7.x bug
    [self.contentView layoutIfNeeded];
    [self.view layoutIfNeeded];
}

#pragma mark - Event Handler
- (IBAction)close
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
