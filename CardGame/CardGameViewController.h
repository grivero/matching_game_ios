//
//  CardGameViewController.h
//  CardGame
//
//  Created by grivero on 4/21/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Deck.h"

@interface CardGameViewController : UIViewController

    @property (strong, nonatomic)   NSString*   currentUserName;
    @property (nonatomic)           BOOL        isThreeCardGame;

    // abstract
    - (Deck *)createDeck;

@end