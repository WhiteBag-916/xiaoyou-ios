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

@property (nonatomic, strong) YFaceImageView *face;
@property (nonatomic, strong) UILabel *userName;
@property (nonatomic, strong) ConnectTag *connect;
@property (nonatomic, strong) FeedTag *tagView;
@property (nonatomic, strong) UIButton *addFriend;
@property (nonatomic, strong) UILabel *genderLabel;

@property (nonatomic, strong) Author *myAuthor;

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
        }];
        
        _connect = [[ConnectTag alloc] init];
        [self.contentView addSubview:_connect];
        [_connect mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName.mas_right).offset(KCONNECTMARGIN);
            make.centerY.equalTo(_userName);
        }];
        
        _genderLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"女" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [self.contentView addSubview:_genderLabel];
        [_genderLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName);
            make.top.equalTo(_userName.mas_bottom).offset(KTAGMARGIN_TOP);
            make.right.equalTo(self.contentView).offset(-KTAGMARGIN_RIGHT);
        }];
        
        _tagView = [[FeedTag alloc] init];
        [self.contentView addSubview:_tagView];
        [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_userName);
            make.top.equalTo(_genderLabel.mas_bottom).offset(KTAGMARGIN_TOP).priorityLow();
            make.right.equalTo(self.contentView).offset(-KTAGMARGIN_RIGHT);
        }];
        [_tagView.tagContent mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_tagView.tagIcon.mas_right).offset(KTAGTEXTMARGIN);
        }];
        _tagView.tagContent.lineSpace = -7;
        self.clipsToBounds = true;
        
        _addFriend = [[UIButton alloc] init];
        [self.contentView addSubview:_addFriend];
        [_addFriend mas_makeConstraints:^(MASConstraintMaker *make) {
            make.width.height.mas_equalTo(KADDFRIENDWIDTH);
            make.centerY.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-KFACEMARGIN);
        }];
        _addFriend.layer.cornerRadius = KADDFRIENDWIDTH/2;
        _addFriend.clipsToBounds = true;
        [_addFriend setImage:[UIImage imageNamed:@"mine-add-friend"] forState:UIControlStateNormal];
        [_addFriend addTarget:self action:@selector(clickAdd) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return self;
}

- (void)setData:(Author *)author needShowGender:(BOOL)needShowGender {
    _myAuthor = author;
    [_face setData:author.uid imageUrl:author.headPic];
    _userName.text = author.name;
    [_tagView setData:author.tagsCommon];
    [_connect updateWithTag:author.propetiesCommon];
    
    _genderLabel.hidden = !needShowGender;
    if (needShowGender) {
        [_tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_genderLabel.mas_bottom).offset(KTAGMARGIN_TOP);
        }];
    } else  {
        [_tagView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(_userName.mas_bottom).offset(KTAGMARGIN_TOP);
        }];
    }
    [self updateStatus:author.friendStatus];
}
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
- (void)clickAdd {
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

@end
