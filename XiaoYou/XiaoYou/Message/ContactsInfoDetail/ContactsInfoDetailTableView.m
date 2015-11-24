//
//  ContactsInfoDetailTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/18.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsInfoDetailTableView.h"
#import "ContactsInfoDetailTableViewCell.h"
#import "ContactsInfoFirstTableViewCell.h"
#import "ContactsInfoSecondTableViewCell.h"
#import "ContactsInfoThirdTableViewCell.h"
#import "ConnectTag.h"
#import "UIImageView+Ext.h"
#import "Tags.h"
#import "ProfileInfo.h"
#import "LinkManList.h"
#import "ProfilePublishViewController.h"
#import "ContactManager.h"
#import "YUtils+HUD.h"
#import "SDPhotoBrowser.h"
#import "Author.h"
#import "FeedInfo.h"
#import "TagsCommonView.h"

#define kHeaderViewHeight              SCALE_NUM(60)
#define kHeadWidthAndHeight            SCALE_NUM(46)
#define kNameLabelWidth                SCALE_NUM(80)
#define kHeadCornerRadius              SCALE_NUM(23)
#define kPaddingDistance               SCALE_NUM(12)
#define kLabelHeightDistacnce          SCALE_NUM(16)
#define kFlagImageViewWidth            SCALE_NUM(9)
#define kFlagImageViewHeight           SCALE_NUM(13)


@interface ContactsInfoDetailTableView ()<UITableViewDataSource,UITableViewDelegate,SDPhotoBrowserDelegate,ContactsInfoThirdTableViewCellDelegate>

@property (nonatomic, strong) UIView *faceContainer;
@property (strong, nonatomic)  UIImageView *headImageView;
@property (strong, nonatomic)  UILabel *nameLabel;
@property (strong, nonatomic)  UILabel *flagLabel;
@property (strong, nonatomic)  UILabel *statesLabel;
@property (strong, nonatomic)  ConnectTag * connectTag;
@property (nonatomic,strong) ProfileInfo * model;

@property (nonatomic,strong) UIView * feedBackView;
@property (nonatomic,strong) UILabel * feedLabel;
@property (nonatomic,strong) UILabel * feedCountLabel;
@property (nonatomic,strong) UIImageView * flagImageView;

@property (nonatomic,strong) NSMutableArray * flagNameArr;

@end

@implementation ContactsInfoDetailTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = NO;
        
        [self registerClass:[ContactsInfoFirstTableViewCell class] forCellReuseIdentifier:kContactsInfoFirstTableViewCell];
        [self registerClass:[ContactsInfoSecondTableViewCell class] forCellReuseIdentifier:kContactsInfoSecondTableViewCell];
        [self registerClass:[ContactsInfoThirdTableViewCell class] forCellReuseIdentifier:kContactsInfoThirdTableViewCell];
    }
    return self;
}

#pragma mark - 刷新界面
-(void)refreshTableView:(ProfileInfo *) model
{
    _model = model;

    if (_model != nil) {
        self.flagNameArr = [[NSMutableArray alloc]init];
        for (int i = 0; i <_model.tagsCommon.count; i++)
        {
            [self.flagNameArr addObject:[_model.tagsCommon[i] name]];
        }
        [self setUpHeaderView];
        [self setUpFooterView];
        [self reloadData];
    }
}

