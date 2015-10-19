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
        
        [self setUpCustomNavgationBar];
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

-(void)setUpCustomNavgationBar {
    //right barbutton view
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 60, KNavigationBarheight)];
    
    UIButton * remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 25, KNavigationBarheight)];
    [remindBtn setImage:[UIImage imageNamed:@"have_time_select"] forState:UIControlStateNormal];
    [remindBtn addTarget:self
                  action:@selector(filterAction)
        forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:remindBtn];
    
    UIButton * scheduleBtn = [[UIButton alloc] initWithFrame:CGRectMake(35, 0, 25, KNavigationBarheight)];
    [scheduleBtn setImage:[UIImage imageNamed:@"have_time_search"] forState:UIControlStateNormal];
    [scheduleBtn addTarget:self
                    action:@selector(searchAction)
          forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:scheduleBtn];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

//筛选Action
- (void)filterAction {
}

//搜索Action
- (void)searchAction {
    
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
