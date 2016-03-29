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
    
    for (NSNumber *oneNumber in array) {
        int location = getLocation(oneNumber);
        
        if (location==[orderArray count]) {
            [orderArray addObject:oneNumber];
        }else {
            [orderArray insertObject:oneNumber atIndex:location];
        }
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
    
    
    static void (^ recursiveMethod)(int, int) = NULL;
    
    recursiveMethod = ^(int low, int high) {
        if (low < high) {
            int middle = group(low,high);
            
            recursiveMethod(low,middle-1);
            recursiveMethod(middle+1,high);
        }
    };
    
    recursiveMethod(0,(int)orderArray.count-1);
    
    return orderArray;
}

@end
