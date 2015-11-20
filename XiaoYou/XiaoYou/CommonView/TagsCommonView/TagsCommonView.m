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
#import "Author.h"

#define REUSECELL @"taglistcell"
#define kFlagImageViewWidth            SCALE_NUM(11)
#define kFlagImageViewHeight           SCALE_NUM(14)
#define kPaddingDistance               SCALE_NUM(10)

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
    //这行创建和设置背景颜色
    self.tagCollectionView.backgroundColor = [UIColor clearColor];
    [_connectTag updateWithTag:_model.propetiesCommon];
    
}



- (void)setData:(id) model
{
    [_tagCollectionView removeFromSuperview];
    _tagCollectionView = nil;
    [self tagCollectionView];
    
    
    if ([model isKindOfClass:[ProfileInfo class]]) {
        _model = model;
    } else if ([model isKindOfClass:[Author class]]) {
        Author *author = model;
        _model = [[ProfileInfo alloc]init];
        _model.tagsCommon = author.tagsCommon;
        _model.propetiesCommon = author.propetiesCommon;
    }
    
    NSUInteger propetiesCount = _model.propetiesCommon.count;
    NSUInteger tagsCount = _model.tagsCommon.count;
    
    BOOL noData = (propetiesCount == 0) && (tagsCount == 0);
    _flagImageView.image = noData ? nil : [UIImage imageNamed:@"detail_flag_new"];
    
    _connectTag.hidden = (propetiesCount == 0);
    if (propetiesCount == 0)
    {
        [self.tagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            int offset = tagsCount == 0 ? 0 : (kPaddingDistance / 2);
            make.top.equalTo(self).offset(offset);
            make.left.equalTo(_connectTag.mas_left).offset(-kPaddingDistance/2);
            make.trailing.mas_equalTo(0);
            make.bottom.equalTo(self);
        }];
    }
    
    [_connectTag updateWithTag:_model.propetiesCommon];
    _commonTagsArr = [NSMutableArray arrayWithArray:_model.tagsCommon];
    [_tagCollectionView reloadData];
    
}

-(UICollectionView *)tagCollectionView {
    if (!_tagCollectionView) {
        _tagCollectionView.backgroundColor = [UIColor clearColor];
        MyFlowLayout *layout = [[MyFlowLayout alloc]init];
        layout.minimumInteritemSpacing = SCALE_NUM(10);
        _tagCollectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:layout];
        [self addSubview:_tagCollectionView];
        _tagCollectionView.scrollEnabled = NO;
        _tagCollectionView.dataSource = self;
        _tagCollectionView.delegate = self;
        _tagCollectionView.backgroundColor = [UIColor colorWithRed:246.0/255 green:247.0/255 blue:249.0/255 alpha:0];
        [_tagCollectionView registerClass:[TagCollectionCell class] forCellWithReuseIdentifier:REUSECELL];
        
        [_tagCollectionView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_connectTag.mas_bottom).offset(SCALE_NUM(5));
            make.left.equalTo(_connectTag.mas_left).offset(-kPaddingDistance/2);
            make.trailing.mas_equalTo(0);
            make.bottom.equalTo(self);
        }];
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
    TagCollectionCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:REUSECELL forIndexPath:indexPath];
    [cell setCellInfo:tag];
    return cell;
}


#pragma mark --UICollectionViewDelegateFlowLayout
//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    Tags * tag = _commonTagsArr[indexPath.row];
    NSDictionary *attributes = @{NSFontAttributeName:CONTENT_FONT(10)};
    CGSize textSize = [tag.name boundingRectWithSize:CGSizeMake(SCALE_NUM(300), SCALE_NUM(20)) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    return CGSizeMake(SCALE_NUM(textSize.width+15), SCALE_NUM(15));
}
//定义每个UICollectionView 的间距（返回UIEdgeInsets：上、左、下、右）
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(SCALE_NUM(5), SCALE_NUM(5), SCALE_NUM(5), SCALE_NUM(5));
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
    return SCALE_NUM(8);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    return SCALE_NUM(5);
}


+ (CGFloat)calculatorHeightByTagsCommon:(NSArray<Tags*> *)tagsCommon propetiesCommon:(NSArray<Tags*> *)propetiesCommon
{
    CGFloat height,width = 0.0;
    NSInteger tagsCount = tagsCommon.count;
    NSInteger propetiesCount = propetiesCommon.count;
    //1.没有任何标签 2.只有关系标签
    if (tagsCount == 0 && propetiesCount == 0) return 0;
    if (tagsCount == 0 && propetiesCount > 0) return SCALE_NUM(45);
    height = propetiesCount == 0 ? SCALE_NUM(45) : SCALE_NUM(70);
    
    NSDictionary *attributes = @{NSFontAttributeName:CONTENT_FONT(10)};
    CGFloat  limitWidth = SCREEN_WIDTH - SCALE_NUM(124);//SCREEN_WIDTH - SCALE_NUM(115);
    for (int i = 0; i < tagsCount; i++)
    {
        Tags * tag = tagsCommon[i];
        CGSize textSize = [tag.name boundingRectWithSize:CGSizeMake(SCALE_NUM(300), SCALE_NUM(15)) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
        //文本宽度 ＋ 前置空白行 ＋ 标签间距
        width += textSize.width + SCALE_NUM(15) + SCALE_NUM(5);
        if (width > limitWidth)
        {
            height += SCALE_NUM(20);
            width = textSize.width + SCALE_NUM(15);
        }
    }
    return height;
}
@end
