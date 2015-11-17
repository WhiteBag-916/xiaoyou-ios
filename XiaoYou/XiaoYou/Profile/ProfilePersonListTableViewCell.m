//
//  ProfilePersonListTableViewCell.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfilePersonListTableViewCell.h"
#import "YFaceImageView.h"
#import "YUtils+Component.h"
#import "ConnectTag.h"
#import "UIImageView+WebCache.h"
#import "FeedTag.h"
#import "Author.h"
#import "ContactManager.h"
#import "TagsCommonView.h"
#import "ProfileInfo.h"

NSString *const kProfilePersonListTableViewCell = @"kProfilePersonListTableViewCell";


#define KFACEIMGSIZE SCALE_NUM(45)
#define KFACEMARGIN SCALE_NUM(10)

#define KTAGMARGIN SCALE_NUM(12)
#define KCONNECTMARGIN SCALE_NUM(30)

#define KTAGMARGIN_TOP SCALE_NUM(15)
#define KTAGHEIGHT SCALE_NUM(35)
#define KTAGTEXTMARGIN SCALE_NUM(15)

#define KTAGMARGIN_RIGHT SCALE_NUM(58)

#define KADDFRIENDWIDTH SCALE_NUM(28)
@interface ProfilePersonListTableViewCell()

@property (nonatomic, strong) YFaceImageView *face;//头像
@property (nonatomic, strong) UILabel *userName;//姓名
@property (nonatomic, strong) ConnectTag *connect;//人脉关系
@property (nonatomic, strong) FeedTag *tagView;//兴趣标签
@property (nonatomic, strong) UIButton *addFriend;//添加好友按钮
@property (nonatomic, strong) UIImageView * sexImageView;//性别

@property (nonatomic, strong) Author *myAuthor;//缓存人信息

@property (nonatomic, strong) TagsCommonView * tagsCommonView;

@property (nonatomic, strong) UIView * backView;

@end

@implementation ProfilePersonListTableViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        _face = [[YFaceImageView alloc] init];
        [self.contentView addSubview:_face];
        [_face mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.left.mas_equalTo(KFACEMARGIN);
            make.width.height.mas_equalTo(KFACEIMGSIZE);
        }];
        _face.layer.cornerRadius = KFACEIMGSIZE/2;
        _face.clipsToBounds = true;
        
        _userName = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"小小" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_userName];
        [_userName mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_face.mas_right).offset(KTAGMARGIN);
            make.centerY.equalTo(_face);
            make.height.mas_equalTo(SCALE_NUM(12));
        }];
        
        //性别
        _sexImageView = [[UIImageView alloc] init];
        _sexImageView.backgroundColor = [UIColor clearColor];
        [self.contentView addSubview:_sexImageView];
        [_sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName.mas_right).offset(SCALE_NUM(12));
            make.centerY.equalTo(_userName);
            make.height.width.mas_equalTo(SCALE_NUM(14));
            
        }];
        
//        _connect = [[ConnectTag alloc] init];
//        [self.contentView addSubview:_connect];
//        [_connect mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_userName.mas_right).offset(KCONNECTMARGIN);
//            make.centerY.equalTo(_userName);
//        }];
        
//        _genderLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"女" frame:CGRectZero alignment:NSTextAlignmentLeft];
//        [self.contentView addSubview:_genderLabel];
//        [_genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_userName);
//            make.top.equalTo(_userName.mas_bottom).offset(KTAGMARGIN_TOP);
//            make.right.equalTo(self.contentView).offset(-KTAGMARGIN_RIGHT);
//        }];
        
