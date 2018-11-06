//
//  LSegmentView.h
//  Segmented_ScrollView
//
//  Created by Geraint on 2018/11/6.
//  Copyright © 2018 kilolumen. All rights reserved.
//

/*
 *    LSegmentView 是item（LSegmentViewTitleItem）和itemContent（LSegmentItemsContentView）结合在一起
 *
 */
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LSegmentView : UIView

@property (nonatomic, strong) UIColor *normalColor;     // 非选中颜色
@property (nonatomic, strong) UIColor *highlightColor;  // 选中颜色
@property (nonatomic, strong) UIFont *font;             // 字体

- (instancetype)initWithFrame:(CGRect)frame titleHeight:(CGFloat)height viewControllers:(NSArray <UIViewController *>)viewControllers;

@end

NS_ASSUME_NONNULL_END