-(void)setUpHeaderView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewHeight)];
    backView.backgroundColor = [UIColor clearColor];
    UITapGestureRecognizer * gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(clickedHeadImageVIew)];
    //放大头像
    _faceContainer = [[UIView alloc] init];
    _faceContainer.backgroundColor = [UIColor clearColor];
    [backView addSubview:_faceContainer];
    [_faceContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kPaddingDistance);
        make.bottom.equalTo(backView);
        make.width.height.mas_equalTo(kHeadWidthAndHeight);
    }];
    //头像
    _headImageView = [[UIImageView alloc] init];
    _headImageView.userInteractionEnabled = YES;
    [_headImageView addGestureRecognizer:gestureRecognizer];
    _headImageView.layer.cornerRadius = kHeadCornerRadius;
    _headImageView.clipsToBounds = YES;
    _headImageView.backgroundColor = [UIColor clearColor];
    [_headImageView setFaceImageWithUrl:_model.headPic];
    [_faceContainer addSubview:_headImageView];
    [_headImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.mas_equalTo(0);
    }];
    
    //姓名
    _nameLabel = [[UILabel alloc] init];
    _nameLabel.font = CONTENT_FONT(14);
    _nameLabel.textColor = [UIColor hexChangeFloat:@"333333"];
    _nameLabel.text = _model.userName;
    _nameLabel.backgroundColor = [UIColor clearColor];
    NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:14]};
    CGSize textSize = [_model.userName boundingRectWithSize:CGSizeMake(150, 14) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
    [backView addSubview:_nameLabel];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_headImageView.mas_top);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.width.mas_equalTo(SCALE_NUM(textSize.width+20));
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
    
    //性别
    UIImageView * sexImageView = [[UIImageView alloc] init];
    sexImageView.backgroundColor = [UIColor clearColor];
    [backView addSubview:sexImageView];
    [sexImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_nameLabel.mas_right);
        make.centerY.equalTo(_nameLabel);
        make.height.width.mas_equalTo(SCALE_NUM(14));
        
    }];
    if ([_model.gender isEqualToString:@"男"])
    {
        sexImageView.image = [UIImage imageNamed:@"funny_detail_boy"];
    }
    else if ([_model.gender isEqualToString:@"女"])
    {
        sexImageView.image = [UIImage imageNamed:@"funny_detail_girl"];
    }
    
    //认证
//    UILabel * authenticationLabel = [[UILabel alloc] init];
//    authenticationLabel.text = @"手机号未注册";
//    authenticationLabel.textColor = [UIColor hexChangeFloat:@"999999"];
//    authenticationLabel.font = CONTENT_FONT(10);
//    [backView addSubview:authenticationLabel];
//    [authenticationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.mas_equalTo(-kPaddingDistance);
//        make.centerY.equalTo(_nameLabel);
//    }];
    
    
    //院系年级
    UILabel * classLabel = [[UILabel alloc] init];
    classLabel.text = [NSString stringWithFormat:@"%@|%@",_model.faculty,_model.grad];
    classLabel.font = CONTENT_FONT(12);
    classLabel.textColor = [UIColor hexChangeFloat:@"999999"];
    [backView addSubview:classLabel];
    [classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(_headImageView.mas_bottom);
        make.left.equalTo(_headImageView.mas_right).offset(kPaddingDistance);
        make.right.equalTo(backView).offset(-kPaddingDistance);
        make.top.equalTo(_nameLabel.mas_bottom).offset(kPaddingDistance);
    }];

    self.tableHeaderView = backView;
}

-(void)setUpFooterView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, kHeaderViewHeight)];
    backView.backgroundColor = [UIColor clearColor];
    //头像
    _feedBackView = [[UIImageView alloc] init];
    _feedBackView.layer.cornerRadius = kHeadCornerRadius;
    _feedBackView.clipsToBounds = YES;
    _feedBackView.backgroundColor = KCOLOR_009688;
    [backView addSubview:_feedBackView];
    [_feedBackView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kPaddingDistance);
        make.centerY.equalTo(backView);
        make.width.height.mas_equalTo(kHeadWidthAndHeight);
    }];
    _feedCountLabel = [[UILabel alloc] init];
    _feedCountLabel.backgroundColor = [UIColor clearColor];
    _feedCountLabel.textColor = [UIColor whiteColor];
    _feedCountLabel.textAlignment = NSTextAlignmentCenter;
    _feedCountLabel.text = @"动态";
    _feedCountLabel.font = CONTENT_FONT(15);
    [backView addSubview:_feedCountLabel];
    [_feedCountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(kPaddingDistance);
        make.centerY.equalTo(backView);
        make.width.height.mas_equalTo(kHeadWidthAndHeight);
    }];
    
    //姓名
    _feedLabel = [[UILabel alloc] init];
    _feedLabel.font = CONTENT_FONT(14);
    _feedLabel.textColor = [UIColor hexChangeFloat:@"666666"];
    _feedLabel.text = [NSString stringWithFormat:@"共%g条",_model.feedCount];
    _feedLabel.backgroundColor = [UIColor clearColor];
    [backView addSubview:_feedLabel];
    [_feedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_feedBackView);
        make.left.equalTo(_feedBackView.mas_right).offset(kPaddingDistance);
        make.width.mas_equalTo(kNameLabelWidth);
        make.height.mas_equalTo(kLabelHeightDistacnce);
    }];
    
    _flagImageView = [[UIImageView alloc] init];
    _flagImageView.backgroundColor = [UIColor clearColor];
    _flagImageView.image = [UIImage imageNamed:@"mine-concern-particulars"];
    [backView addSubview:_flagImageView];
    [_flagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(_feedBackView);
        make.right.mas_equalTo(-kPaddingDistance);
        make.width.mas_equalTo(kFlagImageViewWidth);
        make.height.mas_equalTo(kFlagImageViewHeight);
    }];
    
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapFooterView)];
    [backView addGestureRecognizer:tapGestureRecognizer];
    
    self.tableFooterView = backView;
}

