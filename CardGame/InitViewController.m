//
//  InitViewController.m
//  CardGame
//
//  Created by grivero on 5/5/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "InitViewController.h"

@interface InitViewController ()

    @property (weak, nonatomic) IBOutlet UITextField *nameInputText;
    @property (strong, nonatomic) IBOutlet UISwitch *threeCardsSwitchButton;
    @property (weak, nonatomic) IBOutlet UIButton *playButton;

@end

@implementation InitViewController

- (void) textInputChanged:(NSNotification *)notif{
    
    [self.playButton setEnabled:([self.nameInputText.text length]>=3)];
    
}


- (void) viewDidLoad{
    
    //self.nameInputText.delegate = self; // WHY IS THIS????
    [super viewDidLoad];
    
    // notification center to enable/disable button depending on the # of chars entered
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(textInputChanged:)
                                                 name:UITextFieldTextDidChangeNotification
                                               object:self.nameInputText];
    
}

- (void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    
    // remove listener
    [[NSNotificationCenter defaultCenter] removeObserver:self.playButton
                                                    name:UITextFieldTextDidChangeNotification
                                                  object:self.nameInputText];
    
}

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


// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    [self saveFromUI];
    
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}


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
