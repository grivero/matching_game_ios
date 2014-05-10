//
//  PlayingCardView.h
//  CardGame
//
//  Created by grivero on 5/9/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PlayingCardView : UIView

    @property (nonatomic) NSUInteger rank;
    @property (strong, nonatomic) NSString *suit;
    @property (nonatomic) BOOL faceUp;

    // view gesture
    - (void) pinch:(UIPinchGestureRecognizer *)gesture;

@end
