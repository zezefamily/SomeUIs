//
//  RadialView.h
//  SomeUIs
//
//  Created by zezefamily on 15/7/16.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RadialView : UIView

@property (nonatomic, strong) UIImage *completedImage;
@property (nonatomic, strong) UIImage *incompletedImage;

// Whether the progress is drawn clockwise (YES) or anticlockwise (NO)
@property (assign, nonatomic) BOOL clockwise;

// The total number of steps in the progress view.
@property (assign, nonatomic) NSUInteger totalSlice;

// The index of the slice where the first completed step is.
@property (assign, nonatomic) NSUInteger startSlice;

// The number of steps currently completed.
@property (assign, nonatomic) NSUInteger currentSlice;

- (void)setCurrentSlice:(NSUInteger)slice animation:(BOOL)animation;

@end
