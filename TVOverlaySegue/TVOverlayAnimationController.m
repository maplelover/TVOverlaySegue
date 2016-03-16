//
//  TVOverlayAnimationController.m
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/11.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "TVOverlayAnimationController.h"
#import "UIViewController+TVOverlaySegue.h"
#import "TVOverlayAnimationDelegate.h"

@interface TVOverlayAnimationController ()

@property (nonatomic, strong) UIView *dimmingView;

@property (nonatomic, weak) UIViewController *modalViewController;
@property (nonatomic, weak) UIView *modalView;

@end

@implementation TVOverlayAnimationController

#pragma mark - Getter/Setter
- (BOOL)isPresenting
{
    return TVOverlayPresentationAnimation == self.animationType;
}

- (id<TVOverlayAnimationDelegate>)overlaySegueDelegate
{
    id<TVOverlayAnimationDelegate> delegate = nil;
    
    if ([self.modalViewController conformsToProtocol:@protocol(TVOverlayAnimationDelegate)])
    {
        delegate = (id<TVOverlayAnimationDelegate>)self.modalViewController;
    }
    
    return delegate;
}

- (UIView *)dimmingView
{
    if (!_dimmingView)
    {
        _dimmingView = [[UIView alloc] initWithFrame:[UIScreen mainScreen].bounds];
        _dimmingView.alpha = 0;
        _dimmingView.backgroundColor = [UIColor colorWithWhite:0 alpha:0.5];
        _dimmingView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    }
    return _dimmingView;
}

#pragma mark - UIViewControllerAnimatedTransitioning
- (void)animateTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    [self prepareForTransition:transitionContext];
    
    NSTimeInterval duration = [self transitionDuration:transitionContext];
    [self animateDimmingViewTransitionWithDuration:duration];
    
    void (^completionBlock)(BOOL) = ^(BOOL finished){
        BOOL isCancelled = [transitionContext transitionWasCancelled];
        [transitionContext completeTransition:!isCancelled];
    };
    
    if ([self.overlaySegueDelegate respondsToSelector:@selector(overlayAnimateTransition:completion:)])
    {
        [self.overlaySegueDelegate overlayAnimateTransition:transitionContext completion:completionBlock];
    }
    else
    {
        [self animateModalViewTransition:transitionContext duration:duration completion:completionBlock];
    }
}

- (NSTimeInterval)transitionDuration:(id<UIViewControllerContextTransitioning>)transitionContext
{
    NSTimeInterval duration = 0.5;
    
    id<TVOverlayAnimationDelegate> delegate = [self overlaySegueDelegate];
    if ([delegate respondsToSelector:@selector(overlayTransitionDuration:)])
    {
        duration = [delegate overlayTransitionDuration:transitionContext];
    }
    
    return duration;
}

#pragma mark - Private
- (void)prepareForTransition:(id<UIViewControllerContextTransitioning>)transitionContext
{
    UIView *containerView = [transitionContext containerView];
    
    if ([self isPresenting])
    {
        self.dimmingView.frame = containerView.bounds;
        [containerView addSubview:self.dimmingView];
        
        self.modalViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
        self.modalView = self.modalViewController.view;
        
        // 7.x 屏幕横屏时高宽倒置
        if (!CGSizeEqualToSize(self.modalView.frame.size, containerView.bounds.size))
        {
            self.modalView.frame = containerView.bounds;
        }
        
        [containerView addSubview:self.modalView];
        
        id<TVOverlayAnimationDelegate> delegate = [self overlaySegueDelegate];
        if ([delegate respondsToSelector:@selector(overlayPresentationTransitionDidPrepare:dimmingView:)])
        {
            [delegate overlayPresentationTransitionDidPrepare:transitionContext dimmingView:self.dimmingView];
        }
    }
    else
    {
        self.modalViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
        self.modalView = self.modalViewController.view;
        
        id<TVOverlayAnimationDelegate> delegate = [self overlaySegueDelegate];
        if ([delegate respondsToSelector:@selector(overlayDismissalTransitionDidPrepare:dimmingView:)])
        {
            [delegate overlayDismissalTransitionDidPrepare:transitionContext dimmingView:self.dimmingView];
        }
    }
}

