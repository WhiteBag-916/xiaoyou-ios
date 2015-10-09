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

- (instancetype)initWithCollectionViewHeight:(CGFloat) height
{
    self = [super init];
    if (self) {
        [self setUpUIWithCollectionViewHeight:height];
        [_tagCollectionView registerClass:[TagCollectionCell class] forCellWithReuseIdentifier:REUSECELL];
    }
    return self;
}

-(void)setUpUIWithCollectionViewHeight:(CGFloat) height
{
    self.backgroundColor = [UIColor magentaColor];
    _flagImageView = [[UIImageView alloc]init];
    [self addSubview:_flagImageView];
    _flagImageView.image = [UIImage imageNamed:@"tag-green"];
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
        make.top.equalTo(_connectTag.mas_bottom);
        make.left.equalTo(_connectTag.mas_left).offset(-kPaddingDistance/2);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(height);
//        make.bottom.equalTo(self);
    }];
    _tagCollectionView.backgroundColor = [UIColor grayColor];
    
    //共同标签
    NSMutableArray * propetiesCommonArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++)
    {
        [propetiesCommonArr addObject:[[Tags alloc]initWithDictionary:@{@"name":@"班"}]];
    }
    [_connectTag updateWithTag:propetiesCommonArr];
    
    _commonTagsArr = [[NSMutableArray alloc] initWithArray:@[@"考研",@"雅思",@"托福GRE",@"外资企业",@"铁饭碗攻略",@"代购导游",@"骑行"]];
}

-(UICollectionView *)tagCollectionView {
    if (!_tagCollectionView) {
        _tagCollectionView.backgroundColor = [UIColor redColor];
        MyFlowLayout *layout = [[MyFlowLayout alloc]init];
        layout.minimumInteritemSpacing = 10;
        _tagCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_tagCollectionView];
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
    TagCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSECELL forIndexPath:indexPath];
    cell.backgroundColor = [UIColor greenColor];
    cell.tagLabel.text = _commonTagsArr[indexPath.row];
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:10]};
    CGSize textSize = [_commonTagsArr[indexPath.row] boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    return CGSizeMake(textSize.width+5, 14);
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
