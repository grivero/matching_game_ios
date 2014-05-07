//
//  StoreBucket.m
//  CardGame
//
//  Created by grivero on 5/6/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "StoreBucket.h"

@interface StoreBucket()
    @property (nonatomic) NSString*         name;
    @property (nonatomic) NSInteger         score;
    @property (nonatomic) NSMutableArray*   history;
@end

@implementation StoreBucket

- (NSMutableArray *) history{

    if(!_history)
        _history = [[NSMutableArray alloc] init];
    return _history;
    
}

@end
