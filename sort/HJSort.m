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
    NSMutableArray *correctOderArray = [[NSMutableArray alloc] initWithCapacity:array.count];
    
    int (^getLocation)(NSNumber *) = ^(NSNumber *aNumber) {
        int i = 0;
        for (; i<[correctOderArray count]; i++) {
            NSNumber *number = [correctOderArray objectAtIndex:i];
            
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
        
        if (location==[correctOderArray count]) {
            [correctOderArray addObject:oneNumber];
        }else {
            [correctOderArray insertObject:oneNumber atIndex:location];
        }
    }
    
    return correctOderArray;
}

+ (NSArray *)shellWithNumberArray:(NSArray *)array increaseCount:(NSArray *)countArray order:(SORT_ORDER)order
{
    
    
    return nil;
}

+ (NSArray *)simpleSelectionWithNumberArray:(NSArray *)array order:(SORT_ORDER)order
{
    NSMutableArray *correctOderArray = [[NSMutableArray alloc] initWithArray:array];
    
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
    
    NSUInteger correctCount = [correctOderArray count];
    for (int i=0; i<correctCount; i++) {
        NSArray *leftArray = [correctOderArray subarrayWithRange:NSMakeRange(i, [array count]-i)];
        int relativeMostIndex = getMostIndex(leftArray);
        int absoluteMostIndex = relativeMostIndex + i;
        
        [correctOderArray exchangeObjectAtIndex:i withObjectAtIndex:absoluteMostIndex];
    }
    
    return correctOderArray;
}

@end
