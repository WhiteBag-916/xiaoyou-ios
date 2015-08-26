//
//  GroupInfoCollectionViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupInfoCollectionViewCell.h"
#import "UIImageView+Ext.h"

#define kHeadImageViewHeight            50
#define kHeadImageViewToTop             7
#define kNameLabelToHeadImage           5
#define kDeleteButtonHeightAndWodth     17

NSString *const kGroupInfoCollectionViewCell = @"GroupInfoCollectionViewCellId";

@interface GroupInfoCollectionViewCell ()

@property (nonatomic,strong)UIImageView * headImageView;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UIButton * deleteButton;
@property (nonatomic,strong)UILongPressGestureRecognizer * longPressGestureRecognizer;
@property (nonatomic,strong)UITapGestureRecognizer * tapGestureRecognizer;

@end

@implementation GroupInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        _headImageView = [[UIImageView alloc] init];
        _headImageView.userInteractionEnabled = YES;
        [self.contentView addSubview:_headImageView];
        [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.mas_equalTo(kHeadImageViewToTop);
            make.centerX.equalTo(self.contentView);
            make.height.width.mas_equalTo(kHeadImageViewHeight);
        }];
        
        _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress)];
        _longPressGestureRecognizer.minimumPressDuration = 1.0;
        [_headImageView addGestureRecognizer:_longPressGestureRecognizer];
        
        _tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap)];
        [_headImageView addGestureRecognizer:_tapGestureRecognizer];
        
        _deleteButton = [[UIButton alloc] init];
        [_deleteButton setBackgroundImage:[UIImage imageNamed:@"delete-member"] forState:UIControlStateNormal];
        [_deleteButton addTarget:self action:@selector(clickdeleteButton) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:_deleteButton];
        [_deleteButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(0);
            make.height.width.mas_equalTo(kDeleteButtonHeightAndWodth);
        }];
        _deleteButton.hidden = YES;
        
        _nameLabel = [[UILabel alloc] init];
        _nameLabel.font = CONTENT_FONT(12);
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_nameLabel];
        [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_headImageView.mas_bottom).offset(kNameLabelToHeadImage);
            make.left.right.bottom.mas_equalTo(0);
        }];
    }
    return self;
}

-(void)setCellInfo:(NSDictionary *) groupDic
{
    
    if ([groupDic[@"headPic"] isEqualToString:@""]) {
        _headImageView.image = [UIImage imageNamed:@"group_default_head"];
        _nameLabel.text = groupDic[@"name"];
    }
    else
    {
//        _headImageView.image = [UIImage imageNamed:@"group_add"];
//        [_headImageView removeGestureRecognizer:_longPressGestureRecognizer];
//        [_headImageView removeGestureRecognizer:_tapGestureRecognizer];
        [_headImageView setFaceImageWithUrl:groupDic[@"headPic"]];
        _nameLabel.text = groupDic[@"name"];
    }
    
}

-(void)longPress
{
    _deleteButton.hidden = NO;
}

-(void)tap
{
    _deleteButton.hidden = YES;
}

-(void)clickdeleteButton
{
    NSLog(@"delete");
}

@end
