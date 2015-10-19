//
//  AvailableSimpleViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "AvailableSimpleViewController.h"
#import "RubLessonTableView.h"
#import "StudyRoomTableView.h"
#import "StudyRoomDetailTableView.h"

@interface AvailableSimpleViewController ()

@property (nonatomic, assign) AvailableSimpleType type;
@property (nonatomic, strong) RubLessonTableView *rubLessonTableView;
@property (nonatomic, strong) StudyRoomTableView *studyRoomTableView;
@property (nonatomic, strong) StudyRoomDetailTableView *studyRoomDetailTableView;

@end

@implementation AvailableSimpleViewController

- (id)initWithType:(AvailableSimpleType)type{
    self = [super init];
    if (self) {
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self showCustomNavigationBackButton];
    
    if (AvailableSimpleTypeRubLesson == _type) {
        self.title = @"你可以蹭的课";
        
        _rubLessonTableView = [[RubLessonTableView alloc] init];
        [self.view addSubview:_rubLessonTableView];
        
        [_rubLessonTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    } else if (AvailableSimpleTypeStudyRoom == _type) {
        self.title = @"自习室";
        
        _studyRoomTableView = [[StudyRoomTableView alloc] init];
        [self.view addSubview:_studyRoomTableView];
        
        [_studyRoomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }else if (AvailableSimpleTypeStudyRoomDetail == _type) {
        self.title = @"教学2楼";
        
        _studyRoomDetailTableView = [[StudyRoomDetailTableView alloc] init];
        [self.view addSubview:_studyRoomDetailTableView];
        
        [_studyRoomDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
