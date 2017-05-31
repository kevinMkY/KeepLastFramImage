//
//  KKKeepLastFrameImageView.m
//  KKShopping
//
//  Created by kevin on 2017/5/24.
//  Copyright © 2017年 nice. All rights reserved.
//

#import "KKKeepLastFrameImageView.h"

@interface KKKeepLastFrameImageView()
{
    NSInteger _currentStepCount;
}

@property (nonatomic, assign) int index;
@property (nonatomic, strong) CADisplayLink *link;
@property (nonatomic, strong) UIImage *curFrame;

@end

@implementation KKKeepLastFrameImageView

- (void)dealloc
{
    [_link removeFromRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
    [_link invalidate];
    _link = nil;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        
        _link = [CADisplayLink displayLinkWithTarget:self selector:@selector(step)];
        [_link addToRunLoop:[NSRunLoop mainRunLoop] forMode:NSRunLoopCommonModes];
        _link.paused = YES;
    }
    return self;
}

- (void)setAnimationImages:(NSArray<UIImage *> *)animationImages
{
    [super setAnimationImages:animationImages];
    
    _curFrame = animationImages.firstObject;
    self.layer.contents = (__bridge id)_curFrame.CGImage;
    [self.layer setNeedsDisplay];
}

- (void)startAnimating
{
    _link.paused = NO;
}

- (void)stopAnimating
{
    _link.paused = YES;
    self.index = 0;
    _curFrame = nil;
    _currentStepCount = 0;
}

-(void)step
{
    if(_frameIntervalMS <= 0)
    {
        return;
    }
    
    _currentStepCount++;
    double c = 60 * _frameIntervalMS/1000;    //一秒60次的话,几次换一帧
    double curInterval = _currentStepCount/c;
    
    if (curInterval > self.index) {
        if (self.animationImages.count * self.animationRepeatCount > self.index) {
            _curFrame = self.animationImages[self.index%self.animationImages.count];
            [self.layer setNeedsDisplay];
            self.index += 1;
        }else{
            [self stopAnimating];
        }
    }
}

- (void)displayLayer:(CALayer *)layer {
    if (_curFrame) {
        layer.contents = (__bridge id)_curFrame.CGImage;
    }
}

- (BOOL)isAnimating
{
    return !_link.paused;
}

@end
