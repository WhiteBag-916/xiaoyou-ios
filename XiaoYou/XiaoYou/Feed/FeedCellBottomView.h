//
//  FeedCellBottomView.h
//  XiaoYou
//
//  Created by 李思良 on 15/8/17.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FeedCellBottomModel : NSObject
@property (nonatomic, copy  )   NSString *feedId;
@property (nonatomic, assign)   int commentNum;
@property (nonatomic, assign)   int respectNum;
@property (nonatomic, copy  )   NSArray *people;
@property (nonatomic, assign)   BOOL hasRespected;
@end

@interface FeedCellBottomView : UIView

@property (nonatomic, strong, readonly) UIImageView *shareButton;             //分享按钮
@property (nonatomic, strong, readonly) UILabel *commentNum;                  //评论数
@property (nonatomic, strong, readonly) UILabel *respectNum;                  //敬酒数
@property (nonatomic, strong, readonly) UIImageView *respectImg;              //敬酒按钮
@property (nonatomic, strong, readonly) UIView *personList;                   //敬酒人
@property (nonatomic, strong, readonly) FeedCellBottomModel *data;            //数据

- (id)initWithType:(int)type;

- (void)setData:(FeedCellBottomModel *)data;

@end
