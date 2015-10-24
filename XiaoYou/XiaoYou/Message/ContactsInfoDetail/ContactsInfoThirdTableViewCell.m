//
//  ContactsInfoThirdTableViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/9.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ContactsInfoThirdTableViewCell.h"
#import "ContactManager.h"

NSString *const kContactsInfoThirdTableViewCell = @"ContactsInfoThirdTableViewCellId";

@interface ContactsInfoThirdTableViewCell ()

@property(nonatomic,strong)UIImageView * toastImageView;
@property(nonatomic,strong)UILabel * toastLabel;

@property(nonatomic,strong)UIImageView * coolImageView;
@property(nonatomic,strong)UILabel * coolLabel;

@end

@implementation ContactsInfoThirdTableViewCell

- (void)awakeFromNib {
    // Initialization code
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setUpUI];
    }
    return self;
}

-(void)setUpUI
{
    UIView * backView = [[UIView alloc] init];
    backView.backgroundColor = [UIColor hexChangeFloat:@"F9F9F9"];
    
    //敬酒
    _toastImageView = [[UIImageView alloc] init];
    _toastImageView.image = [UIImage imageNamed:@"detail_toast_new"];
    [backView addSubview:_toastImageView];
    [_toastImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.left.mas_equalTo(12);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(13);
    }];
    
    _toastLabel = [[UILabel alloc] init];
    _toastLabel.font = CONTENT_FONT(12);
    _toastLabel.textColor = [UIColor hexChangeFloat:@"999999"];
    _toastLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_toastLabel];
    [_toastLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_toastImageView);
        make.left.equalTo(_toastImageView.mas_right).offset(13);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(14);
    }];
    
    //点赞
    _coolImageView = [[UIImageView alloc] init];
    _coolImageView.userInteractionEnabled = YES;
    [backView addSubview:_coolImageView];
    _coolImageView.image = [UIImage imageNamed:@"detail_cool_new"];
    [_coolImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_toastImageView.mas_bottom).offset(17);
        make.left.mas_equalTo(12);
        make.width.mas_equalTo(14);
        make.height.mas_equalTo(13);
    }];
    
    _coolLabel = [[UILabel alloc] init];
    _coolLabel.userInteractionEnabled = YES;
    _coolLabel.font = CONTENT_FONT(12);
    _coolLabel.textColor = [UIColor hexChangeFloat:@"999999"];
    _coolLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_coolLabel];
    [_coolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_coolImageView);
        make.left.equalTo(_coolImageView.mas_right).offset(13);
        make.right.mas_equalTo(-12);
        make.height.mas_equalTo(14);
    }];
    
    UITapGestureRecognizer * tapGestureRecognizer1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoolMethod)];
    UITapGestureRecognizer * tapGestureRecognizer2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapCoolMethod)];
    [_coolImageView addGestureRecognizer:tapGestureRecognizer1];
    [_coolLabel addGestureRecognizer:tapGestureRecognizer2];
    
    [self.contentView addSubview:backView];
    [backView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(-12);
        make.left.mas_equalTo(70);
        make.top.mas_equalTo(16);
        make.bottom.mas_equalTo(-16);
    }];
}
- (void)tapCoolMethod
{
    [_myDelegate didSelectCool];
    if (nil != _myDelegate && [_myDelegate respondsToSelector:@selector(didSelectCool)]) {
        ;
    }
}

-(void)setCellInfo:(ProfileInfo *) model
{
    _toastLabel.text = [NSString stringWithFormat:@"%g人向%@撰写的内容敬酒",model.praiseCount,model.userName];
    
    _coolLabel.text = [NSString stringWithFormat:@"%g人觉得%@很酷",model.coolCount,model.userName];
    if (model.isCool) {
        _coolImageView.image = [UIImage imageNamed:@"mine-heart-red"];
    } else {
        _coolImageView.image = [UIImage imageNamed:@"mine-heart"];
    }
}

@end
