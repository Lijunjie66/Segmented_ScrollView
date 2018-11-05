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

@interface LSegmentItemsContentView : UIView

// 初始化
- (instancetype)initWithFrame:(CGRect)frame titles:(NSArray <NSString *>*)titles;



@end

NS_ASSUME_NONNULL_END
