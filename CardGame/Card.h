//
//  Card.h
//  CardGame
//
//  Created by grivero on 4/23/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

    // properties
    @property (strong, nonatomic)   NSString    *contents;
    @property (nonatomic)           BOOL        chosen;
    @property (nonatomic)           BOOL        matched;

    // methods
    - (int) match:(NSArray*) otherCards;

@end
