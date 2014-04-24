//
//  PlayingCard.m
//  CardGame
//
//  Created by grivero on 4/23/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

// cause we provide setter and getter
@synthesize suit = _suit;


// setter of suit property
- (void) setSuit:(NSString *)suit{
    
    // if suit is any allowd suit, then we set the value
    if([[PlayingCard validSuits] containsObject:suit])
        _suit = suit;
    
}

// getter of suit property
- (NSString *) suit{
    
    return _suit ? _suit : @"?";
    
}

- (void) setRank:(NSUInteger)rank{
    if(rank <= [PlayingCard maxRank])
        _rank = rank;
}

// getter of contents property
- (NSString *) contents{
    
    // array of string objects --- @ transform the string inside "blabla" into a NSString
    NSArray *rankStrings = [PlayingCard rankStrings];
    
    // paste
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
    
}

// class method - get all the valid ranks
+ (NSArray *) rankStrings{
    
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"];
    
}

// class method - returns max rank
+ (NSUInteger) maxRank{
    // access to the last index of the array - returns "K"
    return [[PlayingCard rankStrings] count] - 1;
}

// class method (utility or helper methods) - get the valid suits
+ (NSArray *) validSuits{
    
    return @[@"♣️", @"♦️", @"♥️", @"♠️"];
    
}


@end
