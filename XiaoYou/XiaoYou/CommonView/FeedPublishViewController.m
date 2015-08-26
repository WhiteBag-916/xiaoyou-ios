//
//  FeedPublishViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/20.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "FeedPublishViewController.h"
#import "YTextView.h"
#import "FeedImageGroup.h"
#import "SKTagView.h"
#import "YCommonActionSheet.h"
#import "YDirectory+Data.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"
#import "SKTag.h"
#import "Tags.h"
#import "CommonSwitchView.h"
#import "YCommonAlertView.h"
#import "UIScrollView+UITouchEvent.h"

#define KTEXTVIEWMARGIN_LEFT SCALE_NUM(5)
#define KTEXTVIEWMARGIN_TOP SCALE_NUM(15)
#define KTEXTVIEWHEIGHT SCALE_NUM(60)

#define KIMGGROUPSIZE SCALE_NUM(242)
#define KIMGGROUPMARGIN_TOP SCALE_NUM(10)
#define KIMGGROUPMARGIN_LEFT SCALE_NUM(10)

#define KLINEMARGIN SCALE_NUM(15)

#define tagObj @"tagObj"
#define tagIsSelected @"tagIsSelected"

@interface FeedPublishViewController()<UIImagePickerControllerDelegate>


@property (nonatomic, strong) UIView *groupView;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) YTextView *textView;
@property (nonatomic, strong) FeedImageGroup *imgGroup;
@property (nonatomic, strong) SKTagView *tagView;
@property (nonatomic, strong) SKTagView *groupTag;
@property (nonatomic, strong) NSMutableArray *groupArray;

@property (nonatomic, assign) NSInteger groupIndex;
@property (nonatomic, strong) NSMutableArray *isChecked;

@property (nonatomic, strong) NSMutableArray *tagsArray;
@property (nonatomic, strong) CommonSwitchView *switchView;
@property (nonatomic, assign) BOOL isGroup;

@end

@implementation FeedPublishViewController
- (id)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = YES;
        _isChecked = [NSMutableArray array];
        _isGroup = false;
        _groupIndex = 0;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(openPhoto) name:KNotification_Present_TakePhoto object:nil];
    
}

