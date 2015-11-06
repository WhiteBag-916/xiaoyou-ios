//
//  ProfileMyViewController.m
//  XiaoYou
//
//  Created by 李思良 on 15/8/22.
//  Copyright (c) 2015年 xc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "ProfileMyViewController.h"
#import "UIImageView+WebCache.h"
#import "ProfileChangePwdViewController.h"
#import "ProfilePhoneChangeViewController.h"
#import "ProvisionManager.h"
#import "ProfileInfo.h"
#import "LoginResp.h"
#import "YCommonActionSheet.h"
#import "YDirectory+Data.h"
#import "SDPhotoBrowser.h"
#import "YCommonAlertView.h"
#import "YModel+ActionMessage.h"
#import "ImageUploadModel.h"
#import "CodeEnlargeView.h"

#define KHEADHEIGHT SCALE_NUM(150)

#define KIMGSIZE SCALE_NUM(88)

@interface ProfileMyViewController()<UIImagePickerControllerDelegate,SDPhotoBrowserDelegate>
//布局用的view
@property (nonatomic, strong) UIView *containerView;
@property (nonatomic, strong) UIView *headView;
@property (nonatomic, strong) UIView *faceContainer;
@property (nonatomic, strong) UIView *middelView;
@property (nonatomic, strong) UIView *bottomView;

@property (nonatomic, strong) UIImageView *codeView;//二维码
@property (nonatomic, strong) CodeEnlargeView * codeEnlargeView;
@property (nonatomic, strong) UIImageView *faceImg;//头像
@property (nonatomic, strong) UILabel *nameLabel;//姓名
@property (nonatomic, strong) UILabel *schoolNoLabel;//学号
@property (nonatomic, strong) UILabel *schoolLabel;//学校
@property (nonatomic, strong) UILabel *departmentLabel;//院系
@property (nonatomic, strong) UILabel *gradeLabel;//年级
@property (nonatomic, strong) UILabel *classLabel;//班级

@property (nonatomic, strong) NSString *headImagePath;//头像路径
@property (nonatomic, strong) UIImagePickerController *picker;

@property (nonatomic, assign) BOOL isHeadImageUploadEnd;//头像是否上传完成 add by sheng

@property (nonatomic, assign) UIButton  *exitButton;
@end

