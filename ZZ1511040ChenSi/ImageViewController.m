//
//  ImageViewController.m
//  ZZ1511040ChenSi
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 陈思. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController () {
    NSTimer *_timer;
    UIImageView *_imageVew;
    BOOL _isFire;
}

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake((self.view.frame.size.width - 100)/2, 20, 100, 44);
    [button setTitle:@"stop" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor grayColor] forState:UIControlStateHighlighted];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    self.navigationItem.titleView = button;
//    [self.view addSubview:button];
    
    NSMutableArray *ary = [NSMutableArray array];
    for (int i = 0; i < 18; i++) {
        UIImage *image = [UIImage imageWithContentsOfFile:[[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"DOVE %d",i+1] ofType:@"png"]];
        [ary addObject:image];
    }
    
    _imageVew = [[UIImageView alloc] initWithFrame:CGRectMake(-48, 300, 48, 60)];
    
    _imageVew.animationImages = ary;
    
    _imageVew.image = ary[0];
    
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(next:) userInfo:nil repeats:YES];
    
    [self.view addSubview:_imageVew];
}

- (void)next:(NSTimer *)timer {
    [_imageVew startAnimating];
//    NSLog(@"%lf",_imageVew.frame.origin.x);
    if (_imageVew.frame.origin.x >= self.view.frame.size.width) {
        _imageVew.frame = CGRectMake(-48, 64+arc4random()%((int)self.view.frame.size.height - 60 - 64 - 44), 48, 60);
//        NSLog(@"1");
    }
    [UIView animateWithDuration:0.1 animations:^{
        _imageVew.frame = CGRectMake(_imageVew.frame.origin.x+13, _imageVew.frame.origin.y, _imageVew.frame.size.width, _imageVew.frame.size.height);
    }];
}

- (void)buttonClick:(UIButton *)button {
    if (!_isFire) {
        [_timer setFireDate:[NSDate distantFuture]];
        [_imageVew stopAnimating];
        _isFire = !_isFire;
    } else {
        [_timer setFireDate:[NSDate distantPast]];
        [_imageVew startAnimating];
        _isFire = !_isFire;
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
