
//
//  ProfilePersonListTableView.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/21.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfilePersonListTableView.h"
#import "ProfilePersonListTableViewCell.h"
#import "ProvisionManager.h"
#import "ContactManager.h"
#import "FeedManager.h"
#import "ActivityManager.h"
#import "ActivityDetailModel.h"
#import "ProfileInfo.h"
#import "Author.h"
#import "Tags.h"

#define KPAGENUM 15

@interface ProfilePersonListTableView()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, assign) int type;
@property (nonatomic, strong) NSString *feedId;
@property (nonatomic, strong) NSMutableArray *personListArray;      //列表数据源
@property (nonatomic, strong) NSDictionary *conditionDic;           //筛选条件
@property (nonatomic, strong) NSString *queryCode;

@end

@implementation ProfilePersonListTableView
- (id)initWIthType:(int)type {
    self = [super init];
    if (self) {
        _type = type;
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ProfilePersonListTableViewCell class] forCellReuseIdentifier:kProfilePersonListTableViewCell];
        self.tableFooterView = [UIView new];
        self.backgroundColor = KCOLOR_f2f2f2;
        _personListArray = [NSMutableArray array];
        
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return self;
}
#pragma mark - 继承者
- (BOOL)showHeaderRefresh
{
    return YES;
}

- (BOOL)showFooterRefresh
{
    return YES;
}
- (void)loadData {
    [self beginLoadNewData];
}

//筛选条件加载
- (void)loadDataWithFind:(NSDictionary *)condition {
    self.conditionDic = [NSDictionary dictionaryWithDictionary:condition];
    [self sendRequest];
}

//feed人
- (void)loadDataWithQueryCode:(NSString *)queryCode {
    if (nil == _queryCode) {
        //第一次才刷新
        _queryCode = queryCode;
        [self beginLoadNewData];
    }
}
- (void)loadDataWithFeedId:(NSString *)feedId {
    if (nil == _feedId) {
        _feedId = feedId;
        [self beginLoadNewData];
    }
}
- (void)loadNewData
{
    [self sendRequest];
}

- (void)loadMoreData
{
    [self sendRequest];
}
- (void)sendRequest {
    NSInteger cnt = _personListArray.count;
    if ([self isHeaderRefresh]) {
        cnt = 0;
    }
    if (_type == ProfilePersonListTypeRespect) {
        [[ProvisionManager sharedInstance] myPraisePersons:cnt limitEnd:cnt + KPAGENUM block:^(YActionMessage *message) {
            [self dealMessage:message];
        }];
    }else if (_type == ProfilePersonListTypeCool) {
        [[ProvisionManager sharedInstance] myCoolPersons:cnt limitEnd:cnt + KPAGENUM block:^(YActionMessage *message) {
            [self dealMessage:message];
        }];
    } else if (ProfilePersonListTypeFind == _type) {
        [[ContactManager sharedInstance] findFriends:cnt limitEnd:cnt + KPAGENUM conditionDic:_conditionDic block:^(YActionMessage *message) {
            [self dealMessage:message];
        }];
    } else if (ProfilePersonListTypeFeedPerson == _type) {
        [[FeedManager sharedInstance] findFriendsByTags:cnt limitEnd:cnt + KPAGENUM queryCode:_queryCode block:^(YActionMessage *message) {
            [self dealMessage:message];
        }];
    } else if (PersonPersonListTypeFeedRespect == _type) {
        [[FeedManager sharedInstance] listPraisePeoples:cnt limitEnd:cnt + KPAGENUM feedId:_feedId block:^(YActionMessage *message) {
            [self dealMessage:message];
        }];
    } else if (ProfilePersonListTypeNoticePerson == _type) {
        [[ActivityManager sharedInstance]findActivityDetailInfo:cnt limitEnd:cnt + KPAGENUM activityPublishedId:self.publishID getDetail:NO block:^(YActionMessage *message) {
            
            [self dealMessage:message];
        }];
    }
}
- (void)dealMessage:(YActionMessage *)message {
    if (message.isSuccess) {
        [self hiddenFooter:NO];
        if ([self isHeaderRefresh]) {
            [_personListArray removeAllObjects];
        }
        NSUInteger dataLen = 0;
        if (ProfilePersonListTypeNoticePerson == _type) {
            ActivityDetailModel *detailModel = message.object;
            NSArray *joinInArr = detailModel.enrollActivityUserInfos;
            [_personListArray addObjectsFromArray:joinInArr];
            dataLen = joinInArr.count;
        }
        else
            [_personListArray addObjectsFromArray:message.object];
        
        
        if (ProfilePersonListTypeNoticePerson != _type) {
            dataLen = [message.object count];
        }
        
        if (dataLen < KPAGENUM) {
            [self showNoticeNoMoreData];
        }
        [self reloadData];
        
    } else {
        [YUtils showTitleOn:self title:message.desc];
    }
    if ([self isHeaderRefresh]) {
        [self stopLoadNewData];
    } else {
        [self stopLoadMoreData];
    }
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _personListArray.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    ProfilePersonListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProfilePersonListTableViewCell];
    ProfilePersonListTableViewCell *cell = [[ProfilePersonListTableViewCell alloc] init];
    BOOL showGender = (ProfilePersonListTypeFind == _type);
    [cell setData:_personListArray[indexPath.row] needShowGender:showGender];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (ProfilePersonListTypeFind == _type) {
//        return KFIND_CELLHEIGHT;
//    }
////    return KCELLHEIGHT;
//    else
//    {
        Author * author = _personListArray[indexPath.row];
        ProfileInfo * model = [[ProfileInfo alloc] init];
        model.propetiesCommon = author.propetiesCommon;
        model.tagsCommon = author.tagsCommon;
        
        if (model.tagsCommon.count > 0)
        {
            CGFloat height;
            if (model.propetiesCommon.count > 0)
            {
                height = SCALE_NUM(120);
            }
            else
            {
                height = SCALE_NUM(95);
            }
            
            for (int i = 0; i < model.tagsCommon.count; i++)
            {
                CGFloat width;
                Tags * tag = model.tagsCommon[i];
                NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:SCALE_NUM(10)]};
                CGSize textSize = [tag.name boundingRectWithSize:CGSizeMake(SCALE_NUM(300), 14) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
                
                width += SCALE_NUM(10);
                width += textSize.width + SCALE_NUM(15);
                
                CGFloat  limitWidth = SCREEN_WIDTH - SCALE_NUM(115);
                if (width > limitWidth)
                {
                    height += SCALE_NUM(20);
                    width = textSize.width + SCALE_NUM(15);
                }
                
            }
            return height;
        }
        else
        {
            if (model.propetiesCommon.count <= 0)
            {
                if (ProfilePersonListTypeFind == _type)
                {
                    return SCALE_NUM(65);
                }
                else
                {
                    return 0;
                }
                
            }
            return SCALE_NUM(95);
        }
//    }
    
}
@end