- (void)animateDimmingViewTransitionWithDuration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration
                          delay:0
                        options:UIViewAnimationOptionCurveEaseOut
                     animations:^{
                         CGFloat alpha = [self isPresenting] ? 1 : 0;
                         self.dimmingView.alpha = alpha;
                     }
                     completion:^(BOOL finished) {
                         if (![self isPresenting])
                         {
                             [self.dimmingView removeFromSuperview];
                             self.dimmingView = nil;
                         }
                     }];
}

- (void)animateModalViewTransition:(id<UIViewControllerContextTransitioning>)transitionContext duration:(NSTimeInterval)duration completion:(void (^)(BOOL finished))completion
{
    BOOL isPresenting = [self isPresenting];
    CGRect endFrame = self.modalView.frame;
    CGRect startFrame = endFrame;
    BOOL isCrossDissolveStyle = [self.modalViewController isOverlayCrossDissolveStyle];
    
    if ([self.modalViewController isOverlayCoverHorizontalStyle])
    {
        startFrame.origin.x = startFrame.size.width;
    }
    else if ([self.modalViewController isOverlayCoverVerticalStyle])
    {
        startFrame.origin.y = startFrame.size.height;
    }
    
    if (isPresenting)
    {
        if (isCrossDissolveStyle)
        {
            self.modalView.alpha = 0;
        }
        
        self.modalView.frame = startFrame;
    }
    
    [self notifyTransitionWillBegin:isPresenting context:transitionContext];
    
    [UIView animateWithDuration:duration
                          delay:0.0
         usingSpringWithDamping:1
          initialSpringVelocity:1.0
                        options:0
                     animations:^{
                         CGRect frame = self.modalView.frame;
                         
                         if (isCrossDissolveStyle)
                         {
                             self.modalView.alpha = isPresenting ? 1 : 0;
                         }
                         
                         [self notifyAlongsideTransition:isPresenting context:transitionContext];
                         
                         // iOS7 bug: 动画内多次设置frame导致动画异常
                         if (CGRectEqualToRect(frame, self.modalView.frame))
                         {
                             self.modalView.frame = isPresenting ? endFrame : startFrame;
                         }
                     }
                     completion:^(BOOL finished) {
                         [self notifyTransitionDidEnd:finished isPresenting:isPresenting context:transitionContext];
                         completion(finished);
                     }];
}

- (void)notifyAlongsideTransition:(BOOL)isPresenting context:(id<UIViewControllerContextTransitioning>)context
{
    id<TVOverlayAnimationDelegate> delegate = [self overlaySegueDelegate];
    if (isPresenting)
    {
        if ([delegate respondsToSelector:@selector(overlayAnimateAlongsidePresentationTransition:)])
        {
            [delegate overlayAnimateAlongsidePresentationTransition:context];
        }
    }
    else
    {
        if ([delegate respondsToSelector:@selector(overlayAnimateAlongsideDismissalTransition:)])
        {
            [delegate overlayAnimateAlongsideDismissalTransition:context];
        }
    }
}

- (void)notifyTransitionWillBegin:(BOOL)isPresenting context:(id<UIViewControllerContextTransitioning>)context
{
    id<TVOverlayAnimationDelegate> delegate = [self overlaySegueDelegate];
    if (isPresenting)
    {
        if ([delegate respondsToSelector:@selector(overlayPresentationTransitionWillBegin:)])
        {
            [delegate overlayPresentationTransitionWillBegin:context];
        }
    }
    else
    {
        if ([delegate respondsToSelector:@selector(overlayDismissalTransitionWillBegin:)])
        {
            [delegate overlayDismissalTransitionWillBegin:context];
        }
    }
}

- (void)notifyTransitionDidEnd:(BOOL)completed isPresenting:(BOOL)isPresenting context:(id<UIViewControllerContextTransitioning>)context
{
    id<TVOverlayAnimationDelegate> delegate = [self overlaySegueDelegate];
    if (isPresenting)
    {
        if ([delegate respondsToSelector:@selector(overlayPresentationTransitionDidEnd:context:)])
        {
            [delegate overlayPresentationTransitionDidEnd:completed context:context];
        }
    }
    else
    {
        if ([delegate respondsToSelector:@selector(overlayDismissalTransitionDidEnd:context:)])
        {
            [delegate overlayDismissalTransitionDidEnd:completed context:context];
        }
    }
}

@end
