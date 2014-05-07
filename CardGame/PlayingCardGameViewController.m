//
//  PlayingCardGameViewController.m
//  CardGame
//
//  Created by grivero on 5/6/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "PlayingCardGameViewController.h"
#import "PlayingCardDeck.h"

@interface PlayingCardGameViewController ()

@end

@implementation PlayingCardGameViewController

- (Deck *) createDeck{
    return [[PlayingCardDeck alloc] init];
}


@end
