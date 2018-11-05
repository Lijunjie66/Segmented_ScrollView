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
@property (nonatomic, assign) CGFloat space; // 间距（可以控制多个item之间的间距）


@property (nonatomic, strong) UIFont *font;         // 字体



// 给它一个需要显示的字符串和它的位置，让它自己搞定
- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title; // 初始化


@end

NS_ASSUME_NONNULL_END