- (void)initView {
    self.title = @"说两句";
    [self showCustomNavigationCancelButton];
    [self showCustomNavigationSureButton];
    
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self.view action:@selector(endEditing:)];
    [self.view addGestureRecognizer:tap];
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    _contentView = [[UIView alloc] init];
    [scroll addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    [self initGroupView];
    [self initTextView];
    [self initImgView];
    [self initBottom];
}
- (void)initGroupView {
    _groupView = [[UIView alloc] init];
    [_contentView addSubview:_groupView];
    [_groupView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KTEXTVIEWMARGIN_LEFT);
        make.top.mas_equalTo(KTEXTVIEWMARGIN_TOP);
        make.centerX.equalTo(_contentView);
    }];
    ProfileInfo *info = [[ProvisionManager sharedInstance] getProfile];
    if (info.managerGroups.count != 0) {
        UILabel *infoLabel = [YUtils initLabel:CONTENT_FONT(12) color:[UIColor blackColor] text:@"选择发布身份" frame:CGRectZero alignment:NSTextAlignmentLeft];
        [_groupView addSubview:infoLabel];
        [infoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_groupView);
        }];
        _switchView = [[CommonSwitchView alloc] initWithFrame:CGRectMake(0, 0, SCALE_NUM(70), SCALE_NUM(20)) textArray:@[@"个人", @"社团"]];
        [_groupView addSubview:_switchView];
        [_switchView changedType:^(CommonSwitchType type) {
            [self changeSwitchView:type];
        }];
        [_switchView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(infoLabel);
            make.top.equalTo(_groupView);
            make.right.equalTo(_groupView);
            make.width.mas_equalTo(SCALE_NUM(70));
            make.height.mas_equalTo(SCALE_NUM(20));
        }];
        [self initGroup:info.managerGroups];
    } else {
        [_groupView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.height.mas_equalTo(0);
        }];
        _groupView.hidden = true;
    }
}
- (void)initGroup:(NSArray *)groups {
    _groupTag = [[SKTagView alloc] init];
    [_groupView addSubview:_groupTag];
    [_groupTag mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_groupView);
        make.top.equalTo(_switchView.mas_bottom).offset(SCALE_NUM(25));
        make.bottom.equalTo(_groupView);
    }];
    [self changeSwitchView:0];
    _groupTag.insets = 5;
    _groupTag.lineSpace = 5;
    __weak FeedPublishViewController *weakSelf = self;
    [_groupTag setDidClickTagAtIndex:^(NSUInteger index) {
        [weakSelf updateGroupSelected:index];
    }];
    _groupArray = [@[] mutableCopy];
    [groups enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary *dic = [@{tagObj:obj,tagIsSelected:@NO} mutableCopy];
        [_groupArray addObject:[dic mutableCopy]];
    }];
    [self loadGroupTag];
}
- (void)updateGroupSelected:(NSInteger)select {
    if (_groupIndex == select) {
        return;
    }
    _groupArray[_groupIndex][tagIsSelected] = @NO;
    _groupArray[select][tagIsSelected] = @YES;
    [_groupTag updateTag:false atIndex:_groupIndex];
    [_groupTag updateTag:true atIndex:select];
    _groupIndex = select;
}
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    _groupTag.preferredMaxLayoutWidth = _groupTag.width;
}
- (void)changeSwitchView:(int)type {
    if (type == 0) {
        _isGroup = false;
        _groupTag.hidden = true;
        [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_groupView);
            make.centerX.equalTo(_groupView);
            make.top.equalTo(_switchView.mas_bottom);
            make.height.mas_equalTo(KTEXTVIEWHEIGHT);
        }];

    } else {
        _isGroup = true;
        _groupTag.hidden = false;
        [_textView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(_groupView);
            make.centerX.equalTo(_groupView);
            make.top.equalTo(_groupTag.mas_bottom);
            make.height.mas_equalTo(KTEXTVIEWHEIGHT);
        }];
    }
}
- (void)initTextView {
    _textView = [[YTextView alloc] init];
    [_contentView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_groupView);
        make.centerX.equalTo(_groupView);
        make.top.equalTo(_groupTag.mas_bottom).priorityLow();
        make.top.equalTo(_switchView.mas_bottom).priorityHigh();
        make.height.mas_equalTo(KTEXTVIEWHEIGHT);
    }];
    _textView.placeholder = @"发布优质内容，会有更多人给你敬酒";
    _textView.placeholderColor = KCOLORWHITE_b8b7b7;
    _textView.font = CONTENT_FONT(12);
}

- (void)initImgView {
    _imgGroup = [[FeedImageGroup alloc] initWithCamera];
    [_contentView addSubview:_imgGroup];
    [_imgGroup mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(KIMGGROUPMARGIN_LEFT);
        make.top.equalTo(_textView.mas_bottom).offset(KIMGGROUPMARGIN_TOP);
        make.width.mas_equalTo(KIMGGROUPSIZE);
    }];
    
    
}

