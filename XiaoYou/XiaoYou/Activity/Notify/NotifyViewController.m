//
//  NotifyViewController.m
//  XiaoYou
//
//  Created by sheng on 15/11/2.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "NotifyViewController.h"
#import "NotifyListView.h"
#import "YBaseService.h"
#import "NotifyInfoModel.h"
#import "YDatabaseDao.h"
#import "NSObject+MJKeyValue.h"

@interface NotifyViewController ()

@property (nonatomic,strong) NotifyListView *notifyListView;

@property (nonatomic,strong) NSMutableArray *notifyDataSource;

@end

@implementation NotifyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"提醒";
    self.view.backgroundColor = [UIColor whiteColor];
    [self notifyListView];
    [self showCustomNavigationBackButton];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NotifyListView *)notifyListView {
    if (!_notifyListView) {
        _notifyListView = [[NotifyListView alloc]initWithFrame:CGRectZero
                                                         style:UITableViewStyleGrouped];
        [self.view addSubview:_notifyListView];
        [_notifyListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.view);
            make.leading.equalTo(self.view);
            make.trailing.equalTo(self.view);
            make.bottom.equalTo(self.view);
        }];
        _notifyListView.notifyListArray = self.notifyDataSource;
    }
    return _notifyListView;
}


-(NSArray *)notifyDataSource
{
    if (!_notifyDataSource) {
        NSString *dataBasePath = [NSString stringWithFormat:@"%@//%@",[YDirectory documents],NSStringFromClass([NotifyInfoModel class])];
        YDatabaseDao *dataBaseDao = [[YDatabaseDao alloc]initWitDatabasePath:dataBasePath];
        NSString *tableName = NSStringFromClass([NotifyInfoModel class]);
        NSArray *queryArr = [dataBaseDao queryModel:tableName];
        
        
        _notifyDataSource = [NotifyInfoModel objectArrayWithKeyValuesArray:queryArr];
        [dataBaseDao deleteAllDataWithTableName:tableName];
        
        //移除不属于自己的信息，避免换账号登录显示别人的提醒信息
        NSString *uid = [[YShareData defaultData] valueForKey:kShareData_UserID];
        if (uid != nil)
        {
            for (NotifyInfoModel *model in _notifyDataSource) {
                if (![model.uid isEqualToString:uid]) {
                    [_notifyDataSource removeObject:model];
                }
            }
        }
        
    }
    return _notifyDataSource;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Activity_Release_Success object:nil];
}

@end