@implementation ProfileMyViewController
- (id)init {
    self = [super init];
    if (self) {
        self.hidesBottomBarWhenPushed = true;
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tokenFail) name:kNotification_Server_Token_Fail object:nil];
    
    self.view.backgroundColor = KCOLORWHITE;
    [self initView];
}
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBarHidden = true;
    [self loadData];
}
- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (void)tokenFail {
    [self.picker dismissViewControllerAnimated:NO completion:nil];
}
- (void)loadData {
    ProfileInfo *info = [[ProvisionManager sharedInstance] getProfile];
    [_faceImg setFaceImageWithUrl:info.headPic];
    _nameLabel.text = info.userName;
    _schoolNoLabel.text = info.studentNo;
    LoginResp *resp = [[ProvisionManager sharedInstance] getLoginInfo];
    _schoolLabel.text = resp.schoolName;
    _departmentLabel.text = resp.college;
    _gradeLabel.text = resp.grad;
    _classLabel.text = resp.studentClass;
    if (resp.mobilePhone.length == 0) {
        [_bottomView.subviews[0] setEnabled:false];
        [_bottomView.subviews[0] setUserInteractionEnabled:false];
    } else {
        [_bottomView.subviews[0] setEnabled:true];
        [_bottomView.subviews[0] setUserInteractionEnabled:true];
    }
    
}
- (void)initView {
    [self initScroll];
    [self initTop];
    [self initMiddle];
    [self initBottom];
}
- (void)initScroll {
    UIScrollView *scroll = [[UIScrollView alloc] init];
    [self.view addSubview:scroll];
    scroll.showsVerticalScrollIndicator = false;
    [scroll mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.view).offset(0);
    }];
    _containerView = [[UIView alloc] init];
    [scroll addSubview:_containerView];
    [_containerView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(scroll);
        make.width.equalTo(scroll);
    }];
}
- (void)initTop {
    _headView = [[UIView alloc] init];
    _headView.userInteractionEnabled = YES;
    [_containerView addSubview:_headView];
    [_headView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(_containerView);
        make.height.mas_equalTo(KHEADHEIGHT);
    }];
    _headView.backgroundColor = KCOLOR_455A64;
    
    _faceContainer = [[UIView alloc] init];
    _faceContainer.userInteractionEnabled = YES;
    [_containerView addSubview:_faceContainer];
    [_faceContainer mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(KIMGSIZE);
        make.center.equalTo(_headView);
    }];
    
    _faceImg = [[UIImageView alloc] init];
    [_faceContainer addSubview:_faceImg];
    [_faceImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(_faceContainer);
    }];
    _faceImg.layer.cornerRadius = KIMGSIZE/2;
    _faceImg.clipsToBounds = true;
    _faceImg.image = [UIImage imageNamed:@"default_head"];
    _faceImg.userInteractionEnabled = true;
    [_faceImg addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(showAddPicList)]];
    
    UIImageView *back = [[UIImageView alloc] init];
    [_headView addSubview:back];
    back.image = [UIImage imageNamed:@"common_back"];
    [back mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(SCALE_NUM(10));
        make.width.mas_equalTo(SCALE_NUM(9));
        make.height.mas_equalTo(SCALE_NUM(14));
        make.centerY.equalTo(_headView);
    }];
    
    _codeView = [[UIImageView alloc] init];
    _codeView.userInteractionEnabled = YES;
    _codeView.alpha = 1;
    _codeView.image = [UIImage imageNamed:@"mine_icon_code"];
    [self.view addSubview:_codeView];
    [_codeView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCALE_NUM(30));
        make.bottom.right.equalTo(_headView).offset(-15);
    }];
    _codeView.backgroundColor = [UIColor clearColor];
    
    UIButton * codeButton = [[UIButton alloc] init];
    codeButton.backgroundColor = [UIColor clearColor];
    [self.view addSubview:codeButton];
    [codeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.height.mas_equalTo(SCALE_NUM(50));
        make.center.equalTo(_codeView);
    }];
    [codeButton addTarget:self action:@selector(openCode) forControlEvents:UIControlEventTouchUpInside];
    
    //[_headView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(goBack)]];
    
//    _exitButton = [UIButton buttonWithType:UIButtonTypeSystem];
//    [_headView addSubview:_exitButton];
//    _exitButton.backgroundColor = [UIColor clearColor];
//    [_exitButton addTarget:self action:@selector(goBack) forControlEvents:UIControlEventTouchUpInside];
//    [_exitButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.bottom.mas_equalTo(0);
//        make.leading.mas_equalTo(0);
//        make.width.mas_equalTo(SCALE_NUM(120));
//    }];
}
- (void)initMiddle {
    _middelView = [[UIView alloc] init];
    [_containerView addSubview:_middelView];
    [_middelView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_containerView);
        make.top.equalTo(_headView.mas_bottom);
    }];
    _nameLabel = [self labelWithColor:false size:15];
    [_nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_middelView).offset(SCALE_NUM(20));
    }];
    
    _schoolNoLabel = [self labelWithColor:false size:12];
    [_schoolNoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_nameLabel.mas_bottom).offset(SCALE_NUM(12));
    }];
    
    _schoolLabel = [self labelWithColor:true size:14];
    [_schoolLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_schoolNoLabel.mas_bottom).offset(SCALE_NUM(40));
    }];
    
    _departmentLabel = [self labelWithColor:true size:14];
    [_departmentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_schoolLabel.mas_bottom).offset(SCALE_NUM(12));
    }];
    
    _gradeLabel = [self labelWithColor:true size:14];
    [_gradeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_departmentLabel.mas_bottom).offset(SCALE_NUM(12));
    }];
    
    _classLabel = [self labelWithColor:true size:14];
    [_classLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_gradeLabel.mas_bottom).offset(SCALE_NUM(12));
        make.bottom.equalTo(_middelView);
    }];
    
}

