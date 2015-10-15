//
//  DescriptionCollectionViewCell.m
//  XiaoYou
//
//  Created by 尹先森 on 15/10/13.
//  Copyright © 2015年 xc. All rights reserved.
//

#import <AVFoundation/AVFoundation.h>
#import "DescriptionCollectionViewCell.h"
#import "YTextView.h"
#import "YCommonActionSheet.h"
#import "SDPhotoBrowser.h"
#import "YVIew+Ext.h"
#import "ActivityReleaseDataManager.h"

NSString *const kDescriptionCollectionViewCell = @"DescriptionCollectionViewCellId";

@interface DescriptionCollectionViewCell ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UITextViewDelegate>

@property (nonatomic,strong) UIImagePickerController * imagePicker;
@property (nonatomic,strong) UIImageView * picImageView;
@property (nonatomic,strong) YTextView * textView;
@property (nonatomic,strong) UIButton * deleteBtn;
@property(nonatomic,strong)ActivityReleaseDataManager * dataManager;

@end

@implementation DescriptionCollectionViewCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self changUI];
        _dataManager = [ActivityReleaseDataManager shareActivityReleaseDataManager];
    }
    return self;
}

-(void)changUI
{
    
    _picImageView = [[UIImageView alloc] init];
    _picImageView.userInteractionEnabled = YES;
    _picImageView.layer.cornerRadius = 4;
    _picImageView.clipsToBounds = YES;
    _picImageView.image = [UIImage imageNamed:@"btn_add"];
    [self.backView addSubview:_picImageView];
    [_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(80));
        make.left.equalTo(self.numImageView.mas_left);
        make.height.width.mas_equalTo(SCALE_NUM(72));
    }];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choicePictrue)];
    [_picImageView addGestureRecognizer:tapGestureRecognizer];
    
    UILongPressGestureRecognizer * longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnShow)];
    [_picImageView addGestureRecognizer:longPressGestureRecognizer];
    
    _deleteBtn = [[UIButton alloc] init];
    [_deleteBtn setImage:[UIImage imageNamed:@"btn_delete"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(68));
        make.right.equalTo(_picImageView.mas_right).offset(SCALE_NUM(12));
        make.width.height.mas_equalTo(SCALE_NUM(24));
    }];
    _deleteBtn.hidden = YES;
    
    _textView = [[YTextView alloc] init];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = CONTENT_FONT(12);
    _textView.placeholderColor = KCOLORGREEN_B5;
    [self.backView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_picImageView.mas_bottom).offset(SCALE_NUM(12));
        make.left.equalTo(self.numImageView.mas_left);
        make.bottom.right.mas_equalTo(SCALE_NUM(-12));
    }];
    
    self.numImageView.image = [UIImage imageNamed:@"img_num2"];
    self.typeLabel.text = @"活动描述";
    _textView.placeholder = @"例如：\n我觉得要阐明举办此次活动的背景,表述活动举办的意义以及目的,最后将活动所取得的效果加以描述并且稍稍夸大一点.再用几句话总结一下就可以了";
    
}

-(void)choicePictrue
{
    _deleteBtn.hidden = YES;
    
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
                UIImagePickerController *picker = [[UIImagePickerController alloc] init];
                [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
                picker.delegate = self;
                [picker setAllowsEditing:YES];
                [self.viewController presentViewController:picker animated:YES completion:nil];
            }
        }];
    }else{
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        [picker setSourceType:UIImagePickerControllerSourceTypeCamera];
        picker.delegate = self;
        [picker setAllowsEditing:YES];
        [self.viewController presentViewController:picker animated:YES completion:nil];
    }
#endif
}

- (void)pickImage
{
    UIImagePickerController *picker = [[UIImagePickerController alloc] init];
    [picker setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];
    [picker setDelegate:self];
    [picker setAllowsEditing:YES];
    [self.myController presentViewController:picker animated:YES completion:nil];
}
//imagePickerController委托回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //打印出字典中的内容
    NSLog(@"get the media info: %@", info);
    
    //获取用户编辑之后的图像
    UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    _picImageView.image = editedImage;
   
    _dataManager.ActivityDesciptionImage = editedImage;

     [self.myController dismissViewControllerAnimated:YES completion:nil];
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.myController dismissViewControllerAnimated:YES completion:nil];
}

//展示删除按钮
-(void)deleteBtnShow
{
    if (![_picImageView.image isEqual:[UIImage imageNamed:@"btn_add"]])
    {
        _deleteBtn.hidden = NO;
    }
    
}
//点击删除按钮
-(void)deleteImage
{
    NSLog(@"delete");
    _deleteBtn.hidden = YES;
    _picImageView.image = [UIImage imageNamed:@"btn_add"];
}

- (void)textViewDidChange:(UITextView *)textView
{
    _dataManager.ActivityDesciptionText = textView.text;
    [_dataManager isEnableToRelease];
}

@end
