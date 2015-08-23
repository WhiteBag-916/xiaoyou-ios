//
//  ProfileTagViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/23.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "ProfileTagViewController.h"
#import "Tags.h"
#import "YTableView.h"
#import "ProvisionManager.h"

#define tagObj @"tagObj"
#define tagIsSelected @"tagIsSelected"
#define KTAGTABLEVIEWCELL @"KTAGTABLEVIEWCELL"
@interface ProfileTagViewController()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *tagsArray;
@property (nonatomic, strong) NSMutableSet *myTagName;
@property (nonatomic, strong) YTableView *tagTableView;
@end

@implementation ProfileTagViewController

- (id)initWithMyTags:(NSArray *)myTags {
    self = [super init];
    if (self) {
        _myTagName = [NSMutableSet set];
        for (int i = 0; i < myTags.count; i++) {
            [_myTagName addObject:[myTags[i] name]];
        }
        
        self.hidesBottomBarWhenPushed = true;
        
    }
    return self;
}
- (void)viewDidLoad {
    [self initController];
    [self initView];
}
- (void)initController {
    [self showCustomNavigationCancelButton];
    [self showCustomNavigationSureButton];
    self.title = @"定义你的标签";
    self.view.backgroundColor = [UIColor whiteColor];
}
- (void)initView {
    _tagTableView = [[YTableView alloc] init];
    [self.view addSubview:_tagTableView];
    [_tagTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [_tagTableView registerClass:[UITableViewCell class] forCellReuseIdentifier:KTAGTABLEVIEWCELL];
    _tagTableView.delegate = self;
    _tagTableView.dataSource = self;
    _tagTableView.tableFooterView = [UIView new];
}


- (void)updateCell:(UITableViewCell *)cell isChecked:(BOOL)isChecked {
    if (isChecked) {
        cell.backgroundColor = [UIColor hexChangeFloat:@"465A65"];
        cell.textLabel.textColor = KCOLORWHITE;
    } else {
        cell.backgroundColor = KCOLORWHITE;
        cell.textLabel.textColor = [UIColor blackColor];
    }
}

- (void)viewDidAppear:(BOOL)animated {
    [self initListTag];
}
- (void)initListTag {
    [[ProvisionManager sharedInstance] getTagList:^(YActionMessage *message) {
        if (message.isSuccess) {
            //构造tag
            _tagsArray = [@[] mutableCopy];
            
            NSArray *tagList = message.object;
            [tagList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                BOOL isIn = [_myTagName containsObject:[obj name]];
                NSMutableDictionary *dic = [@{tagObj:obj,tagIsSelected:[NSNumber numberWithBool:isIn]} mutableCopy];
                [_tagsArray addObject:dic];
            }];
            
            //传入控件
            [_tagTableView reloadData];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}
#pragma UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return _tagsArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return SCALE_NUM(42);
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KTAGTABLEVIEWCELL];
    cell.textLabel.text = [_tagsArray[indexPath.row][tagObj] name];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    [self updateCell:cell isChecked:[_tagsArray[indexPath.row][tagIsSelected] boolValue]];
    return cell;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    _tagsArray[indexPath.row][tagIsSelected] = @(![_tagsArray[indexPath.row][tagIsSelected] boolValue]);
    [self updateCell:[tableView cellForRowAtIndexPath:indexPath] isChecked:[_tagsArray[indexPath.row][tagIsSelected] boolValue]];
}
- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBarHidden = false;
    [self showOrignMode];
}
- (void)onNavigationLeftButtonClicked {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)onNavigationRightButtonClicked {
    NSMutableString *tagStr = [@"" mutableCopy];
    [_tagsArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        if ([obj[tagIsSelected] boolValue]) {
            Tags *tags = obj[tagObj];
            if (tagStr.length > 0) {
                [tagStr appendString:@","];
            }
            [tagStr appendString:[NSString stringWithFormat:@"%.f", tags.internalBaseClassIdentifier]];
        }
    }];
    [self uploadTagList:tagStr];
}
- (void)uploadTagList:(NSString *)tagStr {
    
    [[ProvisionManager sharedInstance] uploadTagCodes:tagStr block:^(YActionMessage *message) {
        if (message.isSuccess) {
            //更新缓存标签
            NSMutableArray *tagArray = [@[] mutableCopy];
            [_tagsArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
                if ([obj[tagIsSelected] boolValue]) {
                    [tagArray addObject:obj[tagObj]];
                }
            }];
            [[ProvisionManager sharedInstance] updateTagList:tagArray];
            [self dismissViewControllerAnimated:true completion:^{
                
            }];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}
@end
