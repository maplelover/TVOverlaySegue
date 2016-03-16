//
//  PartViewController.m
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/15.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "PartViewController.h"
#import "TVOverlaySegue.h"
#import "TVOverlayAnimationDelegate.h"

@interface PartViewController () <TVOverlayAnimationDelegate>

@end

@implementation PartViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapDimmingView:)];
    [self.view addGestureRecognizer:tap];
}

#pragma mark - TVOverlayAnimationDelegate
- (void)overlayPresentationTransitionDidPrepare:(id<UIViewControllerContextTransitioning>)context dimmingView:(UIView *)dimmingView
{
    dimmingView.backgroundColor = [UIColor clearColor];
}

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)tapDimmingView:(UITapGestureRecognizer *)g
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
