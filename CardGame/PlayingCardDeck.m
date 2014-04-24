//
//  PlayingCardDeck.m
//  CardGame
//
//  Created by grivero on 4/23/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck

- (instancetype) init{
    
    self = [super init];
    
    if(self){
        
        for( NSString *suit in [PlayingCard validSuits] ){
            //for( NSString *rank in [PlayingCard rankStrings] ){
            for( NSUInteger rank = 1; rank<=[PlayingCard maxRank]; rank++ ){
                
                PlayingCard *card   = [[PlayingCard alloc] init];
                //card.rank           = [rank integerValue];
                card.rank           = rank;
                card.suit           = suit;
                [self addCard:card];
                
            }
        }
        
    }
    
    return self;
    
}

@end
