//
//  NavigationViewController.m
//  ZZ1511040ChenSi
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 陈思. All rights reserved.
//

#import "NavigationViewController.h"

@interface NavigationViewController () {
    NSInteger _i;
}

@end

@implementation NavigationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tabBarController.tabBar.hidden = _isYES;
    if (self.title == nil) {
        self.navigationItem.title = @"1";
    }
    self.view.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    _i = [self.navigationItem.title integerValue];
    [self createButton];
    [self addButton];
}

- (void)createButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(0, 0, 100, 50);
    button.center = self.view.center;
    [button setTitle:@"push" forState:UIControlStateNormal];
    button.backgroundColor = [UIColor purpleColor];
    [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}

- (void)addButton {
    for (int i = 0; i < _i-1; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(arc4random()%((int)self.view.frame.size.width-100), arc4random()%((int)self.view.frame.size.width-50), 100, 50);
        [button setTitle:[NSString stringWithFormat:@"%d",i+1] forState:UIControlStateNormal];
        button.layer.borderWidth = 1;
        button.layer.borderColor = [[UIColor whiteColor] CGColor];
        button.layer.cornerRadius = 5;
        button.backgroundColor = [UIColor clearColor];
        button.tag = i;
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(butonPop:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
}

- (void)butonPop:(UIButton *)button {
    NSArray *ary = [self.navigationController childViewControllers];
    UIViewController *aView = ary[button.tag];
    if (button.tag == 0) {
        aView.tabBarController.tabBar.hidden = NO;
    }
    [self.navigationController popToViewController:aView animated:YES];
}

- (void)buttonClick:(UIButton *)button {
    NavigationViewController *navigation = [NavigationViewController new];
    navigation.title = [NSString stringWithFormat:@"%ld",_i+1];
    navigation.isYES = YES;
    navigation.hidesBottomBarWhenPushed = NO;
    [self.navigationController pushViewController:navigation animated:YES];
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
