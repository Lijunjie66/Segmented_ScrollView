//
//  LSegmentViewTitleItem.h
//  Segmented_ScrollView
//
//  Created by Geraint on 2018/11/2.
//  Copyright © 2018 kilolumen. All rights reserved.
//

/*
 *
 *
 *源码：https://github.com/ilakeYC/YCSegment
 *
 *
 */


#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSegmentViewTitleItem : UIView

@property (nonatomic, copy) NSString *title; // 标题（后期可以更改的标题）
@property (nonatomic, strong) UIFont *font;             // 字体
@property (nonatomic, strong) NSString *normalColor;    // 非选中颜色
@property (nonatomic, strong) NSString *highlightColor; // 选中颜色
@property (nonatomic, assign) BOOL highlight;           // 高亮（被选中时，改变颜色）

@property (nonatomic, assign) CGFloat space; // 间距（可以控制多个item之间的间距）

// 给它一个需要显示的字符串和它的位置，让它自己搞定
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title; // 初始化

// 添加 触发点击事件
- (void)addTarget:(id)target action:(SEL)action;

// 计算title高度
+ (CGFloat)calcuWidth:(NSString *)title;

@end

NS_ASSUME_NONNULL_END
