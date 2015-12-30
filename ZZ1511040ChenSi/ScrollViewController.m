//
//  ScrollViewController.m
//  ZZ1511040ChenSi
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 陈思. All rights reserved.
//

#import "ScrollViewController.h"

@interface ScrollViewController () <UIScrollViewDelegate> {
    NSArray *_dataArray;
    UIScrollView *_scrollView;
    UIPageControl *_pageControl;
}

@end

@implementation ScrollViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self createView];
    [self initData];
    [self creatrPage];
}

- (void)initData {
    UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, _scrollView.frame.size.height)];
    NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"image%d",7] ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    [_scrollView addSubview:imageView];
    for (int i = 0; i < 7; i++) {
        UIImageView *imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*(i+1), 0, self.view.frame.size.width, _scrollView.frame.size.height)];
        NSString *imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"image%d",i+1] ofType:@"jpg"];
        imageView.image = [UIImage imageWithContentsOfFile:imagePath];
        [_scrollView addSubview:imageView];
    }
    
    imageView = [[UIImageView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*8, 0, self.view.frame.size.width, _scrollView.frame.size.height)];
    imagePath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"image%d",1] ofType:@"jpg"];
    imageView.image = [UIImage imageWithContentsOfFile:imagePath];
    [_scrollView addSubview:imageView];
    
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
    _scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
    
    _scrollView.contentSize = CGSizeMake(self.view.frame.size.width*9, 226);
}

- (void)createView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 84, self.view.frame.size.width, 226)];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    [self.view addSubview:_scrollView];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
    [self.view addGestureRecognizer:tap];
}

- (void)tapAction:(UITapGestureRecognizer *)tap {
    
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"点击了第%ld张图片",_pageControl.currentPage+1] message:nil delegate:self cancelButtonTitle:@"cancle" otherButtonTitles:@"OK", nil];
    [alertView show];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.contentOffset.x == 0) {
        scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width*7, 0);
    }
    if (scrollView.contentOffset.x == 8*_scrollView.frame.size.width) {
        scrollView.contentOffset = CGPointMake(_scrollView.frame.size.width, 0);
    }
    
    CGPoint offSet = scrollView.contentOffset;
    NSInteger index = offSet.x/scrollView.frame.size.width + 0.5;
    _pageControl.currentPage = index-1;
    
}

- (void)creatrPage {
    _pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.view.frame.size.width-100-10, 64, 100, 20)];
    _pageControl.numberOfPages = 7;
    
    _pageControl.currentPageIndicatorTintColor = [UIColor purpleColor];
    
    _pageControl.pageIndicatorTintColor = [UIColor grayColor];
//    [_pageControl addTarget:self action:@selector(changeValue:) forControlEvents:UIControlEventEditingChanged];
    [self.view addSubview:_pageControl];
}

//- (void)changeValue:(UIPageControl *)pageControl {
//    
//}



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
