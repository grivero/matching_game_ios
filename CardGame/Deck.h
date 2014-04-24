//
//  Deck.h
//  CardGame
//
//  Created by grivero on 4/23/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (NSMutableArray *) cards;
- (void) addCard:(Card*)card atTop:(BOOL)atTop;
- (void) addCard:(Card*)card;

- (Card*) drawRandomCard;

@end
