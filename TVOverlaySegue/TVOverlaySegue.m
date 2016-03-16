//
//  TVOverlaySegue.m
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/11.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "TVOverlaySegue.h"
#import "TVOverlayAnimationController.h"
#import <objc/runtime.h>

static const char kTransitioningDelegateKey = 0;

@interface TVOverlayTransitioningDelegate : NSObject <UIViewControllerTransitioningDelegate>

@property (nonatomic, strong) TVOverlayAnimationController *animationController;

@end

@interface TVOverlaySegue ()

@property (nonatomic, strong, readonly) TVOverlayTransitioningDelegate *transitioningDelegate;

@end

@implementation TVOverlaySegue
@synthesize transitioningDelegate = _transitioningDelegate;

- (TVOverlayTransitioningDelegate *)transitioningDelegate
{
    if (!_transitioningDelegate)
    {
        _transitioningDelegate = [[TVOverlayTransitioningDelegate alloc] init];
        
        // 转场代理生命周期与弹出的视图控制器保持一致
        objc_setAssociatedObject(self.destinationViewController, &kTransitioningDelegateKey, _transitioningDelegate, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    return _transitioningDelegate;
}

- (void)perform
{
    self.destinationViewController.transitioningDelegate = self.transitioningDelegate;
    self.destinationViewController.modalPresentationStyle = UIModalPresentationCustom;
    self.destinationViewController.modalPresentationCapturesStatusBarAppearance = YES;
    
    [self.sourceViewController presentViewController:self.destinationViewController animated:YES completion:nil];
}

@end

@implementation TVOverlayTransitioningDelegate

- (TVOverlayAnimationController *)animationController
{
    if (!_animationController)
    {
        _animationController = [[TVOverlayAnimationController alloc] init];
    }
    return _animationController;
}

#pragma mark - UIViewControllerTransitioningDelegate
- (id<UIViewControllerAnimatedTransitioning>)animationControllerForPresentedController:(UIViewController *)presented presentingController:(UIViewController *)presenting sourceController:(UIViewController *)source
{
    self.animationController.animationType = TVOverlayPresentationAnimation;
    return self.animationController;
}

- (id<UIViewControllerAnimatedTransitioning>)animationControllerForDismissedController:(UIViewController *)dismissed
{
    self.animationController.animationType = TVOverlayDismissalAnimation;
    return self.animationController;
}

@end
