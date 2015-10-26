//
//  ActivityIdentityTableView.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/23.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "ActivityIdentityTableView.h"
#import "ActivityIdentityTableViewCell.h"

@interface ActivityIdentityTableView ()<UITableViewDataSource,UITableViewDelegate>

@end

@implementation ActivityIdentityTableView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.scrollEnabled = NO;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        [self registerClass:[ActivityIdentityTableViewCell class] forCellReuseIdentifier:kActivityIdentityTableViewCell];
        [self setUpHeaderView];
    }
    return self;
}

-(void)setUpHeaderView
{
    UIView * backView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCALE_NUM(40))];
    UILabel * remindLabel = [[UILabel alloc] init];
    remindLabel.font = CONTENT_FONT(SCALE_NUM(12));
    remindLabel.textColor = KCOLORGREEN_g1;
    remindLabel.textAlignment = NSTextAlignmentLeft;
    remindLabel.text = @"请选择活动发布社团/学生组织";
    [backView addSubview:remindLabel];
    [remindLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(40));
        make.right.mas_equalTo(SCALE_NUM(-40));
        make.top.mas_equalTo(SCALE_NUM(5));
        make.bottom.mas_equalTo(SCALE_NUM(-5));
    }];
    
//    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(0, self.frame.size.height-1, self.frame.size.width, 1)];
//    line.backgroundColor = [UIColor hexChangeFloat:@"e9e9e9"];
//    [backView addSubview:line];
    
    self.tableHeaderView = backView;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ActivityIdentityTableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:kActivityIdentityTableViewCell forIndexPath:indexPath];
    [cell setCellInfo:@"就是一只什么熊大哥啦底格里匹克皮"];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(40);
}

@end
