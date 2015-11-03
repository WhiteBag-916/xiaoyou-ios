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

#define REUSEID_DETAILCELL  @"ActivityDetailCell"
#define REUSEID_JOINCELL    @"ActivityJoinInCell"
#define KPAGENUM    10
@interface ActivityDetailListView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *activityDetailArray;
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
    _currentIndex = 0;
    [_activityDetailArray removeAllObjects];
    [self sendRequest];
}

- (void)loadMoreData
{
    ActivityDetailModel *model = self.activityDetailArray[0];
    NSArray *enrollArr = model.enrollActivityUserInfos;
    _currentIndex = enrollArr.count;
    [self sendRequest];
}

-(void)sendRequest
{
    [_activityDetailArray removeAllObjects];
    
    [YUtils showHUDWithTitle:@"正在加载..."];
    [[ActivityManager sharedInstance] findActivityDetailInfo:_currentIndex limitEnd:_currentIndex + KPAGENUM activityPublishedId:self.publishID getDetail:YES block:^(YActionMessage *message) {
        if (message.isSuccess) {
            [YUtils hiddenProgressHUD];
            if ([self isHeaderRefresh]) {
                [self.activityDetailArray removeAllObjects];
            }
            [self.activityDetailArray addObject:message.object];
            ActivityDetailModel *model = self.activityDetailArray[0];
            NSArray *enrollArr = model.enrollActivityUserInfos;
            [self hiddenFooter:NO];
            if (1+enrollArr.count < KPAGENUM) {
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
    if (self.activityDetailArray.count == 0 || self.activityDetailArray[0] == nil)
        return 0;
    else {
        ActivityDetailModel *model = self.activityDetailArray[0];
        return 1 + model.enrollActivityUserInfos.count ;
    }
    return 0;
}

#pragma mark  Feed部分的控件要考虑复用
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{;
    CGFloat height;
    if (indexPath.row == 0) {
        height = [tableView fd_heightForCellWithIdentifier:REUSEID_DETAILCELL cacheByIndexPath:indexPath        configuration:^(ActivityDetailCell *cell) {
                [cell setData:self.activityDetailArray[indexPath.row]];
        }];
    }
    else
    {
        ActivityDetailModel *model;
        if (self.activityDetailArray.count > 0)
            model = self.activityDetailArray[0];
        else
            return 0;
        Author *author = model.enrollActivityUserInfos[indexPath.row-1];
        
        ProfileInfo *info = [[ProfileInfo alloc]init];
        info.tagModels = author.tagsCommon;
        info.propetiesCommon = author.propetiesCommon;
        height = [self calculatorTagsCommHeightByProfileInfo:info];
        height += (109) + (30);
        if (indexPath.row != 1) {
            height -= 58;
        }
        
        
        if ([[UIDevice getCurrentDeviceModel] myContainsString:@"Simulator"] && IS_IPHONE_6) {
            height += 20;
        }
        if ([[UIDevice getCurrentDeviceModel] myContainsString:@"iPhone 6"]) {
            height += 20;
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
#pragma mark 此处以后要考虑复用
        //cell = [tableView dequeueReusableCellWithIdentifier:REUSEID_JOINCELL];
        CELLTYPE type = indexPath.row == 1? IS_TOPVIEW : NOT_TOPVIEW;
        cell = [[ActivityJoinInCell alloc]initWithType:type];
        
        ActivityDetailModel *model = nil;
        
        if (self.activityDetailArray.count > 0) {
            model = self.activityDetailArray[0];
            [cell setData:model.enrollActivityUserInfos[indexPath.row-1]];
        }
        return cell;
    }
    return nil;
}


-(CGFloat)calculatorTagsCommHeightByProfileInfo:(ProfileInfo*)model
{
    if (model.tagModels.count > 0)
    {
        CGFloat height;
        BOOL isADD = NO;
        if (model.propetiesCommon.count > 0)
        {
            height = 65;
        }
        else
        {
            isADD = YES;
            height = 65;
        }
        for (int i = 0; i < model.tagModels.count; i++)
        {
            CGFloat width;
            Tags * tag = model.tagModels[i];
            NSDictionary *attributes = @{NSFontAttributeName:[UIFont systemFontOfSize:12]};
            CGSize textSize = [tag.name boundingRectWithSize:CGSizeMake(150, 14) options:NSStringDrawingTruncatesLastVisibleLine attributes:attributes context:nil].size;
            width += 10;
            width += textSize.width + 15;
            if (width > SCREEN_WIDTH - 117)
            {
                height += 20;
                width = 10 + textSize.width;
            }
        }
#pragma mark 暂时,以后修改为自动布局
        if (isADD) {
            height -= 20;
            if ([[UIDevice getCurrentDeviceModel] myContainsString:@"Simulator"] && IS_IPHONE_4_AND_OLDER) {
                height -= 15;
            }
            if ([[UIDevice getCurrentDeviceModel] myContainsString:@"iPhone 4"]) {
                height -= 15;
            }
        }
        return height;
    }
    else
    {
        if (model.propetiesCommon.count <= 0)
        {
            return 0;
        }
        return 40;
    }
}

@end
