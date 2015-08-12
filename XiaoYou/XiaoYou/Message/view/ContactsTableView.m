//
//  ContactsTableView.m
//  XiaoYou
//
//  Created by HuiYin on 15/8/6.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ContactsTableView.h"
#import "ContactsTableViewCell.h"
#import "LinkManModel.h"
#import "Pinyin.h"
#import "YLog.h"

#define kRowHeight          60

@interface ContactsTableView ()<UITableViewDataSource,UITableViewDelegate>

//原始数据源
@property (nonatomic,strong) NSMutableArray *originalContactsDataSource;
//转换后数据源
@property (nonatomic,strong) NSMutableArray *contactsDataSource;
@property (nonatomic,strong) NSMutableArray *indexTitleArr;

@property (nonatomic,strong) NSIndexPath * deleteIndexPathOfCell;

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


-(void)refreshTableView:(NSMutableArray *) dataSouceArr
{
    self.originalContactsDataSource = [NSMutableArray arrayWithArray:dataSouceArr];
    self.indexTitleArr = [[NSMutableArray alloc] init];
    self.contactsDataSource = [NSMutableArray arrayWithArray:[self transformDataSouceArr:dataSouceArr]];
    [self reloadData];
}

-(NSMutableArray *)transformDataSouceArr:(NSMutableArray *) dataSouceArr
{
    NSMutableArray * resultDataSouceArr = [[NSMutableArray alloc] init];
    NSMutableArray * tempTransitonArr = [[NSMutableArray alloc] init];
    NSMutableArray * transitonArr = [[NSMutableArray alloc] init];
    LinkManModel * lastModel = dataSouceArr.lastObject;
    NSString * lastName = lastModel.linkStudentName;
    //取出所有模型，将数据拆分成section（firstIndexTitleArr）数组和sectionRows(transitonArr)数组
    [dataSouceArr enumerateObjectsUsingBlock:^(LinkManModel * model, NSUInteger idx1, BOOL *stop2) {
        
        char temp =  pinyinFirstLetter([model.linkStudentName characterAtIndex:0]);
        
        NSString * firstStr = [NSString stringWithFormat:@"%c",temp].uppercaseString;
        
        if([self.indexTitleArr containsObject:firstStr.uppercaseString] == NO)
        {
            if (tempTransitonArr.count > 0) {
                [transitonArr addObject:[NSArray arrayWithArray: tempTransitonArr]];
            }
            [tempTransitonArr removeAllObjects];
            
            [self.indexTitleArr addObject:firstStr];
            
            NSDictionary * dic = [self transformModelToDictionary:model];

            [tempTransitonArr addObject:dic];
            
            if ([lastName isEqualToString:model.linkStudentName])
            {
                [transitonArr addObject:[NSArray arrayWithArray: tempTransitonArr]];
            }
        }
        else
        {
            NSDictionary * dic = [self transformModelToDictionary:model];
            [tempTransitonArr addObject:dic];
            
            if ([lastName isEqualToString:model.linkStudentName])
            {
                [transitonArr addObject:[NSArray arrayWithArray: tempTransitonArr]];
            }
        }
        
    }];
    
    //将section（firstIndexTitleArr）数组和sectionRows(transitonArr)数组合并成一个数组（finishdataSouceArr）
    
    [self.indexTitleArr enumerateObjectsUsingBlock:^(NSString * obj, NSUInteger idx, BOOL *stop2) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
        [dic setObject:obj forKey:@"index_title"];
        
        [dic setObject:transitonArr[idx] forKey:@"user_info"];
        
        [resultDataSouceArr addObject:dic];
    }];

    return resultDataSouceArr;
}

-(NSDictionary *)transformModelToDictionary:(LinkManModel *) model
{
    NSMutableDictionary * dic = [[NSMutableDictionary alloc] init];
    if (model.linkStudentName != nil) {
        [dic setObject:model.linkStudentName forKey:@"linkStudentName"];
    }
    if (model.myStudentNo != nil) {
        [dic setObject:model.myStudentNo forKey:@"myStudentNo"];
    }
    if (model.linkStudentNo != nil) {
        [dic setObject:model.linkStudentNo forKey:@"linkStudentNo"];
    }
    if (model.tag != nil) {
        [dic setObject:model.tag forKey:@"tag"];
    }
    if (model.icon != nil) {
        [dic setObject:model.icon forKey:@"icon"];
    }
    if (model.internalBaseClassIdentifier != nil) {
        [dic setObject:model.internalBaseClassIdentifier forKey:@"iid"];
    }
    if (model.isShield != nil) {
        [dic setObject:model.isShield forKey:@"isShield"];
    }
    if (model.isRemind != nil) {
        [dic setObject:model.isRemind forKey:@"isRemind"];
    }
    if (model.time != nil) {
        [dic setObject:model.time forKey:@"time"];
    }
    return dic;
}

#pragma mark - UITableViewDataSource和UITableViewDelegate

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.contactsDataSource.count;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSArray * arr = self.contactsDataSource[section][@"user_info"];
    return arr.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    ContactsTableViewCell * cell = [self dequeueReusableCellWithIdentifier:kContactsTableViewCell];
    
    [cell setCellInfo:self.contactsDataSource[indexPath.section][@"user_info"][indexPath.row]];
    
    return cell;
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kRowHeight;
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
        self.deleteIndexPathOfCell = indexPath;
        UIAlertView * alertView = [[UIAlertView alloc] initWithTitle:@"确定删除此人？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [alertView show];
    }
}

-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
   
    return self.indexTitleArr;
    
}

#pragma mark - UIAlterViewDelegate

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        YLogD(@"contactDelete");
        YLogD(@"%@",self.deleteIndexPathOfCell);
        ContactsTableViewCell * cell = (ContactsTableViewCell *)[self cellForRowAtIndexPath:self.deleteIndexPathOfCell];
        YLogD(@"%@",cell.linkStudentNo);
        
        [self.originalContactsDataSource enumerateObjectsUsingBlock:^(LinkManModel * obj, NSUInteger idx, BOOL *stop) {
            if ([obj.linkStudentNo isEqualToString:cell.linkStudentNo])
            {
                [self.originalContactsDataSource removeObject:obj];
                [self refreshTableView:self.originalContactsDataSource];
                
//                [self deleteContactListRequest:cell.linkStudentNo];
            }
        }];
      
    }
}

@end
