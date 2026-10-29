#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol YKeyBoardDlegate <NSObject>

- (void)keyboardWillShowNotification:(NSNotification *)notification;
- (void)keyboardWillHideNotification:(NSNotification *)notification;

@end

@interface YKeyBoard : NSObject

+ (void)registerKeyBoardWithTarget:(id)target;

/**
 *  注册键盘出现
 *
 *  @param target 目标(self)
 */
+ (void)registerKeyBoardShow:(id)target;
/**
 *  注册键盘隐藏
 *
 *  @param target 目标(self)
 */
+ (void)registerKeyBoardHide:(id)target;
/**
 *
 *
 *  @return 返回键盘，包括高度、宽度
 */
+ (CGRect)keyBoardWindow:(NSNotification *)notification;
/**
 *
 *
 *  @return 返回键盘上拉动画持续时间
 */
+ (double)keyBoardDuration:(NSNotification *)notification;
/**
 *  
 *
 *  @return 返回键盘上拉，下拉动画曲线
 */
+ (UIViewAnimationCurve)keyBoardAnimationCurve:(NSNotification *)notification;

@end
