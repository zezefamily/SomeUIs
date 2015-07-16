//
//  ViewController.m
//  SomeUIs
//
//  Created by zezefamily on 15/7/16.
//  Copyright (c) 2015年 zezefamily. All rights reserved.
//

#import "ViewController.h"
#import "JEProgressView.h"
#import "RadialView.h"
@interface ViewController ()
{
    UISlider *_seliderView;
    
    UIProgressView *_progress;
    
    RadialView *_radialView;
    
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _seliderView = [[UISlider alloc]initWithFrame:CGRectMake(20, 50, self.view.frame.size.width-40, 25)];
    _seliderView.maximumValue = 100;
    _seliderView.minimumValue = 0;
    
    [_seliderView setThumbImage:[UIImage imageNamed:@"home_eat_thumb"] forState:UIControlStateNormal];
    [_seliderView setMinimumTrackImage:[[UIImage imageNamed:@"home_eat_maximum"]stretchableImageWithLeftCapWidth:6 topCapHeight:5] forState:UIControlStateNormal];
    ;
//    home_eat_minimum
    [_seliderView setMaximumTrackImage:[[UIImage imageNamed:@"home_eat_minimum"]stretchableImageWithLeftCapWidth:6 topCapHeight:5] forState:UIControlStateNormal];
    [_seliderView addTarget:self action:@selector(changeCellSlider:) forControlEvents:UIControlEventValueChanged];
    _seliderView.value = 50.0;
    [self.view addSubview:_seliderView];
    
    
    
    _progress = [[JEProgressView alloc]initWithFrame:CGRectMake(20, 100, self.view.frame.size.width-40, 25)];
    _progress.progressImage = [[UIImage imageNamed:@"home_eat_maximum"]stretchableImageWithLeftCapWidth:6 topCapHeight:5];
    _progress.trackImage = [[UIImage imageNamed:@"home_eat_minimum"]stretchableImageWithLeftCapWidth:6 topCapHeight:5];
    _progress.progress = .8;
    //[_progress setProgress:.8 animated:YES];
    
    [self.view addSubview:_progress];
    
    
    _radialView = [[RadialView alloc]initWithFrame:CGRectMake(20, 150, 200, 200)];
    _radialView.backgroundColor = [UIColor clearColor];
    _radialView.incompletedImage = [UIImage imageNamed:@"home_radial_incompleted"];
    _radialView.completedImage = [UIImage imageNamed:@"home_radial_completed"];
    _radialView.totalSlice = 100;
    //_radialView.currentSlice = 65;
    [_radialView setCurrentSlice:65 animation:YES];
    [self.view addSubview:_radialView];
    
    
    
    
    
}
- (void)changeCellSlider:(UISlider *)slider
{
    NSLog(@"value == %f",slider.value);
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
