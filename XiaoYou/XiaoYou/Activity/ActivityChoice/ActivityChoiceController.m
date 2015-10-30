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

@end

@implementation ActivityChoiceController

-(instancetype)initWithType:(CHOICE_TYPE) type
{
    self = [super init];
    if (self) {
        
        _myType = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
    
}

-(void)setUpUI
{
    _activityChoiceTableView = [[ActivityChoiceTableView alloc] initWithType:_myType];
    _activityChoiceTableView.myController = self;
    if (_myType == CLASSROOM_CHOICE_TYPE)
    {
        _activityChoiceTableView.dataSourceArr = _dataSourceArr;
        _activityChoiceTableView.studyRoomDefautStr = _studyRoomDefautStr;
    }
    [self.view addSubview:_activityChoiceTableView];
    [_activityChoiceTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.leading.trailing.mas_equalTo(0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
