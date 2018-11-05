//
//  LSegmentViewTitleItem.m
//  Segmented_ScrollView
//
//  Created by Geraint on 2018/11/2.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#import "LSegmentViewTitleItem.h"


#import "UIView+Sizes.h"
#import "Header.h"


#define _MinWidth 32                   // 最小宽度
#define _MaxWidth LMainScreenWidth / 2

#define _defaultFont                     [UIFont systemFontOfSize:15]
#define _defaultTitleColor_Normal        [UIColor blackColor]
#define _defaultTitleColor_Highlight     [UIColor redColor]

@interface LSegmentViewTitleItem()

@property (nonatomic, strong) UILabel *titleLabel;

@end

@implementation LSegmentViewTitleItem

- (instancetype)initWithFrame:(CGRect)frame title:(NSString *)title {
    if ([super initWithFrame:frame]) {
        self.space = 8;   // item 间距
        self.title = title; // 实际上我们实现了title属性的setter方法，在里面给实际变量_title赋值，用来保存值，然后我们给self.titleLabel.text赋值title，最后希望它从新布局，因此可能会改变宽度
    }
    return self;
}


#pragma mark -- 布局
- (void)layoutSubviews {
//    CGFloat buttonWiidth = [self calcuEidth];
    CGFloat buttonWidth = [self calcuEidth];
    self.frame = CGRectMake(self.x, self.y, buttonWidth + self.space, self.height);
    self.titleLabel.frame = CGRectMake(self.space / 2, 0, buttonWidth, self.height);
}

// <计算title的宽度>在没有title，即title为nil的时候，返回最小宽度，不然就没有宽度了
- (CGFloat)calcuEidth {
    if (self.title == nil) {
        return _MinWidth;  // 如果title为nil时，返回最小宽度
    }
    UIFont *font = self.font == nil ? _defaultFont : self.font;
    
    // size 表示文本的最大宽高
    CGRect frame = [self.title boundingRectWithSize:CGSizeMake(_MaxWidth, self.height) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:@{NSFontAttributeName:font} context:nil];
    CGFloat width = frame.size.width;
    
    return width > _MinWidth ? width : _MinWidth;
    
}









#pragma mark -- 懒加载（titleLabel初始化）（OC里的懒加载的写法是重写某一个属性的getter，因为有些情况下我们并不能确定什么时候初始化一个数组或者字典。）
// 包括了初始化、颜色、字体、居中、添加为self的子视图
- (UILabel *)titleLabel {
    if (!_titleLabel) { //判断，是否为nil
        _titleLabel = [[UILabel alloc] initWithFrame:self.bounds];
        _titleLabel.textColor = [UIColor grayColor];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:_titleLabel];
    }
    return _titleLabel;
}


@end
