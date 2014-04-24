//
//  PlayingCard.h
//  CardGame
//
//  Created by grivero on 4/23/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

    // properties
    @property (strong, nonatomic)   NSString    *suit;
    @property (nonatomic)           NSUInteger  rank;

    // public methods
    + (NSArray *)   rankStrings;
    + (NSArray *)   validSuits;
    + (NSUInteger) maxRank;

@end
