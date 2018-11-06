//
//  LSegmentViewUnitCollectionViewCell.m
//  Segmented_ScrollView
//
//  Created by Geraint on 2018/11/6.
//  Copyright © 2018 kilolumen. All rights reserved.
//

#import "LSegmentViewUnitCollectionViewCell.h"

@implementation LSegmentViewUnitCollectionViewCell

// 当我们为 cell 的 view属性 赋值时，需要考虑当前的_view 是否存在，如果存在就从contentView上移除，然后将新传入的view添加到 contentView上，然后在设置view的位置和大小贴合contentView
- (void)setView:(UIView *)view {
    if (_view) {
        [_view removeFromSuperview];
    }
    [self.contentView addSubview:view];
    [self setNeedsLayout];
    _view = view;             // 最后千万不要忘了，_view = view，因为我们需要实例变量保存当前的view！！！
    
}
- (void)layoutSubviews {
    self.view.frame = self.contentView.bounds;
}

@end