-(void)tapFooterView
{
    ProfilePublishViewController * profilePublish = [[ProfilePublishViewController alloc] initWithUserId:_model.uid name:_model.userName];
    [self.myController.navigationController pushViewController:profilePublish animated:YES needHiddenBottomBar:YES];
    
}

#pragma mark - UITableViewDataSource和UITableViewDataDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (_model == nil) {
        return 0;
    }
//    return _flagNameArr.count + 2;
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
        if (indexPath.row == 0)
        {
            ContactsInfoFirstTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kContactsInfoFirstTableViewCell forIndexPath:indexPath];
            [cell setCellInfo:_model];
            return cell;
        }
        else if (indexPath.row == 1)
        {
            ContactsInfoSecondTableViewCell * cell = [[ContactsInfoSecondTableViewCell alloc] init];
//            ContactsInfoSecondTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kContactsInfoSecondTableViewCell forIndexPath:indexPath];
            [cell setCellInfo:_model];
            return cell;
        }
        else
        {
            ContactsInfoThirdTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kContactsInfoThirdTableViewCell forIndexPath:indexPath];
            cell.myDelegate = self;
            [cell setCellInfo:_model];
            return cell;
        }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0)
    {
        if ([_model.selfIntro isEqualToString:@""])
        {
            return 0;
        }
        else{
            return SCALE_NUM(30);
        }
    }
    else if(indexPath.row == 1)
    {
        CGFloat height = [TagsCommonView calculatorHeightByTagsCommon:_model.tagsCommon propetiesCommon:_model.propetiesCommon];
        return height;
    }
    else
    {
        return SCALE_NUM(95);
    }
    
}



-(void)didSelectCool
{
    [YUtils showHUDWithTitle];
    [[ContactManager sharedInstance] praise:_model.uid block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        if (message.isSuccess) {
            _model.isCool = !_model.isCool;
            if (_model.isCool) {
                ++_model.coolCount;
            } else {
                --_model.coolCount;
            }
            
            [self reloadData];
        }else {
            [YUtils showTitle:message.desc];
        }
        
    }];
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
//{
//    if (indexPath.row == 1)
//    {
//        [YUtils showHUDWithTitle];
//        [[ContactManager sharedInstance] praise:_model.uid block:^(YActionMessage *message) {
//            [YUtils hiddenProgressHUD];
//            if (message.isSuccess) {
//                _model.isCool = !_model.isCool;
//                if (_model.isCool) {
//                    ++_model.coolCount;
//                } else {
//                    --_model.coolCount;
//                }
//                
//                [self reloadData];
//            }else {
//                [YUtils showTitle:message.desc];
//            }
//            
//        }];
//    }
//}

#pragma mark - 查看头像大图
- (void)clickedHeadImageVIew {
    
    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = _faceContainer;
    
    browser.imageCount = 1;
    
    browser.currentImageIndex = 0;
    
    browser.delegate = self;
    
    [browser show];
}

#pragma mark - SDPhotoBrowser
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return _headImageView.image;
}

@end