- (void)initBottom {
    UIImageView *line = [[UIImageView alloc] init];
    [_contentView addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(_imgGroup);
        make.centerX.equalTo(_contentView);
        make.height.mas_equalTo(1);
        make.top.equalTo(_imgGroup.mas_bottom).offset(KLINEMARGIN);
    }];
    line.backgroundColor = [UIColor blackColor];
    
    UILabel *info = [[UILabel alloc] init];
    [_contentView addSubview:info];
    [info mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(line);
        make.top.equalTo(line.mas_bottom).offset(KLINEMARGIN);
        make.height.mas_equalTo(SCALE_NUM(10));
    }];
    info.font = CONTENT_FONT(10);
    info.text = @"选择以下标签，动态将会同步进入选中标签的列表中";
    
    _tagView = [[SKTagView alloc] init];
    [_contentView addSubview:_tagView];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(info);
        make.top.equalTo(info.mas_bottom).offset(KLINEMARGIN);
        make.bottom.lessThanOrEqualTo(_contentView);
    }];
    _tagView.insets = 5;
    _tagView.lineSpace = 5;
    __weak FeedPublishViewController *weakSelf = self;
    [_tagView setDidClickTagAtIndex:^(NSUInteger index) {
        [weakSelf updateTagSelected:index];
    }];
    [self initListTag];
}
- (void)initListTag {
    [[ProvisionManager sharedInstance] getTagList:^(YActionMessage *message) {
        if (message.isSuccess) {
            //构造tag
            _tagsArray = [@[] mutableCopy];
            _groupArray = [@[] mutableCopy];
            NSArray *tagList = message.object;
            [tagList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSMutableDictionary *dic = [@{tagObj:obj,tagIsSelected:@NO} mutableCopy];
                [_tagsArray addObject:dic];
                [_groupArray addObject:[dic mutableCopy]];
            }];
            
            //传入控件
            [self loadTag];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}
- (void)loadGroupTag {
    [_groupArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        Tags *tags = obj[tagObj];
        SKTag *tag = [SKTag tagWithText:tags.name];
        [tag updateWithPublishSelectType:false];
        [_groupTag addTag:tag];
    }];
    [_groupTag updateTag:true atIndex:0];
}
- (void)loadTag {
    [_tagsArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL *stop) {
        Tags *tags = obj[tagObj];
        SKTag *tag = [SKTag tagWithText:tags.name];
        [tag updateWithPublishSelectType:false];
        [_tagView addTag:tag];
    }];
}
- (void)updateTagSelected:(NSInteger)select {
    _tagsArray[select][tagIsSelected] = @(![_tagsArray[select][tagIsSelected] boolValue]);
    
    [_tagView updateTag:[_tagsArray[select][tagIsSelected] boolValue] atIndex:select];
}
- (void)openPhoto {
    [self showAddPicList];
}
- (void)showAddPicList {
    YActionSheetItem *item1 = [YActionSheetItem itemWithTitle:@"拍照"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self snapImage];
                                                        }];
    YActionSheetItem *item2 = [YActionSheetItem itemWithTitle:@"从相册中选择"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self pickImage];
                                                        }];
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item1, item2] title:nil];
    [sheet show];
}

- (void)pickImage
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [picker setDelegate:self];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)snapImage
{
#if !(TARGET_IPHONE_SIMULATOR)//真机执行的代码
    AVAuthorizationStatus authStatus = [AVCaptureDevice authorizationStatusForMediaType:AVMediaTypeVideo];
    if (authStatus == AVAuthorizationStatusRestricted ||authStatus ==AVAuthorizationStatusDenied){
        YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:nil
                                                                  message:@"您可以在 设置—>隐私—>相机中授权相机功能"
                                                             buttonTitles:@"确认", nil];
        [alert show];
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.delegate = self;
        [self presentViewController:picker animated:YES completion:nil];
    }
#endif
}

- (void)savePic:(UIImage *)image
{
    if (nil == image)
    {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *keyStr = [NSString stringWithFormat:@"feed%d.png", [_imgGroup getImgCount]];
        
        //写入文件
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSString *fullPath = [[YDirectory newImgCache] stringByAppendingPathComponent:keyStr];
        
        //保存到沙盒
        [imageData writeToFile:fullPath atomically:NO];
        
        //界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateImage];
        });
        
    });
}
- (void)updateImage {
    NSString *path = [YDirectory newImgCache:[NSString stringWithFormat:@"feed%d.png", [_imgGroup getImgCount]]];
    if (![YDirectory isDirectory:path])
    {
        [_imgGroup addPhoto:[UIImage imageWithContentsOfFile:path]];
    }
}
#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *getImage = info[@"UIImagePickerControllerOriginalImage"];
    [self savePic:getImage];
}
- (void)onNavigationLeftButtonClicked {
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self showEditMode];
}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    [self showOrignMode];
}
- (NSString *)getTagSelected {
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
    return tagStr;
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
@end
