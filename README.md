# LNAsyncKit
### 简介
LNAsyncKit是一个异步渲染框架：An async feed stream framework. 

* 提供了便捷的方法帮助你将多个元素（Element）异步渲染到一张图片上，让这个过程代替UIKit的视图构建过程，进而优化App性能。
* 提供预加载策略帮助你在Feed流中弥补异步渲染带来的延时。
* 提供更优雅的方式让主线程与子线程交互，并能根据机器状态控制并发数和主线程回调时机。

### [Github链接](https://github.com/LevisonNN/LNAsyncKit)

你可以直接下载这个链接并运行上面的Demo参考代码实现自己的异步列表，也可以直接使用Cocoapods👇

```
pod 'LNAsyncKit'
```

### [掘金地址](https://juejin.cn/post/6934720152546050078)

#### 它可以提供哪些帮助

* 还没有找到方案优化圆角、边框、渐变的优化方案，LNAsyncKit可以异步解决这些。
* Feed流需要预加载策略，LNAsyncKit提供预加载区域计算方案（这个方案也用来预合成）。
* 提供一种与UIKit十分接近的方式构建需要预合成的图层，让你的复杂图层构建都放在子线程进行，且不会创建那么多UIView。
* 一套AFNetworking/SDWebImage/IGListKit/YYModel/MJRefresh + LNAsyncKit 搭建完整Feed流的流程。

使用效果：

[![69ZH7q.jpg](https://s3.ax1x.com/2021/02/28/69ZH7q.jpg)](https://imgtu.com/i/69ZH7q)

 变成：

[![69ZqA0.jpg](https://s3.ax1x.com/2021/02/28/69ZqA0.jpg)](https://imgtu.com/i/69ZqA0)

优势：

* 减少视图层级。
* 异步绘制圆角、边框、渐变。
* 图片尺寸和控件尺寸一致。
* 异步布局。
* 预加载策略。
* 与UIKit几乎一致的视图搭建模式。
* 等

