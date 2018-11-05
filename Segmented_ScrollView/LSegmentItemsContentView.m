//
//  LSegmentItemsContentView.m
//  Segmented_ScrollView
//
//  Created by Geraint on 2018/11/5.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#import "LSegmentItemsContentView.h"

@interface LSegmentItemsContentView ()
{
    CGFloat _buttonWidthSUM;                  //item宽度之和
    LSegmentViewTitleItem *_currentItem;
}
@property (nonatomic, strong) UIView *buttonContentView;      // 存放所有 item 的view
@property (nonatomic, strong) UIView *line;                   // item 下面的 橙色杠杠

@property (nonatomic, strong) NSMutableArray *buttonsArray;
@property (nonatomic, strong) NSMutableArray *buttonWidths;
@property (nonatomic, strong) NSArray *items;

@end

@implementation LSegmentItemsContentView

- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray<NSString *> *)titles {
    if (self = [super initWithFrame:frame]) {
        self.items = [titles copy];
        [self setupAllButtons];
    }
    return self;
}

// 显示在什么位置，显示多少图标 （保存所有item的 宽度、宽度之和 ，是为了我们希望item的宽度跟随内容，并且item之间的距离是等宽的）
- (void)setupAllButtons {
    self.backgroundColor = [UIColor groupTableViewBackgroundColor];
    
    self.buttonContentView = [[UIView alloc] initWithFrame:CGRectZero];
    self.buttonContentView.backgroundColor = [UIColor whiteColor];
    [self addSubview:self.buttonContentView];
    
    // item 下面的 橙色杠杠
    self.line = [[UIView alloc] initWithFrame:CGRectZero];
    self.line.backgroundColor = [UIColor orangeColor];
    [self addSubview:self.line];
    
    // 便利所有的标题，
    for (NSString *title in self.items) {
        // 初始化一个item
        LSegmentViewTitleItem *item = [[LSegmentViewTitleItem alloc] initWithFrame:CGRectZero title:title];
        [item addTarget:self action:@selector(buttonAction:)]; // 添加点击事件
        [self.buttonsArray addObject:item]; // 添加到数组中
        [self.buttonContentView addSubview:item];
        
        // 计算 item 的高度
        CGFloat width = [LSegmentViewTitleItem calcuWidth:title];
        // 保存宽度，以备布局（NSArray 只能保存对象类型）
        [self.buttonWidths addObject:[NSNumber numberWithDouble:width]];
        // 计算所有item的宽度之和
        _buttonWidthSUM += width;
        if (_currentItem == nil) {
            // 默认高亮第一个item，当“_currentItem”第一次赋值之后就跳过
            _currentItem = item;
            item.highlight = YES;
        }
    }
    
}

#pragma mark -- 布局 layout
- (void)layoutSubviews {
    
    CGFloat height = self.bounds.size.height;
    CGFloat width = self.bounds.size.width;
    
    self.buttonContentView.frame = CGRectMake(0, 0, width, height - 2);
    
    CGFloat spacing = 0; // 间隔
    if (_buttonWidthSUM >= width) {
        spacing = 0;
    } else {
        spacing = (width - _buttonWidthSUM) / (_buttonWidths.count + 1);
    }
    for (int x = 0; x < self.buttonsArray.count; x++) {
        LSegmentViewTitleItem *item = self.buttonsArray[x];
        CGFloat buttonWidth = [self.buttonsArray[x] doubleValue];
        if (x == 0) {
            // 第一个 “item” 不考虑上一个 “item”
            item.frame = CGRectMake(spacing, 0, buttonWidth, _buttonContentView.bounds.size.height);
        } else {
            // 每一个 “item” 的布局依照上一个“item”
            LSegmentViewTitleItem *lastItem = self.buttonsArray[x - 1];
            item.frame = CGRectMake(spacing + lastItem.frame.origin.x + lastItem.frame.size.width, 0, buttonWidth, _buttonContentView.bounds.size.height);
        }
    }
    self.line.frame = CGRectMake(_currentItem.frame.origin.x, self.buttonContentView.bounds.size.height, _currentItem.bounds.size.width, 2);
    
}

#pragma mark -- 懒加载
- (NSMutableArray *)buttonsArray {
    if (!_buttonsArray) {
        _buttonsArray = [[NSMutableArray alloc] init];
    }
    return _buttonsArray;
}
- (NSMutableArray *)buttonWidths {
    if (!_buttonWidths) {
        _buttonWidths = [[NSMutableArray alloc] init];
    }
    return _buttonWidths;
}

@end
