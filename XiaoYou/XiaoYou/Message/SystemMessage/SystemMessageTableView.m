//
//  SystemMessageTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SystemMessageTableView.h"
#import "NormalSystemMessageTableViewCell.h"
#import "ApplySuccessSystemMessageTableViewCell.h"

@interface SystemMessageTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSMutableArray * dataSouceArr;

@end

@implementation SystemMessageTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        
        _dataSouceArr = [@[@"自我介绍一下呗",@"请发送简历至",@"面试通知",@"你的兴趣爱好",@"你喜欢男生还是女生",@"你是单身吗",@"你可以向我问个问题"] mutableCopy];
        [self registerClass:[NormalSystemMessageTableViewCell class] forCellReuseIdentifier:kNormalSystemMessageTableViewCell];
        [self registerClass:[ApplySuccessSystemMessageTableViewCell class] forCellReuseIdentifier:kApplySuccessSystemMessageTableViewCell];
    }
    return self;
}

-(void)refreshTableView:(NSMutableArray *) dataSouceArr
{
    [self reloadData];
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataSouceArr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NormalSystemMessageTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kNormalSystemMessageTableViewCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    [cell setCellInfo:_dataSouceArr[indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 38;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
  
}

@end
