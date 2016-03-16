//
//  TVOverlayAnimationController.h
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/11.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TVOverlayDefines.h"

@interface TVOverlayAnimationController : NSObject <UIViewControllerAnimatedTransitioning>

@property (nonatomic) TVOverlayAnimationType animationType;

@end
