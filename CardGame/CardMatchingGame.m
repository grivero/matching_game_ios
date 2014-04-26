//
//  CardMatchingGame.m
//  CardGame
//
//  Created by grivero on 4/24/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
    @property (nonatomic, readwrite) NSInteger score;
    @property (nonatomic, readwrite) NSString *actionString;
    @property (nonatomic, strong) NSMutableArray *cards;// of Cards
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY   = 2;
static const int MATCH_BONUS        = 4;
static const int COST_TO_CHOSE      = 1;

// lazy init for pointer properties
- (NSMutableArray *) cards{
    
    if( !_cards )
        _cards = [[NSMutableArray alloc] init];
    return _cards;
    
}

// init
- (instancetype) initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck{
    
    self = [super self];
    
    if(self){
        
        for(int i = 0; i < count ; i++){
            Card *card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
        
    }
    
    return self;
    
}

- (Card *) cardAtIndex:(NSUInteger)index{
    
    return (index < [self.cards count]) ? self.cards[index] : nil;
    
}

- (void) chooseCardAtIndex:(NSUInteger)index{
    //
    // cambiar tipo de retorno, devolver las 2 cartas que matchearon o algo inteligente para que esto camine.. de lo contrario nil
    // agregar variable al mensaje para que se pueda matchear de mas de 2 cartas
    //
    
    // choose the card at index
    Card *card = [self cardAtIndex:index];
    
    // if card wasn't already matched then we try to match it
    if(!card.matched){
        
        if(card.chosen){
            
            // toggle between card states
            card.chosen = NO;
        
        }else{
            
            // go through all the cards
            for(Card *otherCard in self.cards){
                // if card is chosen and it wasn't matched yet
                if(otherCard.chosen && !otherCard.matched){
                    
                    // get match
                    int matchScore = [card match:@[otherCard]];
                    
                    // if matchScore > 0
                    if(matchScore){
                        self.score          += (matchScore * MATCH_BONUS);
                        otherCard.matched   = YES;
                        card.matched        = YES;
                        
                        [self setActionString:self.actionString
                                     withCard:card
                                      andCard:otherCard
                                    isMatched:YES
                                        score:(matchScore * MATCH_BONUS)];
                        
                    }else{
                        self.score          -= MISMATCH_PENALTY;
                        otherCard.chosen    = NO;
                        
                        [self setActionString:self.actionString
                                     withCard:card
                                      andCard:otherCard
                                    isMatched:NO
                                        score:MISMATCH_PENALTY];

                    }
                    break; // can only choose 2 cards for now
                    
                }
            }
            
            // toggle between card states
            card.chosen = YES;
            // debit point cause chose
            self.score -= COST_TO_CHOSE;
            
        }
        
    }
            
}

- (void) setActionString:(NSString *)actionString withCard:(Card*)card andCard:(Card*)otherCard isMatched:(BOOL)matched score:(NSInteger)score{
    
    NSString* cardContent       = [card contents];
    NSString* otherCardConent   = [otherCard contents];
    
    if( matched )
        self.actionString = [NSString stringWithFormat:@"Matched %@ and %@ for %d point%@",cardContent, otherCardConent, score, (score>1) ? @"s" : @""];
    else
        self.actionString = [NSString stringWithFormat:@"%@ and %@ don't match! %d points penalty!",cardContent, otherCardConent, score];
    
}

@end
