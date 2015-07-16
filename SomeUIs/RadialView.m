//
//  RadialView.m
//  SomeUIs
//
//  Created by zezefamily on 15/7/16.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import "RadialView.h"

@interface RadialView ()

@property (nonatomic, strong) UILabel *label;
@property (nonatomic, assign) NSUInteger drawSlice;
@property (nonatomic, strong) NSTimer *timer;

@end

@implementation RadialView

- (void)setCurrentSlice:(NSUInteger)currentSlice
{
    _currentSlice = currentSlice;
    self.drawSlice = _currentSlice;
    self.label.text = [NSString stringWithFormat:@"%lu\n分", (unsigned long)self.drawSlice];
    
    [self setNeedsDisplay];
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        self.totalSlice = 1;
        self.currentSlice = 0;
        self.startSlice = 0;
        self.clockwise = YES;
        
        self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(frame), CGRectGetHeight(frame))];
        self.label.backgroundColor = [UIColor clearColor];
        self.label.textAlignment = NSTextAlignmentCenter;
        self.label.font = [UIFont systemFontOfSize:16];
        self.label.numberOfLines = 2;
        self.label.textColor = [UIColor colorWithRed:255.0/255.0 green:89.0/255.0 blue:142.0/255.0 alpha:1];
//        kColorWithRGB(255.0f, 89.0f, 142.0f, 1.0f);
        [self addSubview:self.label];
    }
    
    return self;
}

#pragma mark - 重新绘图

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGSize viewSize = self.bounds.size;
    CGPoint center = CGPointMake(viewSize.width/2, viewSize.height/2);
    
    // Draw the incompletedImage.
    [self.incompletedImage drawInRect:self.bounds];
    
    CGFloat originAngle, endAngle;
    originAngle = 2*M_PI*((CGFloat)(self.startSlice)/(CGFloat)(self.totalSlice))-M_PI_2;
    endAngle = 2*M_PI*((CGFloat)(self.drawSlice)/(CGFloat)(self.totalSlice))-M_PI_2;
    
    // Completed slices.
    CGContextBeginPath(context);
    CGContextMoveToPoint(context, center.x, center.y);
    CGContextAddArc(context, center.x, center.y, center.x, originAngle, endAngle, !self.clockwise);
    CGContextClosePath(context);
    CGContextClip(context);
    
    [self.completedImage drawInRect:self.bounds];
}

#pragma mark - 对外接口方法

- (void)setCurrentSlice:(NSUInteger)slice animation:(BOOL)animation
{
    if ([self.timer isValid])
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    if (animation)
    {
        _currentSlice = slice;
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:0.01f
                                                      target:self
                                                    selector:@selector(drawAnimation:)
                                                    userInfo:nil
                                                     repeats:YES];
        [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
    }
    else
    {
        self.currentSlice = slice;
    }
}

#pragma mark - 内部方法

- (void)drawAnimation:(NSTimer *)timer
{
    if (self.drawSlice != self.currentSlice)
    {
        if (self.drawSlice < self.currentSlice)
        {
            self.drawSlice += 1;
        }
        else
        {
            self.drawSlice -= 1;
        }
        self.label.text = [NSString stringWithFormat:@"%lu\n分", (unsigned long)self.drawSlice];
        
        [self setNeedsDisplay];
    }
    else
    {
        [self.timer invalidate];
        self.timer = nil;
    }
}



@end
