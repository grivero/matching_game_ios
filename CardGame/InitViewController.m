//
//  InitViewController.m
//  CardGame
//
//  Created by grivero on 5/5/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "InitViewController.h"
#import "CardGameViewController.h"
#import "ScoresTableViewController.h"

@interface InitViewController ()

    @property (weak, nonatomic) IBOutlet UITextField *nameInputText;
    @property (weak, nonatomic) IBOutlet UISwitch *threeCardsSwitchButton;
    @property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation InitViewController

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    // notification center to enable/disable button depending on the # of chars entered
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textInputChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.nameInputText];

}

- (void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // remove listener
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:self.nameInputText];
    
}


#pragma mark - Aux methods

- (void) saveFromUI{
    
    // hide keyboard
    [self.nameInputText resignFirstResponder];
    
    // set vars to store
    NSString*   name            = [self.nameInputText text];
    BOOL        isThreeCardGame = [self.threeCardsSwitchButton isOn];
    
    // Store Data
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setObject:name forKey:@"userName"];
    [defaults setBool:isThreeCardGame forKey:@"isThreeCardGame"];
    [defaults synchronize];
    
}

- (void) textInputChanged:(NSNotification *)notif{
    
    [self.playButton setEnabled:([self.nameInputText.text length]>=3)];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    // save data to use after
    [self saveFromUI];
    
    // prepare Let's Play button segue
    if( [segue.identifier isEqualToString:@"startGame"] &&
        [segue.destinationViewController isKindOfClass:[CardGameViewController class]] ){
        
            CardGameViewController *cardGameController = (CardGameViewController *) segue.destinationViewController;
            cardGameController.currentUserName = self.nameInputText.text;
            cardGameController.isThreeCardGame = [self.threeCardsSwitchButton isOn];
        
    // prepare Scores button segue
    }else if([segue.identifier isEqualToString:@"getScores"]){
    /**
        if([segue.destinationViewController isKindOfClass:[ScoresTableViewController class]]){
            ScoresTableViewController *tableController = (ScoresTableViewController *) segue.destinationViewController;
        }**/
        
    }
    
}


#pragma mark - Delegates handlers

// delegate handler
- (BOOL) textFieldShouldReturn:(UITextField *) textField{
    
    [textField resignFirstResponder];
    return YES;
    
}

// delegate handler
- (void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    [self.view endEditing:YES];
    [super touchesBegan:touches withEvent:event];
    
}

@end
