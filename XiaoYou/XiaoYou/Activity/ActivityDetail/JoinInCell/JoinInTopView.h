//
//  JoinInTopView.h
//  XiaoYou
//
//  Created by sheng on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "YView.h"
#import "Author.h"

@interface JoinInTopView : YView

@property (nonatomic,strong) UIImageView    *headImageView;
@property (nonatomic,strong) UILabel        *nameLabel;
@property (nonatomic,strong) UIImageView    *genderImageView;
@property (nonatomic,strong) UIButton       *addFriendImageView;

-(void)setData:(Author*)author;

@end
