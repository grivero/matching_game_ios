//
//  DrawingViewController.m
//  CardGame
//
//  Created by grivero on 5/9/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "DrawingViewController.h"
#import "PlayingCardView.h"

@interface DrawingViewController ()
@property (weak, nonatomic) IBOutlet PlayingCardView *playingCardView;

@end

@implementation DrawingViewController

// view gesture implementation
- (IBAction)swipe:(UISwipeGestureRecognizer *)sender {
    self.playingCardView.faceUp = !self.playingCardView.faceUp;
}

- (void) viewDidLoad{
    
    [super viewDidLoad];

    self.playingCardView.suit = @"♣️";
    self.playingCardView.rank = 13;
    self.playingCardView.faceUp = NO;
    
    // controller gesture implemenation
    [self.playingCardView addGestureRecognizer:[[UIPinchGestureRecognizer alloc] initWithTarget:self.playingCardView action:@selector(pinch:) ]];
    
}
- (void)viewWillAppear:(BOOL)animated{
    
    [super viewWillAppear:animated];
    
//    self.view.opaque = NO;
//    self.view.hidden = NO;
//    UIBezierPath *path = [[UIBezierPath alloc] init];
//    [path moveToPoint:CGPointMake(75,10)];
//    [path addLineToPoint:CGPointMake(160, 150)];
//    [path addLineToPoint:CGPointMake(10, 150)];
//    [path closePath];
//    
//    [[UIColor greenColor] setFill];
//    [[UIColor redColor] setStroke];
//    [path fill];
//    [path stroke];
//    [path addClip];
    
}

@end
