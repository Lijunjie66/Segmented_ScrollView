//
//  LSegmentView.m
//  Segmented_ScrollView
//
//  Created by Geraint on 2018/11/6.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#import "LSegmentView.h"
#import "LSegmentItemsContentView.h"
#import "LSegmentViewUnitCollectionViewCell.h"

// 在类的延展中有这样一些属性和变量
@interface LSegmentView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, LSegmentItemsContentViewDelegate>
{
    NSArray *_viewControllers; // 用来保存所有的控制器
    CGFloat _titleHeight;      // 用来保存 “itemContent” 的高度
}
@property (nonatomic, strong) UICollectionViewFlowLayout *clayout; // 流布局
@property (nonatomic, strong) UICollectionView *collectionView;    // 流布局
@property (nonatomic, strong) LSegmentItemsContentView *titleView;


@end


@implementation LSegmentView

// 初始化
- (instancetype)initWithFrame:(CGRect)frame titleHeight:(CGFloat)height viewControllers:(NSArray<UIViewController *> *)viewControllers {
    if (self= [super initWithFrame:frame]) {
        _titleHeight = height;
        _viewControllers = viewControllers;
        [self setupAllViews];
    }
    return self;
}

/*
 *  因为我们想让用户更加方便使用，
 *  所以，希望用户只需要传入视图控制器，
 *  就可以完成控件的初始化，
 *  控制器有 'title' 属性
 *  我们就可以直接取到控制器的标题来初始化 ‘itemContent’
 *
 */

#pragma mark -- layout
- (void)setupAllViews {
    
    // arrayWithCapacity:方法，初始化可变数组对象的长度,如果后面代码继续添加数组超过长度以后长度会自动扩充。（即：创建一个可变的数组长度为_viewControllers.count）
    NSMutableArray *titles = [NSMutableArray arrayWithCapacity:_viewControllers.count];
    for (UIViewController *vc in _viewControllers) {
        [titles addObject:vc.title];
    }
    
    self.titleView = [[LSegmentItemsContentView alloc] initWithFrame:CGRectZero titles:titles];
    self.titleView.delegate = self;
    [self addSubview:self.titleView];
    
    self.clayout = [[UICollectionViewFlowLayout alloc] init];
    
    // 设置collectionView的滚动方式为水平移动
    self.clayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.clayout];
    
    // 这是collectionView按页滚动
    self.collectionView.pagingEnabled = YES;
    self.collectionView.delegate = self;
    self.collectionView.dataSource = self;
    
    // 注意！！！ 这里为‘collectionView’ 注册 ‘cell’ (LSegmentViewUnitCell)，下文提到
    [self.collectionView registerClass:[LSegmentViewUnitCollectionViewCell class] forCellWithReuseIdentifier:@"LSegmentViewUnitCollectionViewCell"];
    
    // 注意！！！ 这里为‘collectionView’ 添加观察者，观察属性‘contentOffset’的变化，来获取页数，控制‘itemContent’选择哪一个‘item’
    [self.collectionView addObserver:self forKeyPath:@"contentOffset" options:(NSKeyValueObservingOptionNew) context:nil];
    [self addSubview:self.collectionView];
    
}

- (void)layoutSubviews {
    self.titleView.frame = CGRectMake(0, 0, self.frame.size.width, _titleHeight);
    self.collectionView.frame = CGRectMake(0, _titleHeight, self.frame.size.width, self.frame.size.height - _titleHeight);
}

#pragma mark -- 重写KVO ，发现属性变化后会调用的方法
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    CGPoint offset = self.collectionView.contentOffset; // 我们使用了KVO对collectionView进行了属性观察
    // 在这里‘+0.5’ 是为了当滚动到页面一半的时候，就已经算作下一页或者上一页
    CGFloat pageFloat = offset.x / self.collectionView.bounds.size.width + 0.5;
    if (pageFloat < 0) {
        pageFloat = 0;
    } else if (pageFloat > _viewControllers.count) {
        pageFloat = _viewControllers.count;
    }
    NSInteger page = (NSInteger)pageFloat;
    self.titleView.page = page;
}

#pragma mark -- 实现collectionView 的协议方法，及 itemContent的协议方法
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView {
    return _viewControllers.count;
}
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return 1;
}
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(nonnull NSIndexPath *)indexPath {
    LSegmentViewUnitCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"LSegmentViewUnitCollectionViewCell" forIndexPath:indexPath];
    UIViewController *VC = _viewControllers[indexPath.section];
//    if (!VC.isFirstResponder) {
//        [VC loadViewIfNeeded];
//    }
    cell.view = VC.view;
    
    return cell;
}
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return collectionView.bounds.size;
}
- (void)didSelectedButtonAtIndex:(NSInteger)index {
    CGFloat width = self.collectionView.bounds.size.width;
    [self.collectionView setContentOffset:(CGPointMake(width *index, 0)) animated:YES];
}

#pragma mark -- 非常重要的一点！我们使用了KVO对collectionView进行了属性观察，但是如果观察者被释放了，肯定会出现问题，所以我们需要在 LSegmentView 中重写，-(void)dealloc方法，在dealloc中 移除 对collectionView的s观察。
- (void)dealloc {
    [self.collectionView removeObserver:self forKeyPath:@"contentOffset"];
}

@end
