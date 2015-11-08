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
#import "FeedManager.h"
#import "YModel+ActionMessage.h"

#define tagObj @"tagObj"
#define tagIsSelected @"tagIsSelected"
#define KTAGTABLEVIEWCELL @"KTAGTABLEVIEWCELL"
@interface ProfileTagViewController()<UITableViewDataSource, UITableViewDelegate>
@property (nonatomic, strong) NSMutableArray *tagsArray;//兴趣数据源
@property (nonatomic, strong) NSMutableSet *myTagName;//已经选择的兴趣
@property (nonatomic, strong) YTableView *tagTableView;

@property (nonatomic, assign) ProfileTagType type;
@property (nonatomic, copy) ProfileTagSelectedBlock block;
@end

@implementation ProfileTagViewController

- (id)initWithMyTags:(NSArray *)myTags type:(ProfileTagType)type {
    self = [super init];
    if (self) {
        _myTagName = [NSMutableSet set];
        for (int i = 0; i < myTags.count; i++) {
            [_myTagName addObject:[myTags[i] name]];
        }
        
        self.hidesBottomBarWhenPushed = true;
        _type = type;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    [self initController];
    [self initView];
}
- (void)initController {
    [self showCustomNavigationCancelButton];
    if (ProfileTagTypeAssociations == _type) {
        self.title = @"选社团分类";
    } else if (ProfileTagTypePerson == _type) {
        self.title = @"定义你的标签";
    }
    
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

- (void)endSelected:(ProfileTagSelectedBlock)block {
    _block = block;
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
    [super viewDidAppear:animated];
    if (ProfileTagTypeAssociations == _type) {
        [self initGroupConditions];
    } else if (ProfileTagTypePerson == _type) {
        [self initListTag];
    }
}

- (void)initGroupConditions {
    [[FeedManager sharedInstance] groupConditions:^(YActionMessage *message) {
        if (message.isSuccess) {
            //构造tag
            Tags *tag = [Tags new];
            tag.name = @"全部";
            _tagsArray = [@[[@{tagObj:tag,tagIsSelected:@(_myTagName.count <= 0)} mutableCopy]] mutableCopy];
            
            NSArray *tagList = message.object;
            [tagList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                BOOL isIn = [_myTagName containsObject:[obj name]];
                NSMutableDictionary *dic = [@{tagObj:obj,tagIsSelected:[NSNumber numberWithBool:isIn]} mutableCopy];
                [_tagsArray addObject:dic];
            }];
            
            //传入控件
            [_tagTableView reloadData];
            [self showCustomNavigationSureButton];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
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
            [self showCustomNavigationSureButton];
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
    NSInteger row = indexPath.row;
    _tagsArray[row][tagIsSelected] = @(![_tagsArray[row][tagIsSelected] boolValue]);
    [self updateCell:[tableView cellForRowAtIndexPath:indexPath] isChecked:[_tagsArray[row][tagIsSelected] boolValue]];
    if (ProfileTagTypeAssociations == _type && _tagsArray[row][tagIsSelected]) {
        if (0 == row) {
            //如果选择全部
            [_tagsArray enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                if (idx > 0) {
                    _tagsArray[idx][tagIsSelected] = @(NO);
                }
            }];
        } else {
            _tagsArray[0][tagIsSelected] = @(NO);
        }
        
        [_tagTableView reloadData];
    }
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = false;
    [self showOrignMode];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)onNavigationLeftButtonClicked {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)onNavigationRightButtonClicked {
    if (ProfileTagTypeAssociations == _type) {
        [_tagsArray removeObjectAtIndex:0];
        NSMutableString *tagStr = [@"" mutableCopy];
        [_tagsArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            if ([obj[tagIsSelected] boolValue]) {
                Tags *tags = obj[tagObj];
                if (tagStr.length > 0) {
                    [tagStr appendString:@","];
                }
                [tagStr appendString:tags.internalBaseClassIdentifier];
            }
        }];
        _block(tagStr);
        [self.navigationController dismissViewControllerAnimated:YES completion:nil];
    } else if (ProfileTagTypePerson == _type) {
        NSMutableString *tagStr = [@"" mutableCopy];
        [_tagsArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
            if ([obj[tagIsSelected] boolValue]) {
                Tags *tags = obj[tagObj];
                if (tagStr.length > 0) {
                    [tagStr appendString:@","];
                }
                [tagStr appendString:tags.internalBaseClassIdentifier];
            }
        }];
        [self uploadTagList:tagStr];
    }
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
