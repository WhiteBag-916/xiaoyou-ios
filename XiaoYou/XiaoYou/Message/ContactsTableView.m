//
//  ContactsTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsTableView.h"
#import "ContactsTableViewCell.h"

@interface ContactsTableView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) NSMutableArray *contactsDataSource;

@end

@implementation ContactsTableView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.sectionIndexBackgroundColor = [UIColor whiteColor];
        self.sectionIndexColor = [UIColor blackColor];
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[ContactsTableViewCell class] forCellReuseIdentifier:kContactsTableViewCell];
    
    }
    
    return self;
}

- (BOOL)showHeaderRefresh
{
    return NO;
}

- (BOOL)showFooterRefresh
{
    return YES;
}

#pragma mark - UITableViewDataSource和UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 20;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ContactsTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kContactsTableViewCell];
    
    [cell setCellInfo];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

-(BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

-(NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"删除";
}
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        NSLog(@"delete");
    }
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
   
    return @[@"A",@"B",@"C"];
    
}


@end
