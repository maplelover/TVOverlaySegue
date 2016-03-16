//
//  UIViewController+TVOverlaySegue.m
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/14.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import "UIViewController+TVOverlaySegue.h"
#import <objc/runtime.h>

static const char kTransitionStyleKey = 0;

@implementation UIViewController (TVOverlaySegue)

- (TVOverlayTransitionStyle)overlayTransitionStyle
{
    NSNumber *number = objc_getAssociatedObject(self, &kTransitionStyleKey);
    return [number integerValue];
}

- (void)setOverlayTransitionStyle:(TVOverlayTransitionStyle)overlayTransitionStyle
{
    NSNumber *number = @(overlayTransitionStyle);
    objc_setAssociatedObject(self, &kTransitionStyleKey, number, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

- (BOOL)isOverlayCrossDissolveStyle
{
    return TVOverlayTransitionStyleCrossDissolve == self.overlayTransitionStyle;
}

- (void)setOverlayCrossDissolveStyle:(BOOL)overlayCrossDissolveStyle
{
    if (overlayCrossDissolveStyle)
    {
        self.overlayTransitionStyle = TVOverlayTransitionStyleCrossDissolve;
    }
    else
    {
        self.overlayTransitionStyle = TVOverlayTransitionStyleDefault;
    }
}

- (BOOL)isOverlayCoverHorizontalStyle
{
    return TVOverlayTransitionStyleCoverHorizontal == self.overlayTransitionStyle;
}

- (void)setOverlayCoverHorizontalStyle:(BOOL)overlayCoverHorizontalStyle
{
    if (overlayCoverHorizontalStyle)
    {
        self.overlayTransitionStyle = TVOverlayTransitionStyleCoverHorizontal;
    }
    else
    {
        self.overlayTransitionStyle = TVOverlayTransitionStyleDefault;
    }
}

- (BOOL)isOverlayCoverVerticalStyle
{
    return TVOverlayTransitionStyleCoverVertical == self.overlayTransitionStyle;
}

- (void)setOverlayCoverVerticalStyle:(BOOL)overlayCoverVerticalStyle
{
    if (overlayCoverVerticalStyle)
    {
        self.overlayTransitionStyle = TVOverlayTransitionStyleCoverVertical;
    }
    else
    {
        self.overlayTransitionStyle = TVOverlayTransitionStyleDefault;
    }
}

@end
