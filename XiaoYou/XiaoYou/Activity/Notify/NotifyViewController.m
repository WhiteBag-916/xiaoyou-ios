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
        _notifyListView = [[NotifyListView alloc]initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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
        
        for (NotifyInfoModel *model in _notifyDataSource) {
            NSString *uid = [[YShareData defaultData] valueForKey:kShareData_UserID];
            if (![model.uid isEqualToString:uid]) {
                [_notifyDataSource removeObject:model];
            }
        }
        
        
        //如果需要保存历史纪录的话,打开下面代码
//        for (NotifyInfoModel *model in _notifyDataSource) {
//            model.isRead = @"YES";
//            [dataBaseDao insertModel:model];
//        }
        
        
        //去除重复元素
//        for (int i = 0; i < _notifyDataSource.count; i++) {
//            NotifyInfoModel *m1 = _notifyDataSource[i];
//            
//            NotifyInfoModel *m2;
//            if (i+1 < _notifyDataSource.count)
//                m2 = _notifyDataSource[i+1];
//            if (m2 != nil) {
//                if (m1.type == m2.type && [m1.idStr isEqualToString:m2.idStr]) {
//                    [_notifyDataSource removeObject:m1];
//                }
//            }
//        }
        
    }
    return _notifyDataSource;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Activity_Release_Success object:nil];
}

@end
