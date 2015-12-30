//
//  NewViewController.m
//  ZZ1511040ChenSi
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 陈思. All rights reserved.
//

#import "NewViewController.h"

@interface NewViewController () {
    UILabel *_aLabel;
}

@end

@implementation NewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
}

- (void)setText:(NSString *)text {
    _aLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64
                                                        )];
    _aLabel.textAlignment = NSTextAlignmentCenter;
    _aLabel.font = [UIFont systemFontOfSize:20];
    _aLabel.numberOfLines = 0;
    [self.view addSubview:_aLabel];
    _text = text;
    _aLabel.text = _text;
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
