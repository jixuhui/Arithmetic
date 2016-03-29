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
    NSMutableArray *correctOrderArray = [NSMutableArray arrayWithArray:array];
    
    int (^getLocation)(NSNumber *) = ^(NSNumber *aNumber) {
        int i = 0;
        for (; i<[correctOrderArray count]; i++) {
            NSNumber *number = [correctOrderArray objectAtIndex:i];
            
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
    
    for (NSNumber *oneNumber in array) {
        int location = getLocation(oneNumber);
        
        if (location==[correctOrderArray count]) {
            [correctOrderArray addObject:oneNumber];
        }else {
            [correctOrderArray insertObject:oneNumber atIndex:location];
        }
    }
    
    return correctOrderArray;
}

+ (NSArray *)shellWithNumberArray:(NSArray *)array increaseCount:(NSArray *)countArray order:(SORT_ORDER)order
{
    
    
    return nil;
}

+ (NSArray *)simpleSelectionWithNumberArray:(NSArray *)array order:(SORT_ORDER)order
{
    NSMutableArray *correctOrderArray = [NSMutableArray arrayWithArray:array];
    
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
    
    NSUInteger correctCount = [correctOrderArray count];
    for (int i=0; i<correctCount; i++) {
        NSArray *leftArray = [correctOrderArray subarrayWithRange:NSMakeRange(i, [array count]-i)];
        int relativeMostIndex = getMostIndex(leftArray);
        int absoluteMostIndex = relativeMostIndex + i;
        
        [correctOrderArray exchangeObjectAtIndex:i withObjectAtIndex:absoluteMostIndex];
    }
    
    return correctOrderArray;
}

+ (NSArray *)heapWithNumberArray:(NSArray *)array order:(SORT_ORDER)order
{
    NSMutableArray *correctOrderArray = [NSMutableArray arrayWithArray:array];
    
    void (^adjustHeap)(int,long) = ^(int index, long count){
        int child = 2*index+1;
        while (child < count) {
            
            switch (order) {
                case SORT_ORDER_ASCEND:
                {
                    if(child+1 < count && correctOrderArray[child+1] >correctOrderArray[child]) {
                        ++child;
                    }
                    if(correctOrderArray[child] > correctOrderArray[index]) {
                        
                        [correctOrderArray exchangeObjectAtIndex:index withObjectAtIndex:child];
                        
                        index = child;
                        child = 2*index+1;
                    }  else {
                        return;
                    }
                }
                    break;
                case SORT_ORDER_DESCEND:
                {
                    if(child+1 < count && correctOrderArray[child+1] < correctOrderArray[child]) {
                        ++child;
                    }
                    if(correctOrderArray[child] < correctOrderArray[index]) {
                        
                        [correctOrderArray exchangeObjectAtIndex:index withObjectAtIndex:child];
                        
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
        for (int i = (int)([correctOrderArray count] -1)/2 ; i >= 0; --i)
        {
            adjustHeap(i,[correctOrderArray count]);
        }
    };
    
    creatHeap();
    
    //从最后一个元素开始对序列进行调整
    for (long i = [correctOrderArray count] - 1; i > 0; --i)
    {
        //交换堆顶元素H[0]和堆中最后一个元素
        [correctOrderArray exchangeObjectAtIndex:0 withObjectAtIndex:i];
        //每次交换堆顶元素和堆中最后一个元素之后，都要对堆进行调整
        adjustHeap(0,i);
    }
    
    return correctOrderArray;
}

@end
