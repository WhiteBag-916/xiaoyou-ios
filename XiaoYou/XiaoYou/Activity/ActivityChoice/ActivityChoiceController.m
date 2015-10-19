//
//  ActivityChoiceController.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/12.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityChoiceController.h"
#import "ActivityChoiceTableView.h"

typedef enum : NSUInteger {
    ACTIVITY_CHOICE_TYPE,
    CLASS_CHOICE_TYPE,
} CHOICE_TYPE;

@interface ActivityChoiceController ()

@property (nonatomic,strong)ActivityChoiceTableView * activityChoiceTableView;

@end

@implementation ActivityChoiceController

-(instancetype)initWithType:(CHOICE_TYPE) type
{
    self = [super init];
    if (self) {
        switch (type) {
            case ACTIVITY_CHOICE_TYPE:
                ;
                break;
            case CLASS_CHOICE_TYPE:
                ;
                break;
            
            default:
                break;
        }
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setUpUI];
}

-(void)setUpUI
{
    _activityChoiceTableView = [[ActivityChoiceTableView alloc] init];
    _activityChoiceTableView.myController = self;
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
