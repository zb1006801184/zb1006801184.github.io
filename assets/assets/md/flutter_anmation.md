**一什么是动画？**

在一段时间内，快速地多次改变UI外观；由于人眼会产生视觉暂留，所以最终看到的就是一个“连续”的动画，这和电影的原理是一样的。我们将UI的一次改变称为一个动画帧，对应一次屏幕刷新，而决定动画流畅度的一个重要指标就是帧率FPS（Frame Per Second），即每秒的动画帧数。很明显，帧率越高则动画就会越流畅！一般情况下，对于人眼来说，动画帧率超过16FPS，就比较流畅了，超过32FPS就会非常的细腻平滑，而超过32FPS，人眼基本上就感受不到差别了


#### 其他小知识介绍：

电影是固定24帧
普通游戏 普通玩家  32帧就很流畅，操作要求越高  帧数要求越高
为什么同样是60帧有些游戏看起来卡，有些游戏看起来很流畅呢， 不是匀速的画帧， 举个例子，60帧  前半秒59帧  后半秒1帧，毫无疑问这是爆炸卡的。

### 二  基础概念
#### Animation
Animation 对象， 它是一个抽象类，保存了当前动画的值和状态（开始、暂停、前进、倒退），但不记录屏幕上显示的内容。UI 元素通过读		取 Animation 对象的值和监听状态变化运行 build 函数，然后渲染到屏幕上形成动画效果。
一个 Animation 对象在一段时间内会持续生成介于两个值之间的值，比较常见的类型是 Animation<double>，除 double 类型之外还有 Animation<Color> 或者 Animation<Size> 等。
#### AnimationController
带有控制方法的 Animation 对象，用来控制动画的启动，暂停，结束，设定动画运行时间等。初始化动画的时候需要一个vsync参数，是一个Ticker类型的子类，绑定Ticker的目的是当动画不在屏幕中的时不再执行动画，节省性能。
```
    controllFadeTransition = AnimationController(vsync: this, duration: Duration(seconds: 1));
```
#### Tween
用来生成不同类型和范围的动画取值。
```
        anmationFadeTransition = Tween(begin: 1.0, end: 0.0).animate(controllFadeTransition);
```
#### Curve
Flutter 动画的默认动画过程是匀速的，使用 CurvedAnimation 可以将时间曲线定义为非线性曲线。
```
_width = Tween<double>(
      begin: 100,
      end: 300,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.0,
          0.2,
          curve: Curves.ease,
        ),
      ),
    );
```
#### Ticker


用来添加每次屏幕刷新的回调函数 TickerCallback，每次屏幕刷新都会调用。类似于 Web 里面的 requestAnimationFrame 方法。

start 方法调用 shceduleTick，scheduleTick 利用 SchedulerBinding 对象向系统调度一帧，并添加回调 _tick

```
Ticker ticker = Ticker((Duration t) {

  })
      ..start();
```

### 三  flutter提供了哪些动画？都该如何使用？
Flutter 提供了强大的动画引擎，可以很简单的很方便的实现很多常用的动画

##### 1.隐式动画（AnimatedFoo、TweenAnimationBuilder）
隐式动画使用 Flutter 框架内置的动画部件创建，通过设置动画的起始值和最终值来触发。当使用 setState 方法改变部件的动画属性值时，框架会自动计算出一个从旧值过渡到新值的动画。
如: AnimatedOpacity     在透明度opacity发生变化时执行过渡动画到新状态
    AnimatedContainer   当Container属性发生变化时会执行过渡动画到新的状态
    AnimatedPadding   在padding发生变化时会执行过渡动画到新状态
    AnimatedPositioned    配合Stack一起使用，当定位状态发生变化时会执行过渡动画到新的状态
    AnimatedAlign   当alignment发生变化时会执行过渡动画到新的状态
    AnimatedSwitcher  当switcher发生变化时会执行过渡动画到新的状态


也可以自己实现隐式动画TweenAnimationBuilder
```
TweenAnimationBuilder(
          tween: Tween<double>(begin: 0, end: _value),
          duration: Duration(seconds: 1),
          builder: (BuildContext context, double value, Widget child) {
            return Container(
              width: value,
              height: value,
              child: child,
            );
          },
          child: FlutterLogo(size: 20),
        ),
```
都是继承自 ImplicitlyAnimatedWidget，

#### 2.显示动画
 显式动画指的是需要手动设置动画的时间，运动曲线，取值范围的动画，将值传递给动画部件。
如 ： 
FadeTransition,  允许你淡入淡出一个Widget
ScaleTransition, 允许你放大放小一个Widget
SizeTransition,  表示一个尺寸动画，可以通过控制器去控制动画尺寸值的改变，从而控制动画的尺寸
SlideTransition  平移动画
RotationTransition  旋转动画

 AnimatedWidget  使用它来实现显示动画,系统的显示动画都是基于它实现的，它里面主要是监听animation的值并刷新
