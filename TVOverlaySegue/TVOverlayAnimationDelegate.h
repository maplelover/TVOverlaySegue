//
//  TVOverlayAnimationDelegate.h
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/15.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Overlay动画代理
 * 由presented view controller实现
 */
@protocol TVOverlayAnimationDelegate <NSObject>

@optional

/// 弹出动画准备完成
- (void)overlayPresentationTransitionDidPrepare:(id<UIViewControllerContextTransitioning>)context dimmingView:(UIView *)dimmingView;

/// 消失动画准备完成
- (void)overlayDismissalTransitionDidPrepare:(id<UIViewControllerContextTransitioning>)context dimmingView:(UIView *)dimmingView;

/**
 * 自定义过渡动画
 * @warning completion一定要回调，否则界面将出现假死
 */
- (void)overlayAnimateTransition:(id<UIViewControllerContextTransitioning>)context completion:(void (^)(BOOL finished))completion;

/// 自定义过渡动画时长
- (NSTimeInterval)overlayTransitionDuration:(id<UIViewControllerContextTransitioning>)context;

/**
 * 如果实现自定义过渡动画，则以下方法不会被调用
 */

/// 弹出动画将要开始
- (void)overlayPresentationTransitionWillBegin:(id<UIViewControllerContextTransitioning>)context;
/// 弹出动画内执行
- (void)overlayAnimateAlongsidePresentationTransition:(id<UIViewControllerContextTransitioning>)context;
/// 弹出动画已经结束
- (void)overlayPresentationTransitionDidEnd:(BOOL)completed context:(id<UIViewControllerContextTransitioning>)context;
/// 消失动画将要开始
- (void)overlayDismissalTransitionWillBegin:(id<UIViewControllerContextTransitioning>)context;
/// 消失动画内执行
- (void)overlayAnimateAlongsideDismissalTransition:(id<UIViewControllerContextTransitioning>)context;
/// 消失动画已经结束
- (void)overlayDismissalTransitionDidEnd:(BOOL)completed context:(id<UIViewControllerContextTransitioning>)context;

@end
