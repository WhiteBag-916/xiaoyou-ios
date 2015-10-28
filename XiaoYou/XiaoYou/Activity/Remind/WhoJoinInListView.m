//
//  WhoJoinInListView.m
//  XiaoYou
//
//  Created by sheng on 15/10/21.
//  Copyright © 2015年 xc. All rights reserved.
//

#import "WhoJoinInListView.h"

@interface WhoJoinInListView ()
<UITableViewDataSource,UITableViewDelegate>

@end

@implementation WhoJoinInListView

-(instancetype)init
{
    if (self = [super init]) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style {
    if (self = [super initWithFrame:frame style:style]) {
        self.delegate = self;
        self.dataSource = self;
    }
    
    return self;
}


#pragma mark 协议方法
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return SCALE_NUM(300);
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}
@end
