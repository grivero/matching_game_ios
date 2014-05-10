//
//  PlayingCardView.m
//  CardGame
//
//  Created by grivero on 5/9/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "PlayingCardView.h"

@interface PlayingCardView()
    @property (nonatomic) CGFloat faceCardScaleFactor;
@end

@implementation PlayingCardView

#pragma mark - Initialization

- (void) setup{
    
    self.backgroundColor    = nil;
    self.opaque             = NO;
    self.alpha              = 0.7;
    self.contentMode        = UIViewContentModeRedraw;
    
}

#pragma mark - View Gestures

- (void) pinch:(UIPinchGestureRecognizer *)gesture{
    
    if(gesture.state == UIGestureRecognizerStateChanged || gesture.state == UIGestureRecognizerStateEnded){
        self.faceCardScaleFactor *= gesture.scale;
        gesture.scale = 1.0;
    }
    
}

#pragma mark - Drawing

// Only override drawRect: if you perform custom drawing.
- (void)drawRect:(CGRect)rect{
    
    // Drawing code
    UIBezierPath *roundedRect = [UIBezierPath bezierPathWithRoundedRect:self.bounds cornerRadius:[self cornerRadius]];
    [roundedRect addClip];
    
    [[UIColor whiteColor] setFill];
    UIRectFill(self.bounds);
    
    [[UIColor blackColor] setStroke];
    [roundedRect stroke];
    
    // search if image exist for that card
    UIImage *faceImage = [UIImage imageNamed:[NSString stringWithFormat:@"%@%@", [self rankAsString], self.suit]];
    
    if(self.faceUp){
        
        // draw image
        if (faceImage){
            
            // create rect
            CGRect imageRect = CGRectInset(self.bounds,
                                           self.bounds.size.width * (1.0-self.faceCardScaleFactor),
                                           self.bounds.size.height * (1.0-self.faceCardScaleFactor));
            // draw image inside the rect
            [faceImage drawInRect:imageRect];
            
        // draw pips
        }else
            [self drawPips];
        
        [self drawCorners];
        
    }else{
        [[UIImage imageNamed:@"cardBack"] drawInRect:self.bounds];
    }
    
    
}

#define PIP_HOFFSET_PERCENTAGE 0.165
#define PIP_VOFFSET1_PERCENTAGE 0.090
#define PIP_VOFFSET2_PERCENTAGE 0.175
#define PIP_VOFFSET3_PERCENTAGE 0.270

- (void)drawPips{
    

}

- (void) drawPipsWithHorizontalOffset:(CGFloat)hoffset verticalOffset:(CGFloat)voffset upsideDown:(BOOL)upsideDown{

}

- (void) drawPipsWithHorizontalOffset:(CGFloat)hoffset verticalOffset:(CGFloat)voffset mirroredVertically:(BOOL)mirrorVertically{
    
    [self drawPipsWithHorizontalOffset:hoffset
                        verticalOffset:voffset upsideDown:NO];
    if(mirrorVertically)
        [self drawPipsWithHorizontalOffset:hoffset
                            verticalOffset:voffset upsideDown:YES];
}

- (void)pushContextAndRotateUpsideDown{
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSaveGState(context);
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);
}

- (void)popContext{
    CGContextRestoreGState(UIGraphicsGetCurrentContext());
}

- (void)drawCorners{
    
    // center content
    NSMutableParagraphStyle *paragraphStlye = [[NSMutableParagraphStyle alloc] init];
    paragraphStlye.alignment = NSTextAlignmentCenter;
    
    // set font
    UIFont *cornerFont = [UIFont preferredFontForTextStyle:UIFontTextStyleBody];
    cornerFont = [cornerFont fontWithSize:cornerFont.pointSize * [self cornerScaleFactor]];
    
    // set content establishing paragraph and font
    NSAttributedString *cornerText = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@", [self rankAsString], [self suit]]
                                                                     attributes:@{ NSFontAttributeName:cornerFont, NSParagraphStyleAttributeName: paragraphStlye}];
    
    // create container with size
    CGRect textBounds;
    textBounds.origin = CGPointMake([self cornerOffset], [self cornerOffset]);
    textBounds.size = [cornerText size];
    
    // draw
    [cornerText drawInRect:textBounds];
    
    // rotate and duplicate
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextTranslateCTM(context, self.bounds.size.width, self.bounds.size.height);
    CGContextRotateCTM(context, M_PI);

    // draw the duplicate
    [cornerText drawInRect:textBounds];
    
}

#pragma mark - Properties
                                       
@synthesize faceCardScaleFactor = _faceCardScaleFactor;

- (void) setRank:(NSUInteger)rank{
    
    _rank = rank;
    
    // this means that if something change me
    // then i need to tell to the system to ReDraw me
    [self setNeedsDisplay];
    
}

- (void) setFaceUp:(BOOL)faceUp{
    _faceUp = faceUp;
    [self setNeedsDisplay];
}

- (void) setSuit:(NSString *)suit{
    _suit = suit;
    [self setNeedsDisplay];
}

#define DEFAULT_FACE_CARD_SCALE_FACTOR 0.90; // 90%

- (CGFloat)faceCardScaleFactor{
    if(!_faceCardScaleFactor)
        _faceCardScaleFactor = DEFAULT_FACE_CARD_SCALE_FACTOR;
    return _faceCardScaleFactor;
}

- (void) setFaceCardScaleFactor:(CGFloat)faceCardScaleFactor{
    _faceCardScaleFactor = faceCardScaleFactor;
    [self setNeedsDisplay];
}

#pragma mark - View Lifecycle

- (id)initWithFrame:(CGRect)frame{
    
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
    
}

- (void) awakeFromNib{
    [self setup];
}

#pragma mark - aux draw functions

// sizes and proportions for the view

#define CORNER_FONT_STANDARD_HEIGHT 180.00
#define CORNER_RADIUS 12.00

-(CGFloat)cornerScaleFactor{
    return self.bounds.size.height / CORNER_FONT_STANDARD_HEIGHT;
}

- (CGFloat) cornerRadius{
    return CORNER_RADIUS * [self cornerScaleFactor];
}

- (CGFloat) cornerOffset{
    return [self cornerRadius] / 3.0;
}

#pragma mark - Aux functions

- (NSString *)rankAsString{
    return @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9", @"10", @"J", @"Q", @"K"][self.rank];
}

@end
