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
#import "YDirectory+Data.h"

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
    //图片
    _picImageView = [[UIImageView alloc] init];
    _picImageView.userInteractionEnabled = YES;
    _picImageView.layer.cornerRadius = 4;
    _picImageView.clipsToBounds = YES;
    _picImageView.image = [UIImage imageNamed:@"camera"];
    [self.backView addSubview:_picImageView];
    [_picImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(85));
        make.left.equalTo(self.numImageView.mas_left);
        make.height.width.mas_equalTo(SCALE_NUM(72));
    }];
    UITapGestureRecognizer * tapGestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(choicePictrue)];
    [_picImageView addGestureRecognizer:tapGestureRecognizer];
    
    UILongPressGestureRecognizer * longPressGestureRecognizer = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(deleteBtnShow)];
    [_picImageView addGestureRecognizer:longPressGestureRecognizer];
    
    //删除
    _deleteBtn = [[UIButton alloc] init];
    [_deleteBtn setImage:[UIImage imageNamed:@"btn_delete"] forState:UIControlStateNormal];
    [_deleteBtn addTarget:self action:@selector(deleteImage) forControlEvents:UIControlEventTouchUpInside];
    [self.backView addSubview:_deleteBtn];
    [_deleteBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.mas_equalTo(SCALE_NUM(73));
        make.right.equalTo(_picImageView.mas_right).offset(SCALE_NUM(12));
        make.width.height.mas_equalTo(SCALE_NUM(24));
    }];
    _deleteBtn.hidden = YES;
    
    //输入部分
    _textView = [[YTextView alloc] init];
    _textView.delegate = self;
    _textView.backgroundColor = [UIColor clearColor];
    _textView.font = CONTENT_FONT(12);
    _textView.placeholderColor = KCOLOR_B5;
    [self.backView addSubview:_textView];
    [_textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(_picImageView.mas_bottom).offset(SCALE_NUM(5));
        make.left.equalTo(self.numImageView.mas_left);
        make.bottom.right.mas_equalTo(SCALE_NUM(-12));
    }];
    
    //设置每个cell的不同部分
    self.numImageView.image = [UIImage imageNamed:@"img_num2"];
    self.typeLabel.text = @"活动描述";

//    _textView.lineSpacing = SCALE_NUM(3);
    _textView.placeholder = @"例如：\n想品尝自己亲手采制的新茶吗?参与明轩茶艺社本次活动,你可以亲身体会采茶、炒茶的乐趣,并有专业人员全程指导,让您喝上自己亲手制作的茶叶。";
    
}

-(void)choicePictrue
{
    [self.viewController.view endEditing:YES];
    
    _deleteBtn.hidden = YES;
    
    NSDictionary * dic = @{@"position":@2,@"picImage":@YES};
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
    
    
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
#pragma mark - imagePickerController委托回调
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    //打印出字典中的内容
    NSLog(@"get the media info: %@", info);
    
    //获取用户编辑之后的图像
    UIImage* editedImage = [info objectForKey:UIImagePickerControllerEditedImage];
    _picImageView.image = editedImage;
   
    _dataManager.ActivityDesciptionImage = editedImage;

    [self savePic:editedImage];
    
     [self.myController dismissViewControllerAnimated:YES completion:nil];
}

- (void)savePic:(UIImage *)image
{
    if (nil == image)
    {
        return;
    }
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        
        NSString *keyStr = @"activityRelease.png";
        
        //写入文件
        NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
        NSString *fullPath = [[YDirectory newImgCache] stringByAppendingPathComponent:keyStr];
        
        //保存到沙盒
        [imageData writeToFile:fullPath atomically:NO];
        
    });
}

-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self.myController dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - 展示删除按钮
-(void)deleteBtnShow
{
    if (![_picImageView.image isEqual:[UIImage imageNamed:@"camera"]])
    {
        _deleteBtn.hidden = NO;
    }
    
}
#pragma mark - 点击删除按钮
-(void)deleteImage
{
    NSLog(@"delete");
    _deleteBtn.hidden = YES;
    _picImageView.image = [UIImage imageNamed:@"camera"];
}

#pragma mark - UITextViewDelegate
- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    NSInteger fieldLen = [textView.text length];
    NSInteger rangeLen = range.length;
    NSInteger strLen = text.length;
    if (![text isEqualToString:@"\n"])
    {
        if (fieldLen - rangeLen + strLen > 5000)
        {
            return NO;
        }
    }
    return YES;
}

- (void)textViewDidChange:(UITextView *)textView
{
    _dataManager.ActivityDesciptionText = textView.text;
    [_dataManager isEnableToRelease];
    
    if (textView.text.length>5000)
    {
        if ([self isBlankString:textView.text])
        {
            [self.viewController.view endEditing:YES];
            [YUtils showTitle:@"描述不能为空"];
        }
        else
        {
            [self.viewController.view endEditing:YES];
            
        }
        if (textView.text.length >= 5000)
        {
            [YUtils showTitle:@"描述字数不能大于5000字"];
            [textView setText:[textView.text substringWithRange:NSMakeRange(0, 5000)]];
            _dataManager.ActivityDesciptionText = textView.text;
        }
        else
        {
            return;
        }
    }
}

-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    NSDictionary * dic = @{@"position":@2};
    [[NSNotificationCenter defaultCenter] postNotificationName:KNotification_Activity_Release_ScrollTo object:dic];
    return YES;
}

//-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
//{
//    if (range.location>=5000)
//    {
//        if ([self isBlankString:text])
//        {
//            [YUtils showTitle:@"描述不能为空"];
//            return NO;
//        }
//        else
//        {
//            [YUtils showTitle:@"描述字数不能大于5000字"];
//            return NO;
//        }
//    }
//    else
//    {
//        return YES;
//    }
//}

//判断字符串为空和只为空格解决办法
- (BOOL) isBlankString:(NSString *)string {
    if (string == nil || string == NULL) {
        return YES;
    }
    if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    }
    if ([[string stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]] length]==0) {
        return YES;
    }
    return NO;
}

@end
