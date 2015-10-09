//
//  TagListView.m
//  XiaoYou
//
//  Created by sheng on 15/9/30.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TagListView.h"
#import "TagCollectionCell.h"
#import "ConnectTag.h"
#import "Tags.h"

#define REUSECELL @"taglistcell"
@interface TagListView ()
<UICollectionViewDataSource,UICollectionViewDelegate>

@property (nonatomic,strong) UIImageView    *flagImageView;//🚩图
@property (nonatomic,strong) UILabel        *classLabel;//班级
@property (nonatomic,strong) UILabel        *commLabel;//
@property (nonatomic,strong) UILabel        *fellowLable;
@property (nonatomic,strong) UICollectionView *tagCollectionView;

@property (nonatomic,strong) ConnectTag     *connectTag;
@property (nonatomic,strong) NSMutableArray * commonTagsArr;

@end

@implementation TagListView

-(instancetype)init {
    if (self = [super init]) {
        [self initView];
    }
    return self;
}

-(void)initView {
    _flagImageView = [[UIImageView alloc]init];
    [self addSubview:_flagImageView];
    _flagImageView.image = [UIImage imageNamed:@"tag-green"];
    [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(10);
        make.leading.mas_equalTo(10);
        make.width.mas_equalTo(30);
        make.height.mas_equalTo(30);
    }];
    
//    _classLabel = [[UILabel alloc]init];
//    [self addSubview:_classLabel];
//    _classLabel.text = @"班";
//    _classLabel.backgroundColor = [UIColor greenColor];
//    _classLabel.textAlignment = NSTextAlignmentCenter;
//    [_classLabel setTextColor:[UIColor whiteColor]];
//    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_flagImageView.mas_right).offset(10);
//        make.top.equalTo(_flagImageView.mas_top);
//        make.width.equalTo(_flagImageView);
//        make.height.equalTo(_flagImageView);
//    }];
//    
//    _commLabel = [[UILabel alloc]init];
//    [self addSubview:_commLabel];
//    _commLabel.text = @"社";
//    _commLabel.backgroundColor = [UIColor greenColor];
//    _commLabel.textAlignment = NSTextAlignmentCenter;
//    [_commLabel setTextColor:[UIColor whiteColor]];
//    [_commLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_classLabel.mas_right).offset(10);
//        make.top.equalTo(_classLabel.mas_top);
//        make.width.equalTo(_classLabel);
//        make.height.equalTo(_classLabel);
//    }];
//    
//    _fellowLable = [[UILabel alloc]init];
//    _fellowLable.text = @"乡";
//    _fellowLable.backgroundColor = [UIColor greenColor];
//    _fellowLable.textAlignment = NSTextAlignmentCenter;
//    [_fellowLable setTextColor:[UIColor whiteColor]];
//    [self addSubview:_fellowLable];
//    [_fellowLable mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(_commLabel.mas_right).offset(10);
//        make.top.equalTo(_commLabel.mas_top);
//        make.width.equalTo(_commLabel);
//        make.height.equalTo(_commLabel);
//    }];
//    [self.tagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(_classLabel.mas_bottom).offset(10);
//        make.left.equalTo(_classLabel.mas_left);
//        make.trailing.mas_equalTo(0);
//        make.height.mas_equalTo(100);
//    }];
    _connectTag = [[ConnectTag alloc] init];
    [self addSubview:_connectTag];
    [_connectTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_flagImageView.mas_right).offset(10);
        make.top.equalTo(self).offset(10);
    }];
    [self.tagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_connectTag).offset(30);
        make.left.equalTo(_connectTag.mas_left);
        make.trailing.mas_equalTo(0);
        make.height.mas_equalTo(100);
    }];
    
    //共同标签
    NSMutableArray * propetiesCommonArr = [[NSMutableArray alloc] init];
    for (int i = 0; i < 3; i++)
    {
        [propetiesCommonArr addObject:[[Tags alloc]initWithDictionary:@{@"name":@"班"}]];
    }
    [_connectTag updateWithTag:propetiesCommonArr];
    
    _commonTagsArr = [[NSMutableArray alloc] initWithArray:@[@"哈哈哈",@"哈哈哈哈哈哈",@"哈哈",@"哈哈哈哈",@"哈哈哈哈哈哈哈哈",@"哈哈哈哈哈哈",@"哈哈哈哈哈sfbabgasogbasoig哈",@"哈哈saga哈哈哈哈",@"哈哈哈哈哈哈",@"哈哈哈sagasgsagasgdagdgadg哈哈哈",@"哈哈f哈哈哈哈",@"哈哈哈fdfa哈哈哈"]];
}


-(UICollectionView *)tagCollectionView {
    if (!_tagCollectionView) {
        _tagCollectionView.backgroundColor = [UIColor redColor];
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
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
    return 5;
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    TagCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSECELL forIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:20]};
    CGSize textSize = [_commonTagsArr[indexPath.row] boundingRectWithSize:CGSizeMake(100, 20) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    return CGSizeMake(textSize.width, 14);
}
//定义每个UICollectionView 的 margin
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
@end
