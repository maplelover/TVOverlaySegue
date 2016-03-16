//
//  TVOverlayDefines.h
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/15.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, TVOverlayAnimationType)
{
    TVOverlayPresentationAnimation,
    TVOverlayDismissalAnimation
};

typedef NS_ENUM(NSInteger, TVOverlayTransitionStyle)
{
    TVOverlayTransitionStyleDefault         = 0,   ///< 默认直接显示
    TVOverlayTransitionStyleCoverVertical   = 1,
    TVOverlayTransitionStyleCoverHorizontal = 2,
    TVOverlayTransitionStyleCrossDissolve   = 3,
};
