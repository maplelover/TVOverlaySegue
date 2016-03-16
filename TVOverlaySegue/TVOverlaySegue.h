//
//  TVOverlaySegue.h
//  OverlaySegueDemo
//
//  Created by zhoujinrui on 16/3/11.
//  Copyright © 2016年 Maple. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 *  @class TVOverlaySegue
 *  浮层式弹出
 *  类似UIStoryboardPopoverSegue，目标视图控制器弹出后，直接覆盖在源视图上面,
 *  源视图与目标视图共存
 *  可将目标视图背景设置为透明，则可透过目标视图看到源视图
 *  可在Storyboard中直接拖拽来创建连接，除了动画形式，其行为与Present Modally完全一致，目标视图可通过dismissViewControllerAnimated关闭
 *  @warning
 *  关闭弹出视图，需要调用 [self dismissViewControllerAnimated:YES]，动画参数固定为YES
 */
@interface TVOverlaySegue : UIStoryboardSegue

@end
