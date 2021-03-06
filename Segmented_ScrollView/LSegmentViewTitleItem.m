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
{
    BOOL _hasNormalColor;     // 未选中
    BOOL _hasHighlightColor;  // 选中
    BOOL _touchedFlag;        // 我们希望点击内部并在内部抬起的时候让target去执行action，所以我们需要一个实例变量来记录是不是在内部点击
    id   _target;  // 触发点击事件(参数)
    SEL  _action;  // 触发点击事件(参数)
}


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

// 计算它应该具有的高度，方便调用
+ (CGFloat)calcuWidth:(NSString *)title {
    LSegmentViewTitleItem *item = [[LSegmentViewTitleItem alloc] initWithFrame:(CGRectZero) title:title];
    return [item calcuEidth] + item.space;
}

#pragma mark -- 状态 -->（非选中、选中、标题、字体、间距）
- (void)setNormalColor:(NSString *)normalColor {
    _normalColor = normalColor;
    _hasNormalColor = YES;
    [self setHighlight:_highlight];
}
- (void)setHighlightColor:(NSString *)highlightColor {
    _highlightColor = highlightColor;
    _hasHighlightColor = YES;
    [self setHighlight:_highlight];
}
- (void)setTitle:(NSString *)title {
    _title = title;
    self.titleLabel.text = title;
    [self setNeedsLayout];
}
- (void)setFont:(UIFont *)font {
    self.titleLabel.font = font;
}
- (void)setSpace:(CGFloat)space {
    _space = space;
    [self setNeedsLayout];
}

// 设置 被选中时，改变颜色
- (void)setHighlight:(BOOL)highlight {
    _highlight = highlight;
    self.titleLabel.textColor = highlight == YES ? _hasHighlightColor == YES ? self.highlightColor : _defaultTitleColor_Highlight : _hasNormalColor == YES ? self.normalColor : _defaultTitleColor_Normal;
}

#pragma mark -- touch

- (void)addTarget:(id)target action:(SEL)action {
    _target = target;
    _action = action;
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;  // 获取一个点击
    CGPoint touchPoint = [touch locationInView:self]; // 获取这个点击在哪个位置
    if (touchPoint.x >= 0 && touchPoint.x <= self.width && touchPoint.y >= 0 && touchPoint.y <= self.height) {
        [UIView animateWithDuration:0.1 animations:^{
            // 在里面点击的就是YES哦。
            // 而且改变一下透明度告诉用户：（当点击button时，透明度改变）
            self.alpha = 0.2;
            self->_touchedFlag = YES;
            
        }];
    }
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UITouch *touch = touches.anyObject;
    CGPoint touchPoint = [touch locationInView:self];
    if (touchPoint.x >= 0 && touchPoint.x <= self.width && touchPoint.y >= 0 &&touchPoint.y <= self.height) {
        if (_touchedFlag) {
            // 在里面 点击之后手抬起来 而且还是YES，那么肯定是在里面点击，在里面抬起啦。
            [_target performSelector:_action withObject:self];
        }
    }
    // 恢复标记
    _touchedFlag = NO;
    // 恢复透明度
    [UIView animateWithDuration:0.1 animations:^{
        self.alpha = 1;
    }];
}

#pragma mark -- 懒加载（titleLabel初始化）（OC里的懒加载的写法是重写某一个属性的getter，因为有些情况下我们并不能确定什么时候初始化一个数组或者字典。）多数用在网络请求之后保存结果等。。万一这个数组或者字典你用不到呢？给它个内存空间多浪费呀。所以什么时候用什么时候初始化。注意：不能用self.titleLabel
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