//        _tagView = [[FeedTag alloc] init];
//        [self.contentView addSubview:_tagView];
//        [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_userName);
//            make.top.equalTo(_genderLabel.mas_bottom).offset(KTAGMARGIN_TOP).priorityLow();
//            make.right.equalTo(self.contentView).offset(-KTAGMARGIN_RIGHT);
//        }];
//        [_tagView.tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(_tagView.tagIcon.mas_right).offset(KTAGTEXTMARGIN);
//        }];
//        _tagView.tagContent.lineSpace = -7;
//        _tagView.tagContent.maxLines = 2;
//        self.clipsToBounds = true;
        
        _backView = [[UIView alloc] init];
        _backView.backgroundColor = [UIColor hexChangeFloat:@"F9F9F9"];
        [self.contentView addSubview:_backView];
        [_backView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_face.mas_bottom);
            make.left.equalTo(_userName.mas_left);
            make.trailing.mas_equalTo(SCALE_NUM(-12));
            make.bottom.mas_equalTo(SCALE_NUM(-12));
        }];
        
        _tagsCommonView = [[TagsCommonView alloc] init];
        _tagsCommonView.backgroundColor = [UIColor hexChangeFloat:@"F9F9F9"];
        [_backView addSubview:_tagsCommonView];
        [_tagsCommonView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.right.mas_equalTo(0);
            make.left.mas_equalTo(SCALE_NUM(12));
        }];
        
        
        
        _addFriend = [[UIButton alloc] init];
        [self.contentView addSubview:_addFriend];
        [_addFriend mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(KADDFRIENDWIDTH);
//            make.centerY.equalTo(self.contentView);
            make.top.equalTo(_face);
            make.right.equalTo(self.contentView).offset(-KFACEMARGIN);
        }];
        _addFriend.layer.cornerRadius = KADDFRIENDWIDTH/2;
        _addFriend.clipsToBounds = true;
        [_addFriend setImage:[UIImage imageNamed:@"mine-add-friend"] forState:UIControlStateNormal];
        [_addFriend addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (BOOL)needLine {
    return YES;
}


//-(TagsCommonView *)tagsCommonView
//{
//    if (!_tagsCommonView) {
//        _tagsCommonView = [[TagsCommonView alloc] init];
//        _tagsCommonView.backgroundColor = [UIColor hexChangeFloat:@"F9F9F9"];
//        [_backView addSubview:_tagsCommonView];
//        [_tagsCommonView mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.top.bottom.right.mas_equalTo(0);
//            make.left.mas_equalTo(SCALE_NUM(12));
//        }];
//    }
//    return _tagsCommonView;
//}


- (void)setData:(Author *)author needShowGender:(BOOL)needShowGender {
    
//    [_tagsCommonView removeFromSuperview];
//    _tagsCommonView = nil;
//    
//    [self tagsCommonView];
    
    _myAuthor = author;
    [_face setData:author.uid imageUrl:author.headPic];
    _userName.text = author.name;
//    [_tagView setData:author.tagsCommon];
//    [_connect updateWithTag:author.propetiesCommon];
    
    ProfileInfo * model = [[ProfileInfo alloc] init];
    model.propetiesCommon = author.propetiesCommon;
    model.tagsCommon = author.tagsCommon;
    [_tagsCommonView setData:model];
    
//    _genderLabel.text = author.gender;
//    _genderLabel.hidden = !needShowGender;
//    if (needShowGender) {
//        [_tagView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_genderLabel.mas_bottom).offset(KTAGMARGIN_TOP);
//        }];
//    } else  {
//        [_tagView mas_updateConstraints:^(MASConstraintMaker *make) {
//            make.top.equalTo(_userName.mas_bottom).offset(KTAGMARGIN_TOP);
//        }];
//    }
    
    if ([_myAuthor.gender isEqualToString:@"男"])
    {
        _sexImageView.image = [UIImage imageNamed:@"funny_detail_boy"];
    }
    else if ([_myAuthor.gender isEqualToString:@"女"])
    {
        _sexImageView.image = [UIImage imageNamed:@"funny_detail_girl"];
    }
    
    [self updateStatus:author.friendStatus];
}
//更新好友申请状态
- (void)updateStatus:(NSString *)status {
    if ([status isEqualToString:@"1"]) {
        _addFriend.hidden = false;
        _addFriend.enabled = true;
    }
    if ([status isEqualToString:@"2"]) {
        _addFriend.hidden = false;
        _addFriend.enabled = false;
    }
    if ([status isEqualToString:@"3"]) {
        _addFriend.hidden = true;
    }
}
//添加好友
- (void)clickAdd {
    //展示提示
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil
                                                              message:[NSString stringWithFormat:@"确定向%@发送好友申请吗？", _userName.text]
                                                         buttonTitles:@"取消",@"确认", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        if (1 == index) {
            [YUtils showHUDWithTitle:@"发送中"];
            [[ContactManager sharedInstance] submitFriendApply:_face.userId block:^(YActionMessage *message) {
                [YUtils hiddenProgressHUD];
                if (message.isSuccess) {
                    _myAuthor.friendStatus = @"2";
                    [self updateStatus:_myAuthor.friendStatus];
                }
                
                [YUtils showTitle:message.desc];
            }];
        }
    }];
    [alert show];
}

@end
