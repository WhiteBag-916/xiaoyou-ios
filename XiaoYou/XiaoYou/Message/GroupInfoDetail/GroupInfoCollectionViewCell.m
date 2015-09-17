//
//  GroupInfoCollectionViewCell.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "GroupInfoCollectionViewCell.h"
#import "UIImageView+Ext.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"
#import "YNotificationDefine.h"
#import "Author.h"

#define kHeadImageViewHeight            50
#define kHeadImageViewToTop             3
#define kNameLabelToHeadImage           5
#define kDeleteButtonHeightAndWodth     17

NSString *const kGroupInfoCollectionViewCell = @"GroupInfoCollectionViewCellId";

@interface GroupInfoCollectionViewCell ()

@property (nonatomic,strong)UIImageView * headImageView;
@property (nonatomic,strong)UILabel * nameLabel;
@property (nonatomic,strong)UIButton * deleteButton;
@property (nonatomic,strong)UILongPressGestureRecognizer * longPressGestureRecognizer;

@end

@implementation GroupInfoCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        [self setUpUI];
        
    }
    return self;
}

-(void)setUpUI
{
    _headImageView = [[UIImageView alloc] init];
    _headImageView.userInteractionEnabled = YES;
    [self.contentView addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kHeadImageViewToTop);
        make.centerX.equalTo(self.contentView);
        make.height.width.mas_equalTo(kHeadImageViewHeight);
    }];
    
    _longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(longPress:)];
    _longPressGestureRecognizer.minimumPressDuration = .5;
    [_headImageView addGestureRecognizer:_longPressGestureRecognizer];
    
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

-(void)setCellInfo:(NSDictionary *) groupDic
{
    _nameLabel.hidden = NO;
    _modelDic = (NSMutableDictionary *)groupDic;
    if ([[groupDic[@"model"] dictionaryRepresentation][@"headPic"] isEqualToString:@""]) {
        _headImageView.image = [UIImage imageNamed:@"group_default_head"];
        _nameLabel.text = [groupDic[@"model"] dictionaryRepresentation][@"name"];
    }
    else
    {
        if ([[groupDic[@"model"] dictionaryRepresentation][@"name"] isEqualToString:@""])
        {
            _headImageView.image = [UIImage imageNamed:@"group_add"];
            _nameLabel.hidden = YES;
            
        }
        else
        {
            [_headImageView setFaceImageWithUrl:[groupDic[@"model"] dictionaryRepresentation][@"headPic"]];
            _nameLabel.text = [groupDic[@"model"] dictionaryRepresentation][@"name"];
        }
    }
    if ([groupDic[@"isDelete"] boolValue])
    {
        _deleteButton.hidden = NO;
    }
    else
    {
        _deleteButton.hidden = YES;
    }
    
}

#pragma mark - 长按cell事件
-(void)longPress:(UILongPressGestureRecognizer *)gesture
{
    if(gesture.state == UIGestureRecognizerStateBegan)
    {
        if (nil != _delegate && [_delegate respondsToSelector:@selector(longPressCell)]) {
            [_delegate longPressCell];
        }
    }

}
#pragma mark - 点击删除按钮事件
-(void)clickdeleteButton
{
    NSLog(@"delete");
    if (nil != _delegate && [_delegate respondsToSelector:@selector(delCell:)]) {
        [_delegate delCell:[_modelDic[@"model"] uid]];
    }
}

@end
