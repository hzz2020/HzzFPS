//
//  HzzFPS.h
//  HzzFPS
//
//  Created by laolai on 2021/3/8.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

typedef void(^FpsHandlerBlock)(NSInteger fpsValue);

@interface HzzFPS : NSObject

@property (nonatomic, copy) FpsHandlerBlock fpsHandler;

/// 单例 +类方法
+ (instancetype)shareInstance;

- (void)open;
- (void)openWithHandler:(FpsHandlerBlock)fpsHandler;
- (void)close;

@end

NS_ASSUME_NONNULL_END
