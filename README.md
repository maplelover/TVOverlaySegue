# TVOverlaySegue

实现Popover效果，iPhone/iPad通用

TVOverlaySegue浮层式弹出

类似UIStoryboardPopoverSegue，目标视图控制器弹出后，直接覆盖在源视图上面,源视图与目标视图共存
可将目标视图背景设置为透明，则可透过目标视图看到源视图
在此基础上，可以轻松实现AlertView/ActionSheet等效果，例子见Demo工程。

为保证通用性，主视图只提供了简单的动画形式，具体扩展可以在UIViewController内部实现。

可在Storyboard中直接拖拽来创建连接，除了动画形式，其行为与Present Modally完全一致，目标视图可通过dismissViewControllerAnimated关闭

支持版本: iOS7+
语言: Objective-C
