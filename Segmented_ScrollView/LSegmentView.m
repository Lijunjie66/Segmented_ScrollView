//
//  LSegmentView.m
//  Segmented_ScrollView
//
//  Created by Geraint on 2018/11/6.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#import "LSegmentView.h"
#import "LSegmentItemsContentView.h"

// 在类的延展中有这样一些属性和变量
@interface LSegmentView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LSegmentItemsContentViewDelegate>
{
    NSArray *_viewControllers; // 用来保存所有的控制器
    CGFloat _titleHeight;      // 用来 “itemContent” 的高度
}
@property (nonatomic, strong) UICollectionViewFlowLayout *clayout; // 流布局
@property (nonatomic, strong) UICollectionView *collectionView;    // 流布局
@property (nonatomic, strong) LSegmentItemsContentView *titleView;


@end


@implementation LSegmentView

// 初始化
- (instancetype)initWithFrame:(CGRect)frame titleHeight:(CGFloat)height viewControllers:(NSArray<UIViewController *>)viewControllers {
    if (self= [super initWithFrame:frame]) {
        
    }
    return self;
}

@end