- (void)initBottom {
    _bottomView = [[UIView alloc] init];
    [_containerView addSubview:_bottomView];
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (isScreen3_5Inch) {
            make.top.equalTo(_middelView.mas_bottom).offset(SCALE_NUM(24));
        } else {
            make.top.greaterThanOrEqualTo(_middelView.mas_bottom).offset(SCALE_NUM(24));
        }
        make.left.right.bottom.equalTo(_containerView);
        make.bottom.equalTo(self.view).priorityLow();
    }];
    UIView *tmp = nil;
    for (int i = 0; i < 3; i++) {
        UILabel *label = [self labelWithType:i];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            if (tmp == nil) {
                make.top.equalTo(_bottomView);
            } else {
                make.top.equalTo(tmp.mas_bottom).offset(SCALE_NUM(2));
            }
        }];
        tmp = label;
    }
    [_bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(tmp);
    }];
    
}

- (UILabel *)labelWithColor:(BOOL)isGreen size:(float)size{
    UILabel *label = [YUtils initLabel:CONTENT_FONT(size) color:(isGreen?KCOLOR_009688:[UIColor blackColor]) text:@"" frame:CGRectZero alignment:NSTextAlignmentCenter];
    [_middelView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_middelView);
        make.height.mas_equalTo(SCALE_NUM(15));
    }];
    return label;
}

- (UILabel *)labelWithType:(int)type {
    NSArray *names = @[@"修改绑定手机号", @"修改密码", @"退出"];
    UILabel *label = [YUtils initLabel:CONTENT_FONT(12) color:KCOLOR_455A64 text:names[type] frame:CGRectZero alignment:NSTextAlignmentCenter];
    [_bottomView addSubview:label];
    [label mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_bottomView);
        make.height.mas_equalTo(SCALE_NUM(48));
    }];
    label.backgroundColor = KCOLOR_f2f2f2;
    label.userInteractionEnabled = true;
    
    UIView *line = [[UIView alloc] init];
    [label addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(label);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = KCOLOR_455A64;
    
    line = [[UIView alloc] init];
    [label addSubview:line];
    [line mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.equalTo(label);
        make.height.mas_equalTo(1);
    }];
    line.backgroundColor = KCOLOR_455A64;
    
    
    switch (type) {
        case 0:
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePhone)]];
            break;
        case 1:
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(changePwd)]];
            break;
        case 2:
            [label addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(logOut)]];
            break;
        default:
            break;
    }
    
    return label;
}




//打开二维码图片
- (void)openCode {
    NSLog(@"放大二维码");
    
    ProfileInfo *info = [[ProvisionManager sharedInstance] getProfile];
    LoginResp *resp = [[ProvisionManager sharedInstance] getLoginInfo];
    _codeEnlargeView = [[CodeEnlargeView alloc] initWithModel1:info andModel2:resp];
    
    [_codeEnlargeView show];
    
}

- (void)showAddPicList {
    
    YActionSheetItem *item = [YActionSheetItem itemWithTitle:@"查看大图"
                                                         type:YCommonActionSheetItemTypeCenterCommon
                                                        block:^(NSInteger checkNum) {
                                                            [self choosePic];
                                                        }];
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
    
    YCommonActionSheet *sheet = [[YCommonActionSheet alloc] initWithType:@[item, item1, item2] title:nil];
    [sheet show];
}
//查看头像大图
- (void)choosePic {

    SDPhotoBrowser *browser = [[SDPhotoBrowser alloc] init];
    
    browser.sourceImagesContainerView = _faceContainer;
    
    browser.imageCount = 1;
    
    browser.currentImageIndex = 0;
    
    browser.delegate = self;
    
    [browser show];
}

#pragma SDPhotoBrowser
- (UIImage *)photoBrowser:(SDPhotoBrowser *)browser placeholderImageForIndex:(NSInteger)index {
    return _faceImg.image;
}

