//
//  AttributorViewController.m
//  CardGame
//
//  Created by grivero on 5/8/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "AttributorViewController.h"
#import "AnalyzeTextViewController.h"

@interface AttributorViewController ()
    @property (weak, nonatomic) IBOutlet UITextView *body;
@end

@implementation AttributorViewController


#pragma mark - View controller lifecycle

- (void)viewDidLoad{
    
    [super viewDidLoad];
    // to get setting changes while the app was off
    [self usePreferredFonts];
    
}

- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    // change body font when a change notification happens in any place
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(preferredFontsChanged:)
                                                 name:UIContentSizeCategoryDidChangeNotification
                                               object:nil];
    
}

- (void) viewWillDisappear:(BOOL)animated{
    
    [super viewWillDisappear:animated];
    // remove observer
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIContentSizeCategoryDidChangeNotification
                                                  object:nil];
    
}


#pragma mark - Actions

// change color to selected text
- (IBAction)changeColorAction:(UIButton *)sender {
    
    [self.body.textStorage addAttribute:NSForegroundColorAttributeName
                                  value:sender.backgroundColor
                                  range:self.body.selectedRange];
    
}

// remove color to selected text
- (IBAction)uncolorAction:(UIButton *)sender {
    
    [self.body.textStorage removeAttribute:NSForegroundColorAttributeName
                                     range:self.body.selectedRange];
    
}

// outline selected text
- (IBAction)outlineAction:(UIButton *)sender {
    
    [self.body.textStorage addAttributes:@{NSStrokeWidthAttributeName: @-3, NSStrokeColorAttributeName: [UIColor blackColor]}
                                   range:self.body.selectedRange];
    
}

// unoutline selected text
- (IBAction)unoutlineAction:(UIButton *)sender {
    
    [self.body.textStorage removeAttribute:NSStrokeWidthAttributeName
                                     range:self.body.selectedRange];
    
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    // prepare Let's Play button segue
    if( [segue.identifier isEqualToString:@"doAnalyze"] &&
        [segue.destinationViewController isKindOfClass:[AnalyzeTextViewController class]] ){
        AnalyzeTextViewController *analyzeController = (AnalyzeTextViewController *) segue.destinationViewController;
        analyzeController.textToAnalyze = [[NSAttributedString alloc] initWithString:self.body.text];
    }
    
}


#pragma mark - Aux functions

- (void) preferredFontsChanged:(NSNotification *)notification{
    
    [self usePreferredFonts];
    
}

- (void) usePreferredFonts{
    
    self.body.font = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    //self.headline.font  = [UIFont preferredFontForTextStyle:UIFontTextStyleHeadline];
    
}

@end
