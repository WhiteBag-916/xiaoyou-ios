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
    return _remindList;
}
@end