- (void)pickImage
{
    self.isHeadImageUploadEnd = NO;
    self.picker = [[UIImagePickerController alloc] init];
    [self.picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [self.picker setDelegate:self];
    [self.picker setAllowsEditing:YES];
    [self presentViewController:self.picker animated:YES completion:nil];
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
    }else if(authStatus == AVAuthorizationStatusNotDetermined){
        // Explicit user permission is required for media capture, but the user has not yet granted or denied such permission.
        [AVCaptureDevice requestAccessForMediaType:AVMediaTypeVideo completionHandler:^(BOOL granted) {
            if(granted){//点击允许访问时调用
                //用户明确许可与否，媒体需要捕获，但用户尚未授予或拒绝许可。
                self.picker = [[UIImagePickerController alloc] init];
                [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
                self.picker.delegate = self;
                [self.picker setAllowsEditing:YES];
                [self presentViewController:self.picker animated:YES completion:nil];
            }
        }];
    }else{
        self.picker = [[UIImagePickerController alloc] init];
        [self.picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        self.picker.delegate = self;
        [self.picker setAllowsEditing:YES];
        [self presentViewController:self.picker animated:YES completion:nil];
    }
#endif
}
//保存头像
- (void)savePic:(UIImage *)image
{
    if (nil == image)
    {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        NSString *keyStr = @"face.png";
        
        //写入文件
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSString *fullPath = [[YDirectory newImgCache] stringByAppendingPathComponent:keyStr];
        
        //保存到沙盒
        [imageData writeToFile:fullPath atomically:NO];
        
        //路径添加至缓存
        _headImagePath = keyStr;
        
        //界面
        //mod by desheng
        //原先bug原因:异步线程不能刷新UI,UI操作只能在主线程完成
        dispatch_async(dispatch_get_main_queue(), ^{
            [self uploadHeadImage:^(NSString *url) {
                [_faceImg setFaceImageWithUrl:url];
            }];
            while (!self.isHeadImageUploadEnd) {
                [[NSRunLoop mainRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
            }
            _faceImg.image = [UIImage imageWithData:imageData];
            self.isHeadImageUploadEnd = NO;
        });
    });
}
//更新头像
- (void)updateAddImageButton
{
    if (_headImagePath.length > 0)
    {
        NSString *path = [YDirectory newImgCache:_headImagePath];
        
        if ([YDirectory isExistsPath:path])
        {
            //存在
            _faceImg.image = [UIImage imageWithContentsOfFile:path];
        }
    }
}

//上传头像
- (void)uploadHeadImage:(void(^)(NSString *url))block {
    NSString *path = [YDirectory newImgCache:_headImagePath];
    [[ProvisionManager sharedInstance] uploadHeadImage:path
                                                 block:^(YActionMessage *message) {
                                                     if (message.isSuccess) {
                                                         block([[message.object snapImages] objectAtIndex:0]);
                                                         self.isHeadImageUploadEnd = YES;
                                                     } else {
                                                         [YUtils showTitle:message.desc];
                                                     }
                                                 }];
}

#pragma mark - UIImagePickerControllerDelegate
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self.picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *getImage = info[@"UIImagePickerControllerEditedImage"];
    [self savePic:getImage];
}
//返回
- (void)goBack {
    [self.navigationController popViewControllerAnimated:true];
}
//更改手机号
- (void)changePhone {
    [self.navigationController pushViewController:[[ProfilePhoneChangeViewController alloc] initWithType:ProfilePhoneChangeTypeMod hasPhone:true] animated:true];
}
//更改密码
- (void)changePwd {
    UILabel *label = _bottomView.subviews[0];
    if (label.enabled) {
        [self.navigationController pushViewController:[[ProfileChangePwdViewController alloc] initWithType:ProfileChangePwdTypeMod needLogin:NO] animated:true];
    } else {
        [self.navigationController pushViewController:[[ProfilePhoneChangeViewController alloc] initWithType:ProfilePhoneChangeTypeMod hasPhone:false] animated:true];
    }
}

//登出
- (void)logOut {
    YCommonAlertView *alert = [[YCommonAlertView alloc] initWithTitle:@"提示" message:@"是否退出" buttonTitles:@"取消",@"确认", nil];
    [alert clickedButtonHandler:^(NSInteger index) {
        if (index == 1) {
            [alert hide];
            [[ProvisionManager sharedInstance] logout];
        } else {
            [alert hide];
        }
    }];
    [alert show];
}

@end
