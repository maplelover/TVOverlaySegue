//
//  UIViewController+TVOverlaySegue.h
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/14.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVOverlayDefines.h"

@interface UIViewController (TVOverlaySegue)

///< 过渡动画样式
@property (nonatomic) TVOverlayTransitionStyle overlayTransitionStyle;

///< 渐变
@property (nonatomic, getter=isOverlayCrossDissolveStyle) IBInspectable BOOL overlayCrossDissolveStyle;

///< 垂直方向向上弹出
@property (nonatomic, getter=isOverlayCoverVerticalStyle) IBInspectable BOOL overlayCoverVerticalStyle;

///< 水平方向向左弹出
@property (nonatomic, getter=isOverlayCoverHorizontalStyle) IBInspectable BOOL overlayCoverHorizontalStyle;

@end
