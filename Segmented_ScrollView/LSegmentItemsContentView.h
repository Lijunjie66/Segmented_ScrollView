//
//  LSegmentItemsContentView.h
//  Segmented_ScrollView
//
//  Created by Geraint on 2018/11/5.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LSegmentViewTitleItem.h"

/*
 *   这个view类是承载item的容器，并且来布局item
 *
 *   它来负责控制h高亮哪一个item，或者传递出点击哪一个item的消息
 */
NS_ASSUME_NONNULL_BEGIN

// 想要通过外接知道当前应该选中哪一个 item ，并且也希望告诉外接主动选择哪一个 item ，（传递信息、交互）用代理或者block，在这里我们用代理
#pragma mark -- 定义一个协议类
@protocol LSegmentItemsContentViewDelegate <NSObject>
- (void)didSelectedButtonAtIndex:(NSInteger)index;
@end


#pragma mark -- 定义委托方
@protocol LSegmentItemsContentViewDelegate;

@interface LSegmentItemsContentView : UIView
// 初始化
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles;

// dai li
@property (nonatomic, assign) id<LSegmentItemsContentViewDelegate> delegate;
@property (nonatomic, assign) NSInteger page;  // 页数，即item的个数，（点击顶栏的item，跳转页面）

@end

NS_ASSUME_NONNULL_END
