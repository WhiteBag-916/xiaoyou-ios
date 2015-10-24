//
//  FunnyDetaiViewController.m
//  XiaoYou
//
//  Created by sheng on 15/9/29.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityDetailViewController.h"
#import "ActivityDetailListView.h"
#import "ActivityModelTest.h"

@interface ActivityDetailViewController ()

@property (nonatomic,strong) ActivityDetailListView *detailListView;
@property (nonatomic,strong) UIButton *joinInBtn;
@end

@implementation ActivityDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self showCustomNavigationBackButton];
    [self detailListView];
    [self setTitle:@"活动详情"];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(ActivityDetailListView *)detailListView {
    if (!_detailListView) {
        _joinInBtn = [UIButton buttonWithType:UIButtonTypeSystem];
        [self.view addSubview:_joinInBtn];
        [_joinInBtn addTarget:self action:@selector(joinInAction) forControlEvents:UIControlEventTouchUpInside];
        _joinInBtn.layer.borderWidth = 0.6;
        [_joinInBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        _joinInBtn.layer.borderColor = KCOLORGRAY.CGColor;
        [_joinInBtn setTitle:@"我要加入" forState:UIControlStateNormal];
        [_joinInBtn setBackgroundColor:KCOLORGREEN_g1];
        [_joinInBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_joinInBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(-1);
            make.trailing.mas_equalTo(1);
            make.bottom.mas_equalTo(1);
            make.height.mas_equalTo(SCALE_NUM(45));
        }];
        
        _detailListView = [[ActivityDetailListView alloc]init];
        [self.view addSubview:_detailListView];
        [_detailListView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.leading.mas_equalTo(0);
            make.trailing.mas_equalTo(0);
            make.top.mas_equalTo(0);
            make.bottom.equalTo(_joinInBtn.mas_top);
        }];
        
    }
    _detailListView.model = [[self getDataSource] objectAtIndex:self.index];
    return _detailListView;
}


-(NSArray*)getDataSource
{
    ActivityModelTest *m1 = [[ActivityModelTest alloc]init];
    m1.acTitle = @"立艺为民 严以用权：仇立权廉政艺术绘画展";
    m1.acBrief = @"活动简介：在习近平总书记延安文艺工作座谈会讲话一周年之时，在举国上下全力推进从严治党、反腐倡廉的进程中，我校党委宣传部、纪检/监察处于10月23日至30日在宁远楼一层大厅，联合举办“立艺为民 严以用权——仇立权廉政艺术绘画展”。仇立权，毕业于中央工艺美术学院，现为中国国家画院刘大为工作室画家、刘大为工作室学术委员会委员、中国民主同盟盟员、通哲斋艺术馆馆长。擅长画人物、大写意动物，风格独树一帜，画作形神兼备，出版有《仇立权•感受与激情•人物动物速写》、《仇立权藏獒画册》、《仇立权人物画册》等多部绘画作品集，多次在国家博物馆、国家画院美术馆等举办画展。";
    m1.acPhotos = @"/dev/activity/52dfcb472d12c53dce33d6c85fbc152dc361b15310ba0-ApYcri_fw658.jpeg";
    m1.acLocation = @"北院礼堂";
    m1.acOgnazier = @"校团委";
    m1.acName = @"校级活动公告";
    m1.acHeadImage = @"http://img.sj33.cn/uploads/allimg/200801/2008012001210907.jpg";
    
    
    ActivityModelTest *m2 = [[ActivityModelTest alloc]init];
    m2.acTitle = @"西班牙风情文化介绍：西班牙建筑风格";
    m2.acBrief = @"活动简介：西班牙建筑风格，一般人认为是有庭院和纯白墙面，但这两个特点并不仅仅是西班牙建筑的特点，差不多地中海沿岸国家、中近东地区以至整个阿拉伯世界的建筑似乎都有着类似特征。那么，到底什么才是“西班牙建筑风格”，或许我们并不能用一句话或者是一个定义来作为衡量标准，建筑是文化的符号，建筑是凝固的艺术。米拉之家又叫米拉公寓，建于1906年-1912年间，是高迪设计的最后一个私人住宅。当时是富豪米拉先生因为非常欣赏高迪设计的巴特罗之家，所以也请高迪为自己的住宅做了设计。建筑是凝固的艺术，所以谈西班牙建筑离不开西班牙历史、文化及西班牙艺术。艺术来源于文化，独特的文化背景孕育了多元、神秘、奇异为特征的西班牙艺术，也孕育了别具一格的西班牙建筑风格。";
    m2.acPhotos = @"/dev/activity/bb0752f7564031bdd07b6a7a2d7390c34794710af4fa-uZz3ll_fw658.jpeg";
    m2.acLocation = @"大学生活动中心";
    m2.acOgnazier = @"外语学院组织部";
    m2.acName = @"院级活动公告";
    m2.acHeadImage = @"http://f.hiphotos.baidu.com/zhidao/wh%3D450%2C600/sign=0f33e2771c178a82ce6977a4c3335fbb/d0c8a786c9177f3eea1ce4b672cf3bc79f3d5664.jpg";
    
    
    ActivityModelTest *m3 = [[ActivityModelTest alloc]init];
    m3.acTitle = @"2015级新生心理健康教育讲座";
    m3.acBrief = @"活动简介：题为《过好大学每一天》的讲座。讲座围绕“和过去说再见”、“和现在说你好”、“学会拥有自信”、“学会珍爱自己”和“学会珍爱生命”五个方面展开。此次讲座是我校新生心理健康教育系列活动之一，配合此次讲座，我校还为新生提供了一系列心理健康宣传材料以帮助新生了解心理咨询服务、关注自身心理健康，为新同学在心理上尽快适应大学生活奠定了良好的基础。";
    m3.acPhotos = @"/dev/activity/7dbe607ed7062433d79039c33c50db38d9f7d5ef75f2d-JPP1Do_fw658.jpeg";
    m3.acLocation = @"中央教学楼1007教室";
    m3.acOgnazier = @"心理健康协会";
    m3.acName = @"社团活动公告";
    m3.acHeadImage = @"http://img.hb.aicdn.com/6bf5ff09d88c83043c5a7fc44460cbb46e6216bf1e4d3-MGHqhh_fw658";
    
    return [NSArray arrayWithObjects:m1,m2,m3,nil];
}


//参加某个活动的事件
- (void)joinInAction {
    NSLog(@"我要加入...");
}

@end
