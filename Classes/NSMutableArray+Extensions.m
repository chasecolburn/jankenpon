//
//  NSMutableArray+Extensions.m
//  Jankenpon
//
//  Created by Chase Colburn on 6/28/11.
//  Copyright 2011 Clever Monkey Technologies. All rights reserved.
//

#import "NSMutableArray+Extensions.h"


@implementation NSMutableArray(Extensions)

-(void)shuffle {
    NSUInteger count = [self count];
    for(NSUInteger i = 0; i < count; ++i) {
        // Select a random element between i and end of array to swap with.
        int nElements = count - i;
        int n = (arc4random() % nElements) + i;
        [self exchangeObjectAtIndex:i withObjectAtIndex:n];
    }
}

@end
