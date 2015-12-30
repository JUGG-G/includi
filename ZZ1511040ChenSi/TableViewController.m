//
//  TableViewController.m
//  ZZ1511040ChenSi
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 陈思. All rights reserved.
//

#import "TableViewController.h"
#import "MyCell.h"
#import "NewViewController.h"

@interface TableViewController () <UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate> {
    UITableView *_tableView;
    NSArray *_dataArray;
    UIScrollView *_scrollView;
    NSArray *_nameArray;
    CGFloat _screenWidth;
    UIButton *_button;
    UILabel *_Label;
    UIScrollView *_bigScrollView;
    CGFloat _jilu;
}

@end

@implementation TableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.automaticallyAdjustsScrollViewInsets = NO;
    // Do any additional setup after loading the view.
    [self createBigScrollView];
    [self initData];
    [self createTableView];
    [self createScrollView];
    [self addButton];
    [self addTableView];
}

- (void)initData {
    NSString *plistPath = [[NSBundle mainBundle] pathForResource:@"bookData" ofType:@"plist"];
    _dataArray = [[NSArray alloc] initWithContentsOfFile:plistPath];
}

- (void)createScrollView {
    _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 40)];
    _scrollView.backgroundColor = [UIColor whiteColor];
    _scrollView.delegate = self;
    [self.view addSubview:_scrollView];
}

- (void)createBigScrollView {
    _bigScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height)];
    _bigScrollView.delegate = self;
    _bigScrollView.contentSize = CGSizeMake(6*self.view.frame.size.width, self.view.frame.size.height);
    _bigScrollView.pagingEnabled = YES;
    _bigScrollView.showsHorizontalScrollIndicator = NO;
    _bigScrollView.showsVerticalScrollIndicator = NO;
    _bigScrollView.alwaysBounceHorizontal = NO;
    [self.view addSubview:_bigScrollView];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView {
    if (scrollView == _bigScrollView) {
        NSInteger index = _bigScrollView.contentOffset.x/self.view.frame.size.width;
        UIButton *button = (UIButton *)[self.view viewWithTag:index+100];
        _button.selected = NO;
        _button.transform = CGAffineTransformMakeScale(1, 1);
        button.selected = YES;
        _button = button;
        _button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView == _bigScrollView) {
        [UIView animateWithDuration:0.5 animations:^{
            _Label.frame = CGRectMake(scrollView.contentOffset.x/_bigScrollView.frame.size.width*_screenWidth, CGRectGetMaxY(_button.frame)-1, _screenWidth, 2);
        }];
    }
}

- (void)addTableView {
    for (int i = 0; i < _nameArray.count - 1; i++) {
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(self.view.frame.size.width*(i+1), 64, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.delegate = self;
        tableView.dataSource = self;
        [_bigScrollView addSubview:tableView];
    }
}

- (void)addButton {
    _nameArray = @[@"头条",@"热点",@"科技",@"移动互联网",@"财经",@"图片"];
    _screenWidth = self.view.frame.size.width/4;
    for (int i = 0; i < _nameArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        button.frame = CGRectMake(_screenWidth*i, 0, _screenWidth, 35);
        [button setTitle:_nameArray[i] forState:UIControlStateNormal];
        [button setTitleColor:[UIColor redColor] forState:UIControlStateSelected];
        [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 100 + i;
        [_scrollView addSubview:button];
        if (i == 0) {
            button.selected = YES;
            _button = button;
            _button.transform = CGAffineTransformMakeScale(1.1, 1.1);
            _Label = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(button.frame)-1, _screenWidth, 2)];
            _Label.backgroundColor = [UIColor redColor];
            [_scrollView addSubview:_Label];
        }
    }
    _scrollView.contentSize = CGSizeMake(_screenWidth*_nameArray.count, 40);
    _scrollView.showsHorizontalScrollIndicator = NO;
}

- (void)buttonClick:(UIButton *)button {
    if (_button == button) {
        return;
    }
    button.selected = YES;
    _button.selected = NO;
    _button.transform = CGAffineTransformMakeScale(1, 1);
    _button = button;
    _button.transform = CGAffineTransformMakeScale(1.1, 1.1);
    [UIView animateWithDuration:0.5 animations:^{
        _Label.frame = CGRectMake(CGRectGetMinX(_button.frame), CGRectGetMaxY(_button.frame)-1, _screenWidth, 2);
    }];
    [UIView animateWithDuration:0.5 animations:^{
        _bigScrollView.contentOffset = CGPointMake(self.view.frame.size.width*(button.tag-100), 0);
    }];
}

- (void)createTableView {
    _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height-64-40) style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [_bigScrollView addSubview:_tableView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == _tableView) {
        return _dataArray.count;
    }
    return 8;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView != _tableView) {
        return 40;
    }
    return [self heightForRow:_dataArray[indexPath.row][@"detail"] font:[UIFont boldSystemFontOfSize:20] labelSize:CGSizeMake(CGRectGetWidth(self.view.frame)-80, MAXFLOAT)];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if ([_button.titleLabel.text isEqualToString:@"头条"]) {
        NewViewController *newView = [NewViewController new];
        newView.text = _dataArray[indexPath.row][@"detail"];
        [self.navigationController pushViewController:newView animated:YES];
    }
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

- (CGFloat)heightForRow:(NSString *)aString font:(UIFont *)font labelSize:(CGSize)labelSize {
    CGSize size = [aString sizeWithFont:font constrainedToSize:labelSize lineBreakMode:NSLineBreakByTruncatingTail];
    return size.height + 10 + 20 + 20 +10;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (tableView == _tableView) {
        static NSString *identifier = @"identifier";
        MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        if (cell == nil) {
            cell = [[MyCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        cell.model = _dataArray[indexPath.row];
        
        return cell;
    }
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@%ld",_nameArray[(int)tableView.frame.origin.x/(int)self.view.frame.size.width],indexPath.row];
    return cell;
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
