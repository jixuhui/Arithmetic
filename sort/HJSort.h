//
//  HJSort.h
//  HJArithmeticDemo
//
//  Created by jixuhui on 16/3/28.
//  Copyright © 2016年 hubbert. All rights reserved.
//  Reference http://blog.csdn.net/hguisu/article/details/7776068
//  Time and Space Complexity http://blog.chinaunix.net/uid-21457204-id-3060260.html
//  Merge Sort http://www.cnblogs.com/jingmoxukong/p/4308823.html

#import <Foundation/Foundation.h>

typedef enum _SORT_ORDER
{
    SORT_ORDER_ASCEND = 0,
    SORT_ORDER_DESCEND
}SORT_ORDER;

@interface HJSort : NSObject

+ (HJSort * __nonnull)shareSort;

/**
 *  插入排序
 *  @space  O(1)
 *  @time   O(n*n) best O(n) worst O(n*n)
 *  @stability  稳定
 *  @desc   大部分已排序时较好
 *
 *  @param array 输入的NSNumber对象数组
 *  @param order 升序、降序
 *
 *  @return 排序后数组
 */
+ (NSArray * __nonnull)insertionWithNumberArray:(NSArray * __nonnull)array order:(SORT_ORDER)order;

/**
 *  二分插入排序
 *  @desc
 *
 *  @param array 输入的NSNumber对象数组
 *  @param order 升序、降序
 *
 *  @return 排序后数组
 */
+ (NSArray * __nonnull)dichotomyWithNumberArray:(NSArray * __nonnull)array order:(SORT_ORDER)order;

/**
 *  希尔排序
 *  @space  O(1)
 *  @time   O(nlogn) best O(n) worst O(ns) 1<s<2
 *  @stability  不稳定
 *  @desc   s是所选分组
 *
 *  @param array      输入的NSNumber对象数组
 *  @param countArray 增量数组，递减，首小于原始数组大小，末等于1
 *  @param order      升序、降序
 *
 *  @return 排序后数组
 */
+ (NSArray * __nonnull)shellWithNumberArray:(NSArray * __nonnull)array increaseCount:(NSArray * __nonnull)countArray order:(SORT_ORDER)order;

/**
 *  简单选择排序
 *  @space  O(1)
 *  @time   O(n*n) best O(n*n) worst O(n*n)
 *  @stability  不稳定
 *  @desc   n小时较好
 *
 *  @param array 输入的NSNumber对象数组
 *  @param order 升序、降序
 *
 *  @return 排序后数组
 *  简单选择排序的改进——二元选择排序
 *  简单选择排序，每趟循环只能确定一个元素排序后的定位。我们可以考虑改进为每趟循环确定两个元素（当前趟最大和最小记录）的位置,从而减少排序所需的循环次数。改进后对n个数据进行排序，最多只需进行[n/2]趟循环即可。
 */
+ (NSArray * __nonnull)simpleSelectionWithNumberArray:(NSArray * __nonnull)array order:(SORT_ORDER)order;

/**
 *  堆排序
 *  @space O(1)
 *  @time O(nlog2n) best O(nlog2n) worst O(nlog2n)
 *  @stability 不稳定
 *  @desc n小时较好
 *
 *  @param array 输入的NSNumber对象数组
 *  @param order 升序、降序
 *
 *  @return 排序后数组
 */
+ (NSArray * __nonnull)heapWithNumberArray:(NSArray * __nonnull)array order:(SORT_ORDER)order;

/**
 *  冒泡排序【有改进，加了标志位】
 *  @space O(1)
 *  @time O(n*n) best O(n) worst O(n*n)
 *  @stability 稳定
 *  @desc n小时较好
 *
 *  @param array 输入的NSNumber对象数组
 *  @param order 升序、降序
 *
 *  @return 排序后数组
 */
+ (NSArray * __nonnull)bubbleWithNumberArray:(NSArray * __nonnull)array order:(SORT_ORDER)order;

/**
 *  快速排序
 *  @space O(nlog2n)
 *  @time O(nlog2n) best O(nlog2n) worst O(n*n)
 *  @stability 稳定
 *  @desc n小时较好
 *
 *  @param array 输入的NSNumber对象数组
 *  @param order 升序、降序
 *
 *  @return 排序后数组
 *  @other 可参考本段代码如何ARC下的block 递归
 */
+ (NSArray * __nonnull)quickWithNumberArray:(NSArray * __nonnull)array order:(SORT_ORDER)order;

/**
 *  归并排序
 *  @space O(n)
 *  @time O(nlog2n) best O(nlog2n) worst O(nlog2n)
 *  @stability 稳定
 *  @desc n小时较好
 *
 *  @param array 输入的NSNumber对象数组
 *  @param order 升序、降序
 *
 *  @return 排序后数组
 *  @other 可参考本段代码如何ARC下的block 递归
 */
+ (NSArray * __nonnull)mergeWithNumberArray:(NSArray * __nonnull)array order:(SORT_ORDER)order;

@end