```
class AnimatedZoomLogo extends AnimatedWidget {
  AnimatedZoomLogo({Key key, Animation<double> animation}) : super(key: key, listenable: animation);

  Widget build(BuildContext context) {
    final Animation<double> animation = listenable;
    return new Center(
      child: new Container(
        margin: new EdgeInsets.symmetric(vertical: 10.0),
        height: animation.value,
        width: animation.value,
        child: new FlutterLogo(),
      ),
    );
  }
}
```

####  3.Hero 动画
Hero指的是可以在路由(页面)之间“飞行”的widget，简单来说Hero动画就是在路由切换时，有一个共享的widget可以在新旧路由间切换。由于共享的widget在新旧路由页面上的位置、外观可能有所差异，所以在路由切换时会从旧路逐渐过渡到新路由中的指定位置，这样就会产生一个Hero动画。  也可以称未页面元素共享

#### 4.交织动画
交织动画是由一系列的小动画组成的动画。每个小动画可以是连续或间断的，也可以相互重叠。其关键点在于使用 Interval 部件给每个小动画设置一个时间间隔，以及为每个动画的设置一个取值范围 Tween，最后使用一个 AnimationController 控制总体的动画状态。
Interval 继承至 Curve 类，通过设置属性 begin 和 end 来确定这个小动画的运行范围。

#### 5.基于物理的动画
物理动画是一种模拟现实世界物体运动的动画。需要建立物体的运动模型，以一个物体下落为例，这个运动受到物体的下落高度，重力加速度，地面的反作用力等因素的影响。

#### 6. 画板CustomPaint
理论上可以实现所有的动画效果，给你一支笔去画出每一帧，实际上却不推荐，难度太大，就跟用01  理论上可以实现一切需求一样，而且极具耗性能。
下面是用CustomPaint实现的一个动态加载圈
```
class CustomPainrerPage extends StatefulWidget {
  @override
  _CustomPainrerPageState createState() => _CustomPainrerPageState();
}

class _CustomPainrerPageState extends State<CustomPainrerPage>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 1000))
          ..repeat()
          ..addListener(() {
            // print('object');
            setState(() {});
          });

    // _animation = Tween(begin: 0.0, end: 1.0).animate(_controller);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('画板'),
        ),
        body: Center(
          child: Container(
            width: 50,
            height: 50,
            child: CustomPaint(
              painter: DemoPainter(0, _controller.value * pi * 2
                  // Tween(begin: pi * 1.5, end: pi * 3.5)
                  //     .chain(CurveTween(curve: Interval(0.5, 1.0)))
                  //     .evaluate(_controller),
                  // sin(_controller.value * pi) * pi
                  ),
            ),
          ),
        ));
  }
}

class DemoPainter extends CustomPainter {
  final double _arcStart;
  final double _arcSweep;

  DemoPainter(this._arcStart, this._arcSweep);

  @override
  void paint(Canvas canvas, Size size) {
    double side = [size.width, size.height].reduce(min);
    Paint paint = Paint()
      ..color = Colors.blue
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 4.0
      ..style = PaintingStyle.stroke;
    canvas.drawArc(
        Offset.zero & Size(side, side), _arcStart, _arcSweep, false, paint);
  }

  @override
  bool shouldRepaint(DemoPainter other) {
    return _arcStart != other._arcStart || _arcSweep != other._arcSweep;
  }
}
```

***总结
补间动画 “介于两者之间”的简称。在补间动画中，定义了开始点和结束点、时间线以及定义转换时间和速度的曲线。然后由框架计算如何从开始点过渡到结束点。
物理动画  模拟现实世界物体运动的动画***

### 四  我们该如何选择动画？




Implicit Animations 隐式动画

Explicit Animation 显示动画

Low-Level Animation 低选择级别动画（画板）

Third-Party Animation Fameword 第三方动画库 如 Flare Lottie

![0T-YZa36Dv2a9xTLc.png](<Img>https://upload-images.jianshu.io/upload_images/2530176-c15c47ba6055e9b9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240<Img>)


![Pasted Graphic.png](<Img>https://upload-images.jianshu.io/upload_images/2530176-0651f261d1cc7e6b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240<Img>)

[demo]( https://github.com/zb1006801184/flutter_anmation_demo)

#### 参考
https://coldstone.fun/post/2020/04/26/flutter-animation-from-zero/
https://medium.com/flutter/how-to-choose-which-flutter-animation-widget-is-right-for-you-79ecfb7e72b5