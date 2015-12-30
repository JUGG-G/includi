//
//  MyCell.m
//  ZZ1511040ChenSi
//
//  Created by qianfeng on 15/9/7.
//  Copyright (c) 2015年 陈思. All rights reserved.
//

#import "MyCell.h"

@implementation MyCell {
    UILabel *_titleLabel;
    UILabel *_detailLabel;
    UILabel *_priceLabel;
    UIImageView *_iconImageView;
    UILabel *_aLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self customViews];
        //        self.contentView.backgroundColor = [UIColor redColor];
        //        NSLog(@"%@",NSStringFromCGRect(self.frame));
    }
    return self;
}
- (void)customViews {
    _iconImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 60, 60)];
    [self.contentView addSubview:_iconImageView];
    
    _titleLabel = [UILabel new];
    [self.contentView addSubview:_titleLabel];
    
    _detailLabel = [UILabel new];
    _detailLabel.numberOfLines = 0;
    _detailLabel.font = [UIFont systemFontOfSize:20];
    [self.contentView addSubview:_detailLabel];
    
    _priceLabel = [UILabel new];
    [self.contentView addSubview:_priceLabel];
    
    _aLabel = [UILabel new];
    _aLabel.backgroundColor = [UIColor grayColor];
    [self addSubview:_aLabel];
}
- (CGFloat)heightForRow:(NSString *)aString font:(UIFont *)font labelSize:(CGSize)labelSize {
    CGSize size = [aString sizeWithFont:font constrainedToSize:labelSize lineBreakMode:NSLineBreakByTruncatingTail];
    return size.height;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    _aLabel.frame = CGRectMake(0, CGRectGetHeight(self.contentView.frame)-1, CGRectGetWidth(self.contentView.frame), 1);
    
    
    _titleLabel .frame = CGRectMake(CGRectGetMaxX(_iconImageView.frame) + 10, 10, CGRectGetWidth(self.contentView.frame) - 60 - 10 - 10, 20);
    
    CGFloat detailHeight = [self heightForRow:_detailLabel.text font:[UIFont boldSystemFontOfSize:20] labelSize:CGSizeMake(CGRectGetWidth(self.contentView.frame) - 80, MAXFLOAT)];
    
    _detailLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_titleLabel.frame), CGRectGetWidth(_titleLabel.frame), detailHeight);
    _priceLabel.frame = CGRectMake(CGRectGetMinX(_titleLabel.frame), CGRectGetMaxY(_detailLabel.frame), CGRectGetWidth(_titleLabel.frame), 20);
    
    _iconImageView.frame = CGRectMake(10, (self.contentView.frame.size.height-60)/2, 60, 60);
}

- (void)setModel:(NSDictionary *)model {
    _model = model;
    [self reloadCell];
}

- (void)reloadCell {
    _titleLabel.text = _model[@"title"];
    _detailLabel.text = _model[@"detail"];
    _priceLabel.text = _model[@"price"];
    NSArray *x = [_model[@"icon"] componentsSeparatedByString:@"."];
    NSString *imagepath = [[NSBundle mainBundle] pathForResource:[x[0] stringByAppendingString:@"@2x"] ofType:x[1]];
    _iconImageView.image = [[UIImage alloc] initWithContentsOfFile:imagepath];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
