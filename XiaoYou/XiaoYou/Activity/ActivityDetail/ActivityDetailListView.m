//
//  FunnyDetailListView.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityDetailListView.h"
#import "ActivityDetailCell.h"
#import "ActivityJoinInCell.h"
#import "ActivityManager.h"
#import "ActivityDetailModel.h"
#import "ProfileInfo.h"
#import "Tags.h"
#import "Author.h"
#import "UIDevice+DeviceType.h"
#import "YUtils.h"
#import "NSString+MyContainString.h"
#import "TagsCommonView.h"

#define REUSEID_DETAILCELL  @"ActivityDetailCell"
#define REUSEID_JOINCELL    @"ActivityJoinInCell"
#define KPAGENUM    5
@interface ActivityDetailListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,assign) NSInteger currentIndex;

@end

@implementation ActivityDetailListView

-(instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ActivityDetailCell class] forCellReuseIdentifier:REUSEID_DETAILCELL];
        [self registerClass:[ActivityJoinInCell class] forCellReuseIdentifier:REUSEID_JOINCELL];
        _currentIndex = 0;
        self.isContainsMe = NO;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self registerClass:[ActivityDetailCell class] forCellReuseIdentifier:REUSEID_DETAILCELL];
        [self registerClass:[ActivityJoinInCell class] forCellReuseIdentifier:REUSEID_JOINCELL];
        _currentIndex = 0;
        self.isContainsMe = NO;
    }
    return self;
}

-(NSMutableArray *)activityDetailArray
{
    if (!_activityDetailArray) {
        _activityDetailArray = [NSMutableArray array];
    }
    return _activityDetailArray;
}

#pragma mark - 继承者
- (void)loadData {
    [self beginLoadNewData];
}
- (BOOL)showHeaderRefresh
{
    return YES;
}

- (BOOL)showFooterRefresh
{
    return YES;
}

- (void)loadNewData
{
    //_currentIndex = 0;
    [self sendRequest];
}

- (void)loadMoreData
{
    //_currentIndex = self.activityDetailArray.count - 1;
    [self sendRequest];
}

-(void)sendRequest
{
    _currentIndex = [self isHeaderRefresh] ? 0 : self.activityDetailArray.count - 1;
    if (![self isHeaderRefresh])
        [YUtils showHUDWithTitle:@"正在加载..."];
    [[ActivityManager sharedInstance] findActivityDetailInfo:_currentIndex
                                                    limitEnd:_currentIndex + KPAGENUM
                                         activityPublishedId:self.publishID
                                                   getDetail:YES block:^(YActionMessage *message) {
        [YUtils hiddenProgressHUD];
        if (message.isSuccess) {
            if ([self isHeaderRefresh]) {
                [self.activityDetailArray removeAllObjects];
            }
            if (_currentIndex == 0) {
                [self.activityDetailArray addObject:message.object];
            }
            NSArray *newData = [message.object valueForKey:@"enrollActivityUserInfos"];
            [self.activityDetailArray addObjectsFromArray:newData];
            [self hiddenFooter:NO];
            if ([newData count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            [self reloadData];
            _currentIndex += KPAGENUM;
        } else {
            [YUtils showTitle:message.desc];
        }
        if ([self isHeaderRefresh]) {
            [self stopLoadNewData];
        } else
        {
            [self stopLoadMoreData];
        }
    }];
}


#pragma mark -协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (self.activityDetailArray.count == 1) {
        Author *author = [[Author alloc]init];
        author.studentNo = nil;
        author.uid = nil;
        [self.activityDetailArray addObject:author];
    }
    return self.activityDetailArray.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CGFloat height;
    if (indexPath.row == 0) {
        height = [tableView fd_heightForCellWithIdentifier:REUSEID_DETAILCELL
                                          cacheByIndexPath:indexPath
                                             configuration:^(ActivityDetailCell *cell) {
                                [cell setData:self.activityDetailArray[indexPath.row]];
        }];
    }
    else
    {
        Author *author = self.activityDetailArray[indexPath.row];
        if (author.studentNo == nil && author.uid == nil)
            return SCALE_NUM(160);
        if (author.tagsCommon.count == 0 && author.propetiesCommon.count == 0
            && indexPath.row == 1) {
            return SCALE_NUM(140);
        }
        
        if (author.tagsCommon.count == 0 && author.propetiesCommon.count == 0) {
            return SCALE_NUM(90);
        }
        height = [TagsCommonView calculatorHeightByTagsCommon:author.tagsCommon
                                              propetiesCommon:author.propetiesCommon];
        height += (SCALE_NUM(49)) + (SCALE_NUM(60));
        if (indexPath.row != 1) {
            height -= SCALE_NUM(49);
        }
    }
    return height;
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0)
    {
        ActivityDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:REUSEID_DETAILCELL];
        if (self.activityDetailArray.count != 0)
            [cell setData:self.activityDetailArray[indexPath.row]];
        return cell;
    }
    else
    {
        ActivityJoinInCell *cell;
        cell = [tableView dequeueReusableCellWithIdentifier:REUSEID_JOINCELL];
        
        CELLTYPE type = indexPath.row == 1? IS_TOPVIEW : NOT_TOPVIEW;
        
        if (self.activityDetailArray.count > 0) {
            Author *author = self.activityDetailArray[indexPath.row];
            [cell setData:author WithType:type];
            
            //判断自己是否已经加入
            if ([author.uid isEqualToString:[[YShareData defaultData]
                                             valueForKey:kShareData_UserID]]) {
                self.isContainsMe = YES;
            }
        }
        return cell;
    }
    return nil;
}

@end
