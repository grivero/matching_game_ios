//
//  AnalyzeTextViewController.m
//  CardGame
//
//  Created by grivero on 5/8/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "AnalyzeTextViewController.h"

@interface AnalyzeTextViewController ()
    @property (weak, nonatomic) IBOutlet UILabel *coloredLabel;
    @property (weak, nonatomic) IBOutlet UILabel *outlineLabel;
    @property (weak, nonatomic) IBOutlet UILabel *totalLabel;
    @property (strong, nonatomic) NSAttributedString *textToAnalyze;
@end

@implementation AnalyzeTextViewController


- (void) viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    [self updateUI];
    
}

- (void) setTextToAnalyze:(NSAttributedString *)textToAnalyze{
    
    _textToAnalyze = textToAnalyze;
    if(self.view.window)
        [self updateUI];
    
}

- (NSAttributedString *) charactersWithAttribute:(NSString *)attributeName{
    
    NSMutableAttributedString *chars = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while(index < [self.textToAnalyze length]){
        // aux range to use
        NSRange range;
        // generic id return here to work with different attributes
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        
        if(value){
            [chars appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }else{
            index++;
        }
        
    }
    
    return chars;
    
}

- (void) updateUI{
    
    self.coloredLabel.text = [NSString stringWithFormat:@"# colored chars: %d", [[self charactersWithAttribute:NSForegroundColorAttributeName] length] ];
    self.outlineLabel.text = [NSString stringWithFormat:@"# outlined chars: %d", [[self charactersWithAttribute:NSStrokeWidthAttributeName] length] ];
    self.totalLabel.text   = [NSString stringWithFormat:@"# total chars: %d", [self.textToAnalyze length]];
    
}

@end
