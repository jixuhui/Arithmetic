//
//  HJSort.m
//  HJArithmeticDemo
//
//  Created by jixuhui on 16/3/28.
//  Copyright © 2016年 hubbert. All rights reserved.
//

#import "HJSort.h"

@implementation HJSort

+ (HJSort *)shareSort
{
    static dispatch_once_t onceToken;
    static HJSort *_sort = nil;
    dispatch_once(&onceToken, ^{
        _sort = [[HJSort alloc] init];
    });
    
    return _sort;
}

+ (NSArray *)dichotomyWithNumberArray:(NSArray *)array order:(SORT_ORDER)order
{
    return nil;
}

+ (NSArray *)insertionWithNumberArray:(NSArray *)array order:(SORT_ORDER)order
{
    NSMutableArray *orderArray = [NSMutableArray arrayWithArray:array];
    
    int (^getLocation)(NSNumber *) = ^(NSNumber *aNumber) {
        int i = 0;
        for (; i<[orderArray count]; i++) {
            NSNumber *number = [orderArray objectAtIndex:i];
            
            switch (order) {
                case SORT_ORDER_ASCEND:
                {
                    if (aNumber.intValue <= number.intValue) {
                        return i;
                    }
                }
                    break;
                case SORT_ORDER_DESCEND:
                {
                    if (aNumber.intValue >= number.intValue) {
                        return i;
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        return i;
    };
    
    //移除oneNumber先，数组减一，如果找到的位置是大于目前数组，就add到最后，否则，直接插入location即可
    int i = 0;
    for (NSNumber *oneNumber in array) {
        int location = getLocation(oneNumber);
        
        [orderArray removeObjectAtIndex:i];
        
        if (location==[orderArray count]) {
            [orderArray addObject:oneNumber];
        }else {
            [orderArray insertObject:oneNumber atIndex:location];
        }
        
        i ++;
    }
    
    return orderArray;
}

+ (NSArray *)shellWithNumberArray:(NSArray *)array increaseCount:(NSArray *)countArray order:(SORT_ORDER)order
{
    
    
    return nil;
}

+ (NSArray *)simpleSelectionWithNumberArray:(NSArray *)array order:(SORT_ORDER)order
{
    NSMutableArray *orderArray = [NSMutableArray arrayWithArray:array];
    
    int (^ getMostIndex)(NSArray *) = ^(NSArray *leftArray){
        
        NSNumber *mostNumber = [leftArray firstObject];
        int mostIndex = 0;
        
        for (int i=0; i<[leftArray count]; i++) {
            NSNumber *number = [leftArray objectAtIndex:i];
            
            switch (order) {
                case SORT_ORDER_ASCEND:
                {
                    if (number <= mostNumber) {
                        mostNumber = number;
                        mostIndex = i;
                    }
                }
                    break;
                case SORT_ORDER_DESCEND:
                {
                    if (number >= mostNumber) {
                        mostNumber = number;
                        mostIndex = i;
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
        
        return mostIndex;
    };
    
    NSUInteger correctCount = [orderArray count];
    for (int i=0; i<correctCount; i++) {
        NSArray *leftArray = [orderArray subarrayWithRange:NSMakeRange(i, [array count]-i)];
        int relativeMostIndex = getMostIndex(leftArray);
        int absoluteMostIndex = relativeMostIndex + i;
        
        [orderArray exchangeObjectAtIndex:i withObjectAtIndex:absoluteMostIndex];
    }
    
    return orderArray;
}

+ (NSArray *)heapWithNumberArray:(NSArray *)array order:(SORT_ORDER)order
{
    NSMutableArray *orderArray = [NSMutableArray arrayWithArray:array];
    
    void (^adjustHeap)(int,long) = ^(int index, long count){
        int child = 2*index+1;
        while (child < count) {
            
            switch (order) {
                case SORT_ORDER_ASCEND:
                {
                    if(child+1 < count && orderArray[child+1] >orderArray[child]) {
                        ++child;
                    }
                    if(orderArray[child] > orderArray[index]) {
                        
                        [orderArray exchangeObjectAtIndex:index withObjectAtIndex:child];
                        
                        index = child;
                        child = 2*index+1;
                    }  else {
                        return;
                    }
                }
                    break;
                case SORT_ORDER_DESCEND:
                {
                    if(child+1 < count && orderArray[child+1] < orderArray[child]) {
                        ++child;
                    }
                    if(orderArray[child] < orderArray[index]) {
                        
                        [orderArray exchangeObjectAtIndex:index withObjectAtIndex:child];
                        
                        index = child;
                        child = 2*index+1;
                    }  else {
                        return;
                    }
                }
                    break;
                    
                default:
                    break;
            }
        }
    };
    
    void (^creatHeap)() = ^(){
        //最后一个有子节点的根节点
        for (int i = (int)([orderArray count] -1)/2 ; i >= 0; --i)
        {
            adjustHeap(i,[orderArray count]);
        }
    };
    
    creatHeap();
    
    //从最后一个元素开始对序列进行调整
    for (long i = [orderArray count] - 1; i > 0; --i)
    {
        //交换堆顶元素H[0]和堆中最后一个元素
        [orderArray exchangeObjectAtIndex:0 withObjectAtIndex:i];
        //每次交换堆顶元素和堆中最后一个元素之后，都要对堆进行调整
        adjustHeap(0,i);
    }
    
    return orderArray;
}

+ (NSArray *)bubbleWithNumberArray:(NSArray *)array order:(SORT_ORDER)order
{
    NSMutableArray *orderArray = [NSMutableArray arrayWithArray:array];
    
    for (NSInteger i=0; i<[orderArray count]; i++) {
        BOOL isChanged = NO;
        
        for (NSInteger j=[orderArray count]-1; j>i; j--) {
            NSNumber *upNumber = [orderArray objectAtIndex:j-1];
            NSNumber *downNumber = [orderArray objectAtIndex:j];
            
            if (order == SORT_ORDER_ASCEND) {
                if (upNumber.intValue > downNumber.intValue) {
                    [orderArray exchangeObjectAtIndex:j withObjectAtIndex:j-1];
                    isChanged = YES;
                }
            }else {
                if (upNumber.intValue < downNumber.intValue) {
                    [orderArray exchangeObjectAtIndex:j withObjectAtIndex:j-1];
                    isChanged = YES;
                }
            }
        }
        
        if (!isChanged) {
            break;
        }
    }
    
    return orderArray;
}

+ (NSArray *)quickWithNumberArray:(NSArray *)array order:(SORT_ORDER)order
{
    NSMutableArray *orderArray = [NSMutableArray arrayWithArray:array];
    
    int (^group)(int, int) = ^(int low, int high){
        
        int outValue = low;
        
        while (low < high) {
            
            if (order == SORT_ORDER_ASCEND) {
                while (low < high && [orderArray[low] intValue] < [orderArray[high] intValue]) {
                    high --;
                }
                
                if (low != high) {
                    [orderArray exchangeObjectAtIndex:low withObjectAtIndex:high];
                    outValue = high;
                }
                
                while (low < high && orderArray[low] < orderArray[high]) {
                    low ++;
                }
                
                if (low != high) {
                    [orderArray exchangeObjectAtIndex:low withObjectAtIndex:high];
                    outValue = low;
                }
            }else {
                while (low < high && [orderArray[low] intValue] > [orderArray[high] intValue]) {
                    high --;
                }
                
                if (low != high) {
                    [orderArray exchangeObjectAtIndex:low withObjectAtIndex:high];
                    outValue = high;
                }
                
                while (low < high && orderArray[low] > orderArray[high]) {
                    low ++;
                }
                
                if (low != high) {
                    [orderArray exchangeObjectAtIndex:low withObjectAtIndex:high];
                    outValue = low;
                }
            }
        }
        
        return outValue;
    };
    
    //优化后的，设定最小区间，保持足够的排序，再使用插入排序
    static void (^ improveRecursiveMethod)(int, int, int) = NULL;
    improveRecursiveMethod = ^(int low, int high, int gap) {
        if (high - low > gap) {
            int middle = group(low,high);
            
            //block递归，声明注意staic 和 = NULL
            improveRecursiveMethod(low,middle-1,gap);
            improveRecursiveMethod(middle+1,high,gap);
        }
    };
    
    //原始算法
//    static void (^ recursiveMethod)(int, int) = NULL;
//    recursiveMethod = ^(int low, int high) {
//        if (low < high) {
//            int middle = group(low,high);
//            
//            recursiveMethod(low,middle-1);
//            recursiveMethod(middle+1,high);
//        }
//    };
//    
//    recursiveMethod(0,(int)orderArray.count-1);
    
    //理论上，gap值为8左右，时间复杂度达到最好，但是鉴于使用的测试无序数组比较少，设置为4
    improveRecursiveMethod(0,(int)orderArray.count-1,4);
    return [HJSort insertionWithNumberArray:orderArray order:order];
}

+ (NSArray *)mergeWithNumberArray:(NSArray *)array order:(SORT_ORDER)order
{
    NSMutableArray *orderArray = [NSMutableArray arrayWithArray:array];
    
    void (^Merge)(int, int, int) = ^(int low, int mid, int high) {
        @autoreleasepool {
            int i = low; // i是第一段序列的下标
            int j = mid + 1; // j是第二段序列的下标
            int k = 0; // k是临时存放合并序列的下标
            
            NSMutableArray *mArray = [[NSMutableArray alloc] initWithCapacity:high-low+1];
            
            if (order == SORT_ORDER_ASCEND) {
                // 扫描第一段和第二段序列，直到有一个扫描结束
                while (i <= mid && j <= high) {
                    // 判断第一段和第二段取出的数哪个更小，将其存入合并序列，并继续向下扫描
                    if (orderArray[i] <= orderArray[j]) {
                        mArray[k] = orderArray[i];
                        i++;
                        k++;
                    } else {
                        mArray[k] = orderArray[j];
                        j++;
                        k++;
                    }
                }
            }else {
                // 扫描第一段和第二段序列，直到有一个扫描结束
                while (i <= mid && j <= high) {
                    // 判断第一段和第二段取出的数哪个更小，将其存入合并序列，并继续向下扫描
                    if (orderArray[i] >= orderArray[j]) {
                        mArray[k] = orderArray[i];
                        i++;
                        k++;
                    } else {
                        mArray[k] = orderArray[j];
                        j++;
                        k++;
                    }
                }
            }
            
            // 若第一段序列还没扫描完，将其全部复制到合并序列
            while (i <= mid) {
                mArray[k] = orderArray[i];
                i++;
                k++;
            }
            
            // 若第二段序列还没扫描完，将其全部复制到合并序列
            while (j <= high) {
                mArray[k] = orderArray[j];
                j++;
                k++;
            }
            
            // 将合并序列复制到原始序列中
            for (k = 0, i = low; i <= high; i++, k++) {
                orderArray[i] = mArray[k];
            }
        }
    };
    
    void (^mergePass)(int, int) = ^(int gap, int count) {
        int i = 0;
        
        // 归并gap长度的两个相邻子表
        for (i = 0; i + 2 * gap - 1 < count; i = i + 2 * gap) {
            Merge(i, i + gap - 1, i + 2 * gap - 1);
        }
        
        // 余下两个子表，后者长度小于gap
        if (i + gap - 1 < count-1) {
            Merge(i, i + gap - 1, count - 1);
        }
    };
    
    for (int gap=1; gap<[orderArray count]; gap *= 2) {
        mergePass(gap,(int)[orderArray count]);
    }
    
    return orderArray;
}

@end
