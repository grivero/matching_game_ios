//
//  CardGameViewController.m
//  CardGame
//
//  Created by grivero on 4/21/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"
#import "StoreBucket.h"

@interface CardGameViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
    @property (weak, nonatomic) IBOutlet UILabel *titleLabel;
    @property (weak, nonatomic) IBOutlet UILabel *actionLabel;
    @property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
    @property (strong, nonatomic) NSMutableArray *actionList;
    @property (strong, nonatomic) CardMatchingGame *game;
@end


@implementation CardGameViewController

// lazy init
- (CardMatchingGame *)game{
    
    // if game is nil then we init the game with the size equals to the size of cards in view
    // and using the deck created in PlayingCardDeck implementation
    if(!_game)
        _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[self createDeck]];
    
    return _game;
    
}

- (Deck *)createDeck{
    
    return nil;
    
}

- (NSMutableArray *)actionList{
    if( !_actionList )
        _actionList = [[NSMutableArray alloc] init];
    return _actionList;
}

// action that restart the game
- (IBAction)touchRestartButton:(UIButton *)sender {
    
    // restart the cards
    self.game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                  usingDeck:[[PlayingCardDeck alloc] init]];
    // restart the UI
    [self restartUI];
    
}

// action that flips the card in the view
- (IBAction)touchCardButton:(UIButton *)sender {

    // search for the button in the collection of buttons
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    // choose that card inside my game's model
    [self.game chooseCardAtIndex:chosenButtonIndex];
    // let the UI know about these selections
    [self updateUI];
  
}

- (void) updateUI{
    
    // go through all the buttons in the UI
    for(UIButton *button in self.cardButtons){
        
        // search for index in the array of ui buttons
        int buttonIndex = [self.cardButtons indexOfObject:button];
        // search for the card associated to the button
        Card *card = [self.game cardAtIndex:buttonIndex];
        
        // set title, image and enable state for all the images every time that the action is triggered
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal]; // same as button.title
        [button setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal]; // same as button.image
        [button setEnabled:!card.matched]; // same as button.enabled
        
    }
    
    // set labels
    self.scoreLabel.text  = [NSString stringWithFormat:@"Score: %d", self.game.score];
    self.actionLabel.text = self.game.actionString;
    
    // add the action into the history array
    if( self.game.actionString && ![self.actionList containsObject:self.game.actionString] )
        [self.actionList insertObject:self.game.actionString atIndex:0];
    
    // To win
    if(self.game.score >= 20){
        
        self.scoreLabel.text      = [NSString stringWithFormat:@"You reach %d!", self.game.score];
        self.scoreLabel.textColor = [UIColor redColor];
        
        UIAlertView* alert = [[UIAlertView alloc] initWithTitle:@"You win"
                                                        message:[NSString stringWithFormat: @"You reach %d!", self.game.score]
                                                       delegate:nil
                                               cancelButtonTitle:@"Aceptar"
                                               otherButtonTitles:nil, nil];
        [alert show];
        
        // disable all the cards after wining
        for(UIButton *button in self.cardButtons)
            button.enabled = false;
        
    }
    
}

- (void) saveFromUI{
    
    
}

// helper method to restart the UI and the cards state
- (void) restartUI{
    
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", 0];
    self.scoreLabel.textColor = [UIColor blackColor];
    
    self.actionList = [[NSMutableArray alloc] init];
    self.actionLabel.text = @"";
    
    // go through all the buttons in the UI
    for(UIButton *button in self.cardButtons){
        
        // search for index in the array of ui buttons
        int buttonIndex = [self.cardButtons indexOfObject:button];
        // search for the card associated to the button
        Card *card = [self.game cardAtIndex:buttonIndex];
        card.chosen  = NO;
        card.matched = NO;
        
        // draw the card using the params
        [button setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [button setBackgroundImage:[self imageForCard:card] forState:UIControlStateNormal];
        [button setEnabled:!card.matched];
        
    }
    
}

// if the card is chosen then we show the conent, if not, just show the back of the card
- (NSString *) titleForCard:(Card *)card{
    return card.chosen ? card.contents : @"";
}

// if the card is chosen then we show the front, else we show the back
- (UIImage *) imageForCard:(Card *)card{
    return [UIImage imageNamed: card.chosen ? @"cardFront" : @"cardBack"];
}


@end
