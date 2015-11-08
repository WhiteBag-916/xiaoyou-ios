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
#import "ActivityChoiceController.h"
#import "YWebViewController.h"

typedef enum : NSUInteger {
    Choice_Type,
    Question_Type,
} Navigation_Right_type;

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
        
        [self setUpCustomNavgationBar:Choice_Type];
        
        _studyRoomTableView = [[StudyRoomTableView alloc] init];
        [self.view addSubview:_studyRoomTableView];
        
        [_studyRoomTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }else if (AvailableSimpleTypeStudyRoomDetail == _type) {
        
        self.title = self.buildName;
//        switch (self.num) {
//            case 0:
//                self.title = @"文学部教学楼";
//                break;
//            case 1:
//                self.title = @"中央教学楼";
//                break;
//            case 2:
//                self.title = @"工学部教学楼";
//                break;
//            case 3:
//                self.title = @"理学部教学楼";
//                break;
//            case 4:
//                self.title = @"科研教学楼";
//                break;
//                
//            default:
//                break;
//        }
        
        [self setUpCustomNavgationBar:Question_Type];
        
        _studyRoomDetailTableView = [[StudyRoomDetailTableView alloc] initWithBuildName:_buildName];
        [self.view addSubview:_studyRoomDetailTableView];
        
        [_studyRoomDetailTableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.mas_equalTo(self.view);
        }];
    }
}


-(void)setUpCustomNavgationBar:(Navigation_Right_type) type
{
    //right barbutton view
    UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 30, KNavigationBarheight)];
    
    UIButton * remindBtn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 30, KNavigationBarheight)];
    remindBtn.backgroundColor = [UIColor clearColor];
    if (type == Choice_Type)
    {
        [remindBtn setImage:[UIImage imageNamed:@"have_time_select"] forState:UIControlStateNormal];
        [remindBtn addTarget:self
                      action:@selector(filterAction)
            forControlEvents:UIControlEventTouchUpInside];
    }
    else
    {
        [remindBtn setImage:[UIImage imageNamed:@"havetime_icon_prompt"] forState:UIControlStateNormal];
        [remindBtn addTarget:self
                      action:@selector(questionAction)
            forControlEvents:UIControlEventTouchUpInside];
    }
    [view addSubview:remindBtn];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:view];
}

//筛选Action
- (void)filterAction {
    if (_studyRoomTableView.campusDataSouceArr.count > 0)
    {
        ActivityChoiceController * choiceController = [[ActivityChoiceController alloc] initWithType:CLASSROOM_CHOICE_TYPE andDataSource:_studyRoomTableView.campusDataSouceArr andStudyRoomDefautStr:_studyRoomTableView.campusDataSouceArr[0]];
        choiceController.classViewController = self;
        [self.navigationController presentViewController:choiceController animated:YES completion:nil];
    }
    else
    {
        ActivityChoiceController * choiceController = [[ActivityChoiceController alloc] initWithType:CLASSROOM_CHOICE_TYPE andDataSource:_studyRoomTableView.campusDataSouceArr andStudyRoomDefautStr:nil];
        choiceController.classViewController = self;
        [self.navigationController presentViewController:choiceController animated:YES completion:nil];
    }
    
}

- (void)questionAction
{
    //h5页面
    NSLog(@"h5页面");
    YWebViewController * webView = [[YWebViewController alloc] initWithUrl:@"http://tips.xiaoyou.com/studyRoom/empty.html" andTitle:@"关于自习室" canClick:NO];
    [self.navigationController pushViewController:webView animated:YES];
}

@end
