//
//  AttributorViewController.m
//  CardGame
//
//  Created by grivero on 5/8/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "AttributorViewController.h"

@interface AttributorViewController ()
    @property (weak, nonatomic) IBOutlet UITextView *body;
@end

@implementation AttributorViewController

#pragma mark - Lazy instantiation

#pragma mark - View controller lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

@end
