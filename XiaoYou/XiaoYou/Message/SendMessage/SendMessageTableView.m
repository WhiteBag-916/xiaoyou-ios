//
//  SendMessageTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "SendMessageTableView.h"
#import "SendMessageTableViewCell.h"
#import "MessageManager.h"
#import "SuggestListModel.h"

@interface SendMessageTableView ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)NSArray * dataSouceArr;

@end

@implementation SendMessageTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;

        [[MessageManager sharedInstance] getSuggestList:^(YActionMessage *message) {
            if (message.isSuccess)
            {
                SuggestListModel * model = message.object;
                [self refreshTableView:model.suggest];
            }
        }];
        self.separatorStyle = UITableViewCellSelectionStyleNone;
        [self registerClass:[SendMessageTableViewCell class] forCellReuseIdentifier:kSendMessageTableViewCell];
    }
    return self;
}

#pragma mark - 刷新界面

-(void)refreshTableView:(NSArray *) dataSouceArr
{
    _dataSouceArr = [[NSMutableArray alloc] initWithArray:dataSouceArr];
    [self reloadData];
}

#pragma mark - UITableViewDataSource 和 UITableViewDataDelegate

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
    
    SendMessageTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kSendMessageTableViewCell forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleDefault;
    [cell setCellInfo:_dataSouceArr[indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(38);
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([self.myDelegate respondsToSelector:@selector(didSelectCell:)])
    {
        [self.myDelegate didSelectCell:_dataSouceArr[indexPath.row]];
    }
}

@end
