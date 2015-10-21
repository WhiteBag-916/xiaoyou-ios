//
//  TypeCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "TypeCollectionViewCell.h"
#import "TypeDetailCollectionView.h"

NSString *const kTypeCollectionViewCell = @"TypeCollectionViewCellId";

@interface TypeCollectionViewCell ()

@property (nonatomic,strong) TypeDetailCollectionView * collectionView;

@end

@implementation TypeCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changUI];
    }
    return self;
}

-(void)changUI
{
    //设置每个cell的不同部分
    self.numImageView.image = [UIImage imageNamed:@"img_num5"];
    self.typeLabel.text = @"类型";
    
    //顶部提示文字
    UILabel * topLabel = [[UILabel alloc] init];
    topLabel.backgroundColor = [UIColor clearColor];
    topLabel.font = CONTENT_FONT(12);
    topLabel.textColor = KCOLORGREEN_B3;
    topLabel.text = @"在这里选择活动类型:";
    [self.backView addSubview:topLabel];
    [topLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(80));
        make.left.equalTo(self.numImageView);
        make.height.mas_equalTo(SCALE_NUM(12));
        make.right.equalTo(self.backView.mas_right).offset(SCALE_NUM(-12));
    }];
    
    //CollectionView
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc]init];
//    layout.minimumInteritemSpacing = 5;
//    layout.minimumLineSpacing = 5;
    layout.scrollDirection = UICollectionViewScrollDirectionVertical;
    _collectionView = [[TypeDetailCollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    _collectionView.backgroundColor = [UIColor clearColor];
    [self.backView addSubview:_collectionView];
    [_collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(topLabel.mas_bottom).offset(SCALE_NUM(12));
        make.width.left.equalTo(topLabel);
        make.bottom.equalTo(self.backView.mas_bottom).offset(SCALE_NUM(-12));
    }];
    
}

@end
