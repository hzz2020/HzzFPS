//
//  HzzFPSStatus.m
//  HzzFPS
//
//  Created by laolai on 2021/3/8.
//

#import "HzzFPSStatus.h"
#import <UIKit/UIKit.h>


@interface HzzFPSStatus ()
{
    UIWindow *_window;
    UILabel *_fpsLabel;
    
    CADisplayLink *_displayLink;
    NSTimeInterval _lastTime;
    NSInteger _count;
}

@end

@implementation HzzFPSStatus

+ (instancetype)shareInstance {
    static HzzFPSStatus *shareInstance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareInstance = [[HzzFPSStatus alloc] init];
    });
    return shareInstance;;
}

- (void)dealloc
{
    [_displayLink setPaused:YES];
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (id)init {
    self = [super init];
    if (self) {
        /// 监听
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationDidBecomeActiveNotification)
                                                     name: UIApplicationDidBecomeActiveNotification
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillResignActiveNotification)
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: nil];
        // 使用CADisplayLink跟踪FPS
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick:)];
        [_displayLink setPaused:YES];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        
        /// 显示FPS值Label
        UILabel *fpsLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        fpsLabel.layer.cornerRadius = 4.0f;
        fpsLabel.clipsToBounds = YES;
        fpsLabel.textColor = [UIColor greenColor];
        fpsLabel.backgroundColor = [UIColor darkGrayColor];
        fpsLabel.font = [UIFont boldSystemFontOfSize:12];
        fpsLabel.textAlignment = NSTextAlignmentCenter;
        _fpsLabel = fpsLabel;
        /// 悬浮框
        UIViewController *viewc = [[UIViewController alloc] init];
        UIWindow *window = [[UIWindow alloc] initWithFrame:CGRectMake(0, 0, 70, 20)];
        window.center = CGPointMake([UIScreen mainScreen].bounds.size.width-70*0.5, 20+44*0.5);
        window.windowLevel = UIWindowLevelAlert + 1;
        window.rootViewController = viewc;
        window.userInteractionEnabled = YES;
        [window addSubview:fpsLabel];
        [window makeKeyAndVisible];
        _window = window;
        /// 附加功能--拖动悬浮框
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:self
                                                                              action:@selector(handleGesture:)];
        [window addGestureRecognizer:pan];
        // 长按关闭显示
        UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(close)];
        longPress.minimumPressDuration = 3;
        [window addGestureRecognizer:longPress];
    }
    return self;
}

- (void)displayLinkTick:(CADisplayLink *)link {
    if (_lastTime == 0) {
        _lastTime = link.timestamp;
        return;
    }
    
    _count++;
    NSTimeInterval interval = link.timestamp - _lastTime;
    if (interval < 1) return;
    _lastTime = link.timestamp;
    float fps = _count / interval;
    _count = 0;
    
    NSString *text = [NSString stringWithFormat:@"%d FPS",(int)round(fps)];
    [_fpsLabel setText:text];
    if (_fpsHandler) {
        _fpsHandler((int)round(fps));
    }
}

/// 打开跟踪
- (void)open {
    [_displayLink setPaused:NO];
}

/// 打开跟踪并处理结果
- (void)openWithHandler:(FpsHandlerBlock)fpsHandler{
    [[HzzFPSStatus shareInstance] open];
    _fpsHandler = fpsHandler;
}

/// 关闭
- (void)close {
    [_displayLink setPaused:YES];
    [_window resignKeyWindow];
    _window = nil;
}

/// app进入前台
- (void)applicationDidBecomeActiveNotification {
    if (_window) {
        [_displayLink setPaused:NO];
    }
}

/// app进入后台
- (void)applicationWillResignActiveNotification {
    if (_window) {
        [_displayLink setPaused:YES];
    }
}

/// 附加功能--拖动悬浮框
- (void)handleGesture:(UIPanGestureRecognizer *)panGesture{
    CGPoint translation = [panGesture translationInView:_window];
    _window.center = CGPointMake(_window.center.x + translation.x,
                                 _window.center.y + translation.y);
    [panGesture setTranslation:CGPointZero inView:_window];
    switch (panGesture.state) {
        case UIGestureRecognizerStateBegan:
            break;
        case UIGestureRecognizerStateChanged:
            break;
        case UIGestureRecognizerStateEnded:
            break;
        default:
            break;
    }
}

@end
