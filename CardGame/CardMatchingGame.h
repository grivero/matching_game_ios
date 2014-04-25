//
//  CardMatchingGame.h
//  CardGame
//
//  Created by grivero on 4/24/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

    @property(nonatomic,readonly) NSInteger score;

    // designated initailizer
    - (instancetype) initWithCardCount:(NSUInteger) count usingDeck:(Deck *)deck;

    - (void) chooseCardAtIndex:(NSUInteger) index;
    - (Card *) cardAtIndex:(NSUInteger) index;

@end
 