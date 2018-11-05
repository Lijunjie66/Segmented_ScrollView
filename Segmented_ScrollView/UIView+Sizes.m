//
//  UIView+Sizes.m
//  Segmented_ScrollView
//
//  Created by Geraint on 2018/11/5.
//  Copyright © 2018 kilolumen. All rights reserved.
//


/**注意：-- <分类>
 1.分类是用于给原有类添加方法的,因为分类的结构体指针中，没有属性列表，只有方法列表。所以< 原则上讲它只能添加方法, 不能添加属性(成员变量),实际上可以通过其它方式添加属性> ;
 2.分类中的可以写@property, 但不会生成setter/getter方法, 也不会生成实现以及私有的成员变量（编译时会报警告）;
 3.可以在分类中访问原有类中.h中的属性;
 4.如果分类中有和原有类同名的方法, 会优先调用分类中的方法, 就是说会忽略原有类的方法。所以同名方法调用的优先级为 分类 > 本类 > 父类。因此在开发中尽量不要覆盖原有类;
 5.如果多个分类中都有和原有类中同名的方法, 那么调用该方法的时候执行谁由编译器决定；编译器会执行最后一个参与编译的分类中的方法。
 
 作者：CoderDancer
 链接：https://www.jianshu.com/p/9e827a1708c6
 *****/
#import "UIView+Sizes.h"

@implementation UIView (Sizes)

- (CGFloat)x {
    return self.frame.origin.x;
}
- (CGFloat)y {
    return self.frame.origin.y;
}
- (CGFloat)width {
    return self.bounds.size.width;
}
- (CGFloat)height {
    return self.bounds.size.height;
}
- (CGFloat)left {
    return self.x;
}
- (CGFloat)right {
    return self.x + self.width;
}
- (CGFloat)top {
    return self.y;
}
- (CGFloat)bottom {
    return self.y + self.height;
}
- (CGFloat)centerX {
    return self.width / 2;
}
- (CGFloat)centerY {
    return self.height / 2;
}

@end
