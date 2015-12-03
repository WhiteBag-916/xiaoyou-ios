//
//  ActivityChoiceController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityChoiceController.h"
#import "ActivityChoiceTableView.h"

@interface ActivityChoiceController ()

@property (nonatomic,strong)ActivityChoiceTableView * activityChoiceTableView;

@property (nonatomic,assign)NSInteger myType;
@property(nonatomic,strong)NSMutableArray * dataSourceArr;
@property (nonatomic,strong)NSString * studyRoomDefautStr;//自习室默认选中值
@end

@implementation ActivityChoiceController

- (instancetype)initWithType:(CHOICE_TYPE) type
               andDataSource:(NSMutableArray *) dataSource
       andStudyRoomDefautStr:(NSString *) studyRoomDefautStr
{
    self = [super init];
    if (self) {
        
        _myType = type;
        _dataSourceArr = dataSource;
        _studyRoomDefautStr = studyRoomDefautStr;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
}

-(void)setUpUI
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    _activityChoiceTableView = [[ActivityChoiceTableView alloc] initWithType:_myType];
    _activityChoiceTableView.myController = self;
    if (_myType == CLASSROOM_CHOICE_TYPE)
    {
        _activityChoiceTableView.dataSourceArr = _dataSourceArr;
        _activityChoiceTableView.studyRoomDefautStr = _studyRoomDefautStr;
    }
    [self.view addSubview:_activityChoiceTableView];
    [_activityChoiceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.leading.trailing.mas_equalTo(0);
        make.top.mas_equalTo(10);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
