//
//  RemindViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/25.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "RemindViewController.h"
#import "RemindListTableView.h"
#import "RemindManager.h"
#import "RemindModel.h"
@interface RemindViewController ()
@property (nonatomic,retain) RemindListTableView *remindList;
@end

@implementation RemindViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self setTitle:@"提醒"];
    [self showCustomNavigationBackButton];
    [self remindList];
}

- (void)sendRequest {
    /*[[RemindManager sharedInstance] groupDetailInfo:KPAGENUM groupId:_groupId block:^(YActionMessage *message) {
        if (message.isSuccess) {
            [self hiddenFooter:false];
            if ([[message.object groupFeeds] count] < KPAGENUM) {
                [self showNoticeNoMoreData];
            }
            
            _groupModel = [message.object groupModel];
            if (nil != _associationsDetailTableViewDelegate) {
                [_associationsDetailTableViewDelegate resetAddButtonType:_groupModel];
            }
            
            [self resetFeedArray:[message.object groupFeeds] needRemoveAll:YES];
            
        } else {
            [YUtils showTitleOn:self title:message.desc];
        }
        
        [self stopLoad];
    }];*/
}


-(NSArray*)getDataSource
{
    RemindModel *m1 = [[RemindModel alloc]init];
    m1.headImageUrl = @"http://img1.touxiang.cn/uploads/20130925/25-072725_605.jpg";
    m1.acType = @"社团活动公告";
    m1.acName = @"爱心领养";
    
    RemindModel *m2 = [[RemindModel alloc]init];
    m2.headImageUrl = @"http://d.hiphotos.baidu.com/zhidao/wh%3D600%2C800/sign=9030f48cfe039245a1e0e909b7a488fa/e61190ef76c6a7ef9de5aa67fffaaf51f2de66ab.jpg";
    m2.acType = @"社团活动公告";
    m2.acName = @"天津老乡会";
    
    RemindModel *m3 = [[RemindModel alloc]init];
    m3.headImageUrl = @"http://www.toux8.com/uploads/allimg/120703/1_120703155353_5.jpg";
    m3.acType = @"校级活动公告";
    m3.acName = @"校级男子足球比赛";
    return [NSArray arrayWithObjects:m1,m2,m3, nil];
}


-(RemindListTableView *)remindList {
    if (!_remindList) {
        _remindList = [[RemindListTableView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        [self.view addSubview:_remindList];
        [_remindList mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.leading.equalTo(self.view);
            make.trailing.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
    }
    [_remindList loadData];
    _remindList.myDataSource = [self getDataSource];
    return _remindList;
}
@end
