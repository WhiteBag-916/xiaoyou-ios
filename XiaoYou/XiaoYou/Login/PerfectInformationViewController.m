//
//  PerfectInformationViewController.m
//  XiaoYou
//
//  Created by 熊宸 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import "PerfectInformationViewController.h"
#import "SKTagView.h"
#import "YUtils+UI.h"
#import "Tags.h"
#import "ProvisionManager.h"
#import "Tags.h"
#import "YCommonActionSheet.h"
#import "YDirectory+Data.h"
#import "AppDelegate+RootVC.h"

NSString *const tagObj = @"tagObj";
NSString *const tagIsSelected = @"tagIsSelected";

@interface PerfectInformationViewController ()
<UIImagePickerControllerDelegate>

@property (nonatomic, strong) UIButton *headButton;
@property (nonatomic, strong) UIView *contentView;
@property (nonatomic, strong) SKTagView *tagView;
@property (nonatomic, strong) NSString *headImagePath;
@property (nonatomic, strong) NSMutableArray *tagsArray;

@end

@implementation PerfectInformationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"完善个人资料";
    [self showCustomNavigationNextButton];
    
    [self initView];
    
    [self initListTag];
}

- (void)initView {
    UIScrollView *scrollView = [UIScrollView new];
    scrollView.backgroundColor = KCOLORGREEN_e6ebea;
    [self.view addSubview:scrollView];
    [scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    //contentView
    _contentView = [UIView new];
    [scrollView addSubview:_contentView];
    [_contentView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scrollView);
        make.width.equalTo(scrollView);
    }];
    
    //headButton
    _headButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_headButton setImage:[UIImage imageNamed:@"register-photo-upload"] forState:UIControlStateNormal];
    [_headButton addTarget:self action:@selector(showAddPicList) forControlEvents:UIControlEventTouchUpInside];
    [_contentView addSubview:_headButton];
    [_headButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.top.mas_equalTo(SCALE_NUM(34));
        make.width.height.mas_equalTo(SCALE_NUM(70));
    }];
    
    //labelView
    UIImageView *upHeadImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register-photo-upload-boundary"]];
    [_contentView addSubview:upHeadImageView];
    [upHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.top.equalTo(_headButton.mas_bottom).offset(SCALE_NUM(22));
        make.width.mas_equalTo(SCALE_NUM(217));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    UIImageView *tagImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"register-label-chosen-boundary"]];
    [_contentView addSubview:tagImageView];
    [tagImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.top.equalTo(upHeadImageView.mas_bottom).offset(SCALE_NUM(41));
        make.width.mas_equalTo(SCALE_NUM(217));
        make.height.mas_equalTo(SCALE_NUM(12));
    }];
    
    //label
    UILabel *tagLabel = [YUtils initLabel:CONTENT_FONT(12)
                                    color:KCOLORGREEN_455A64
                                     text:@"点选标签有助于你认识贵族同领域的行家"
                                    frame:CGRectZero
                                alignment:NSTextAlignmentCenter];
    [_contentView addSubview:tagLabel];
    [tagLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_contentView);
        make.top.equalTo(tagImageView.mas_bottom).offset(SCALE_NUM(16));
        make.height.mas_equalTo(SCALE_NUM(24));
    }];
    
    //tagView
    _tagView = [[SKTagView alloc] init];
    _tagView.backgroundColor = [UIColor clearColor];
    [_contentView addSubview:_tagView];
    [_tagView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(_contentView);
        make.width.mas_equalTo(185);
        make.top.equalTo(tagLabel.mas_bottom).offset(SCALE_NUM(26));
        make.bottom.equalTo(_contentView);
    }];
    _tagView.insets = 5;
    _tagView.lineSpace = 5;
    WS(weakSelf);
    [_tagView setDidClickTagAtIndex:^(NSUInteger index) {
        [weakSelf updateTagSelected:index];
    }];
}

//获取taglist
- (void)initListTag {
    [[ProvisionManager sharedInstance] getTagList:^(YActionMessage *message) {
        if (message.isSuccess) {
            //构造tag
            _tagsArray = [@[] mutableCopy];
            
            NSArray *tagList = message.object;
            [tagList enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
                NSMutableDictionary *dic = [@{tagObj:obj,tagIsSelected:@NO} mutableCopy];
                [_tagsArray addObject:dic];
            }];
            
            //传入控件
            [self loadTag];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
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
    if (_headImagePath.length > 0) {
        [self uploadHeadImage:^(YActionMessage *message) {
            if (tagStr.length > 0) {
                [self uploadTagList:tagStr];
            }
        }];
    } else if (tagStr.length > 0) {
        [self uploadTagList:tagStr];
    }else {
        [self toTabBar];
    }
}

//上传头像
- (void)uploadHeadImage:(void(^)())block {
    NSString *path = [YDirectory newImgCache:_headImagePath];
    [[ProvisionManager sharedInstance] uploadHeadImage:path
                                                 block:^(YActionMessage *message) {
                                                     if (message.isSuccess) {
                                                         block();
                                                     } else {
                                                         [YUtils showTitle:message.desc];
                                                     }
                                                 }];
}

//上传标签
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
            
            [self toTabBar];
        } else {
            [YUtils showTitle:message.desc];
        }
    }];
}

- (void)toTabBar {
    //跳转登录
    [kAppDelegateAccessor initTabBarNC];
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
    [picker setAllowsEditing:YES];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)snapImage
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
    picker.delegate = self;
    [picker setAllowsEditing:YES];
    [self presentViewController:picker animated:YES completion:nil];
}

- (void)savePic:(UIImage *)image
{
    if (nil == image)
    {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        //根据时间格式确保文件名唯一性
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        NSDate *date = [[NSDate alloc] init];
        [formatter setDateFormat:@"YYYY_MM_dd_HH_mm_ss"];
        NSString *keyStr = [[formatter stringFromDate:date] stringByAppendingString:@".png"];
        
        //写入文件
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSString *fullPath = [[YDirectory newImgCache] stringByAppendingPathComponent:keyStr];
        
        //保存到沙盒
        [imageData writeToFile:fullPath atomically:NO];
        
        //路径添加至缓存
        _headImagePath = keyStr;
        
        //界面
        dispatch_async(dispatch_get_main_queue(), ^{
            [self updateAddImageButton];
        });
        
    });
}

//更新头像
- (void)updateAddImageButton
{
    if (_headImagePath.length > 0)
    {
        NSString *path = [YDirectory newImgCache:_headImagePath];
        
        if (![YDirectory isDirectory:path])
        {
            //存在
            [_headButton setImage:[UIImage imageWithContentsOfFile:path] forState:UIControlStateNormal];
            _headButton.layer.cornerRadius = 10;
            _headButton.layer.masksToBounds = YES;
        }
    }
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *getImage = info[@"UIImagePickerControllerEditedImage"];
    [self savePic:getImage];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
