//
//  Deck.m
//  CardGame
//
//  Created by grivero on 4/23/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "Deck.h"

@interface Deck()
    @property (strong, nonatomic) NSMutableArray *cards;
@end

@implementation Deck


// getter of cards, comes with init in case that is null
- (NSMutableArray *)cards{
    
    if(!_cards)
        _cards = [[NSMutableArray alloc] init];
    
    return _cards;
    
}

// addCard method
- (void) addCard:(Card *)card{
    [self addCard:card atTop:NO];
}

// addCard:atTop method
- (void) addCard:(Card *)card atTop:(BOOL)atTop{
    
    if(atTop)
        [self.cards insertObject:card atIndex:0];
    else
        [self.cards addObject:card];
    
}

// drawRandomCard method
- (Card*) drawRandomCard{
    
    // init variable
    Card* randomCard = nil;
    
    if([self.cards count]){
        
        // choose random index
        int index   = arc4random() % [self.cards count];
        // pick the random card from the deck
        randomCard  = self.cards[index];
        // remove the card from the deck
        [self.cards removeObjectAtIndex:index];
        
    }
    
    // return the card
    return randomCard;
    
}

@end
