//
//  FpsLabel.m
//  XinzhiNet
//
//  Created by yangyi on 16/1/9.
//  Copyright © 2016年 XZ. All rights reserved.
//

#import "FPSLabel.h"
#import <QuartzCore/QuartzCore.h>

@interface FPSLabel ()
{
    CADisplayLink          *_displayLink;
    UILabel                *_displayLabel;
    NSUInteger             _maxHistoryDTLength;
    NSUInteger             _historyDTLength;
    CFTimeInterval         _displayLinkTickTimeLast;
    CFTimeInterval         _lastUIUpdateTime;
    CFTimeInterval         *_historyDT;
    UIWindow               *_window;
}
@end

@implementation FPSLabel

- (void)dealloc {
    [_displayLink setPaused:YES];
    [_displayLink removeFromRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
    free(_historyDT);
}

+ (void)showInWindow:(UIWindow *)window {
    CGRect labelFrame = CGRectMake([[UIScreen mainScreen] bounds].size.width - 100,20,55, 20);
    FPSLabel *label = [[FPSLabel alloc] initWithFrame:labelFrame];
    label.backgroundColor = [UIColor groupTableViewBackgroundColor];
    label.font = [UIFont systemFontOfSize:14.f];
    label.textAlignment = NSTextAlignmentCenter;
    [window addSubview:label];
    [window bringSubviewToFront:label];
}
- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        _maxHistoryDTLength = (NSInteger)CGRectGetWidth(self.bounds);
        _historyDT = malloc(sizeof(CFTimeInterval) * _maxHistoryDTLength);
        _historyDTLength        = 0;
        _displayLinkTickTimeLast= CACurrentMediaTime();
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationDidBecomeActiveNotification)
                                                     name: UIApplicationDidBecomeActiveNotification
                                                   object: nil];
        
        [[NSNotificationCenter defaultCenter] addObserver: self
                                                 selector: @selector(applicationWillResignActiveNotification)
                                                     name: UIApplicationWillResignActiveNotification
                                                   object: nil];
     
        _displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(displayLinkTick)];
        [_displayLink setPaused:YES];
        [_displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
        [self setDesiredChartUpdateInterval:8.0f /60.0f];
    }
    return self;
}


- (void)applicationDidBecomeActiveNotification {
    [_displayLink setPaused:NO];
}


- (void)applicationWillResignActiveNotification {
    [_displayLink setPaused:YES];
}

- (void)displayLinkTick {
    for (NSUInteger i = _historyDTLength; i >= 1; i-- ) {
        _historyDT[i] = _historyDT[i -1];
    }
    _historyDT[0] = _displayLink.timestamp -_displayLinkTickTimeLast;
    if (_historyDTLength < _maxHistoryDTLength - 1) _historyDTLength++;
    _displayLinkTickTimeLast = _displayLink.timestamp;
    CFTimeInterval timeSinceLastUIUpdate = _displayLinkTickTimeLast -_lastUIUpdateTime;
    if( _historyDT[0] < 0.1f && timeSinceLastUIUpdate >= _desiredChartUpdateInterval ){
        [self updateChartAndText];
    }
}


- (void)updateChartAndText {
    CFTimeInterval maxDT = CGFLOAT_MIN;
    CFTimeInterval avgDT = 0.0f;
    for( NSUInteger i=0; i<=_historyDTLength; i++ ){
        maxDT = MAX(maxDT, _historyDT[i]);
        avgDT += _historyDT[i];
    }
    avgDT /= _historyDTLength;
    UIColor *fpsColor;
//    CFTimeInterval minFPS = roundf(1.0f /(float)maxDT);
    CFTimeInterval avgFPS = roundf(1.0f /(float)avgDT);
    if (avgFPS > 40.f) {
        fpsColor = [UIColor greenColor];
    }
    else if (avgFPS > 20.f) {
        fpsColor = [UIColor yellowColor];
    }
    else {
        fpsColor = [UIColor redColor];
    }
    NSString *text = [NSString stringWithFormat:@"%.fFPS", avgFPS];
    self.text = text;
    self.textColor = fpsColor;
    _lastUIUpdateTime = _displayLinkTickTimeLast;
}


@end
