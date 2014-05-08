//
//  StoreBucket.h
//  CardGame
//
//  Created by grivero on 5/6/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StoreBucket : NSObject

    - (NSMutableArray *) history;
    - (NSInteger) score;
    - (NSString *) name;

    + (StoreBucket *) createStoreBucket:(NSMutableArray *)history withScore:(NSInteger)score andName:(NSString *)name;

@end
