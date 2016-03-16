//
//  MenuViewController.m
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/14.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "MenuViewController.h"
#import "TVOverlayAnimationDelegate.h"

@interface MenuViewController () <TVOverlayAnimationDelegate>

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *leftCons;
@property (weak, nonatomic) IBOutlet UIView *blockView;
@property (nonatomic) CGAffineTransform orginalTransform;

@end

@implementation MenuViewController

- (IBAction)close:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

#pragma mark - TVOverlayAnimationDelegate
- (void)overlayPresentationTransitionDidPrepare:(id<UIViewControllerContextTransitioning>)context dimmingView:(UIView *)dimmingView
{
    dimmingView.backgroundColor = [[UIColor magentaColor] colorWithAlphaComponent:0.3];
    self.orginalTransform = self.view.transform;
    self.view.transform = CGAffineTransformTranslate(self.orginalTransform, 0.8, 0.8);
}

- (void)overlayAnimateAlongsidePresentationTransition:(id<UIViewControllerContextTransitioning>)context
{
    self.view.backgroundColor = [UIColor grayColor];
    self.view.transform = self.orginalTransform;
    
    self.leftCons.constant = self.view.bounds.size.width - self.blockView.frame.size.width;
    [self.view layoutIfNeeded];
}

- (void)overlayAnimateAlongsideDismissalTransition:(id<UIViewControllerContextTransitioning>)context
{
    CGAffineTransform tranform = CGAffineTransformMakeTranslation(-self.view.bounds.size.width, 0);
    self.view.transform = CGAffineTransformScale(tranform, 0.1, 0.1);
    
    self.leftCons.constant = -self.blockView.frame.size.width;
    self.blockView.backgroundColor = [UIColor redColor];
    self.blockView.transform = CGAffineTransformMakeScale(0.5, 0.5);
    self.blockView.alpha = 0.1;
    [self.blockView layoutIfNeeded];
    [self.view layoutIfNeeded];
}

- (NSTimeInterval)overlayTransitionDuration:(id<UIViewControllerContextTransitioning>)context
{
    return 1;
}

//- (void)overlayAnimateTransition:(id<UIViewControllerContextTransitioning>)transitionContext completion:(void (^)(BOOL finished))completion
//{
//    CGAffineTransform transform = CGAffineTransformMakeScale(0.1, 0.1);
//    transform = CGAffineTransformTranslate(transform, 0, self.view.frame.size.height);
//    
//    BOOL isPresenting = [self isBeingPresented];
//    if (isPresenting)
//    {
//        self.view.transform = transform;
//        self.view.alpha = 0;
//    }
//    
//    CGFloat duration = [self overlayTransitionDuration:context];
//    [UIView animateWithDuration:duration animations:^{
//        self.view.transform = isPresenting ? CGAffineTransformIdentity : transform;
//        self.view.alpha = 1 - self.view.alpha;
//    } completion:completion];
//}

@end
