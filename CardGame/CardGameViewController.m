//
//  CardGameViewController.m
//  CardGame
//
//  Created by grivero on 4/21/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardGameViewController ()
    @property (nonatomic) int flipCount;
    @property (weak, nonatomic) IBOutlet UILabel    *gameIndicator;
    @property (weak, nonatomic) IBOutlet UILabel    *flipsLabel;
    @property (nonatomic, strong) Deck *deck;
@end


@implementation CardGameViewController

// setter of flipCount property, also sets text to flipsLabel
- (void)setFlipCount:(int)flipCount{
    
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    
}

- (Deck *)deck{
    
    if( !_deck )
        _deck = [[PlayingCardDeck alloc] init];
    return _deck;
    
}


// action that flips the card in the view
- (IBAction)touchCardButton:(UIButton *)sender {

    // if we dont have more cards we prompt a msg
    if( ![self.deck.cards count] ){
     
        // set the back of the card and disable the button
        UIImage *cardImage = [UIImage imageNamed:@"cardBack"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
        [sender setEnabled:NO];
        
        // inidcate user that we don't have more cards
        self.gameIndicator.text = @"Sorry, no more cards 😴";
        self.gameIndicator.textColor = [UIColor redColor];
        
    }else{
    
        // show back if we dont have title
        if( [sender.currentTitle length] ){
            
            UIImage *cardImage = [UIImage imageNamed:@"cardBack"];
            [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
            [sender setTitle:@"" forState:UIControlStateNormal];
            
        }else{
        
            // search random card
            Card* randomCard = [self.deck drawRandomCard];
            // set front image and title from the randomCard
            UIImage *cardImage = [UIImage imageNamed:@"cardFront"];
            [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
            [sender setTitle:[randomCard contents] forState:UIControlStateNormal];
            
        }
    
        // increase count
        self.flipCount++;
        
        // message for users - just playing
        if( self.flipCount > 20 && self.flipCount <= 40 ){

            [self.gameIndicator setText:[NSString stringWithFormat:@"Nommmbre, did you like it?"]];
            [self.gameIndicator setTextColor:[UIColor yellowColor]];

        }else if( self.flipCount > 40 ){
        
            self.gameIndicator.text = @"OK ok ok, is not a toy 😌";
            self.gameIndicator.textColor = [UIColor redColor];
        
        }
        
    }
  
    
}

@end
