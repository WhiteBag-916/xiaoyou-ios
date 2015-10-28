//
//  TagsCommonView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/8.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TagsCommonView.h"
#import "ConnectTag.h"
#import "Tags.h"
#import "TagCollectionCell.h"
#import "MyFlowLayout.h"

#define REUSECELL @"taglistcell"
#define kFlagImageViewWidth            11
#define kFlagImageViewHeight           14
#define kPaddingDistance               10

@interface TagsCommonView ()<UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>

@property (nonatomic,strong) UIImageView    *flagImageView;//🚩图
@property (nonatomic,strong) UICollectionView *tagCollectionView;

@property (nonatomic,strong) ConnectTag     *connectTag;
@property (nonatomic,strong) NSMutableArray * commonTagsArr;


@end

@implementation TagsCommonView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self setUpUI];
        [_tagCollectionView registerClass:[TagCollectionCell class] forCellWithReuseIdentifier:REUSECELL];
    }
    return self;
}

-(void)setUpUI
{
    self.backgroundColor = [UIColor clearColor];
    _flagImageView = [[UIImageView alloc]init];
    [self addSubview:_flagImageView];
    [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(kPaddingDistance);
        make.leading.mas_equalTo(0);
        make.width.mas_equalTo(kFlagImageViewWidth);
        make.height.mas_equalTo(kFlagImageViewHeight);
    }];
    
    _connectTag = [[ConnectTag alloc] init];
    [self addSubview:_connectTag];
    [_connectTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_flagImageView.mas_right).offset(kPaddingDistance);
        make.top.equalTo(self).offset(kPaddingDistance);
    }];
    [self.tagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_connectTag.mas_bottom).offset(5);
        make.left.equalTo(_connectTag.mas_left).offset(-kPaddingDistance/2);
        make.trailing.mas_equalTo(0);
//        make.height.mas_equalTo(height);
        make.bottom.equalTo(self);
    }];
    _tagCollectionView.backgroundColor = [UIColor clearColor];
    
    [_connectTag updateWithTag:_model.propetiesCommon];
    
}

- (void)setData:(ProfileInfo *) model
{
    if (model.propetiesCommon.count <=0 && model.tagModels.count <= 0)
    {
        _flagImageView.image = nil;
    }
    else
    {
        _flagImageView.image = [UIImage imageNamed:@"detail_flag_new"];
    }
    [_connectTag updateWithTag:model.propetiesCommon];
    _commonTagsArr = [NSMutableArray arrayWithArray:model.tagModels];
    [_tagCollectionView reloadData];
}

-(UICollectionView *)tagCollectionView {
    if (!_tagCollectionView) {
        _tagCollectionView.backgroundColor = [UIColor clearColor];
        MyFlowLayout *layout = [[MyFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 10;
        _tagCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_tagCollectionView];
        _tagCollectionView.scrollEnabled = NO;
        _tagCollectionView.dataSource = self;
        _tagCollectionView.delegate = self;
        _tagCollectionView.backgroundColor = [UIColor colorWithRed:246.0/255 green:247.0/255 blue:249.0/255 alpha:0];
        [_tagCollectionView registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:REUSECELL];
    }
    return _tagCollectionView;
}

#pragma mark CollectionView的协议方法
//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _commonTagsArr.count;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Tags * tag = _commonTagsArr[indexPath.row];
    
    TagCollectionCell *cell;
    if (cell == nil) {
        cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSECELL forIndexPath:indexPath];
    }
    else
    {
        //删除cell的所有子视图
        while ([cell.contentView.subviews lastObject] != nil)
        {
            [(UIView*)[cell.contentView.subviews lastObject] removeFromSuperview];
        }
    }
    [cell setCellInfo:tag];
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Tags * tag = _commonTagsArr[indexPath.row];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10]};
    CGSize textSize = [tag.name boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    return CGSizeMake(textSize.width+15, 14);
}
//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(5, 5, 5, 5);
}
#pragma mark --UICollectionViewDelegate
//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
}
//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

#pragma mark --UICollectionViewDelegateFlowLayout

//定义每个UICollectionView 纵向的间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    return 10;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return 6;
}


@end
