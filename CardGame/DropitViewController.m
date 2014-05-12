//
//  DropitViewController.m
//  CardGame
//
//  Created by grivero on 5/12/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "DropitViewController.h"
#import "DropitBehavior.h"
#import "BezierPathView.h"

@interface DropitViewController () <UIDynamicAnimatorDelegate>
    @property (weak, nonatomic) IBOutlet BezierPathView *gameView;
    @property (strong, nonatomic) UIDynamicAnimator *animator;
    @property (strong, nonatomic) DropitBehavior *behavior;
    @property (strong, nonatomic) UIAttachmentBehavior *attachment;
    @property (strong, nonatomic) UIView *dropingView;
@end

@implementation DropitViewController

- (DropitBehavior *)behavior{
    if(!_behavior){
        _behavior = [[DropitBehavior alloc] init];
        [self.animator addBehavior:_behavior];
    }
    return _behavior;
}

- (UIDynamicAnimator *)animator{
    if(!_animator){
        _animator = [[UIDynamicAnimator alloc] initWithReferenceView:self.gameView];
        // delegate added to handle "animated events" like "know when animated view is quiet"
        // need to implement the protocol in order to handle this
        _animator.delegate = self;
    }
    return _animator;
}

// protocol optional method - know when view did pause a.k. "stop moving"
- (void)dynamicAnimatorDidPause:(UIDynamicAnimator *)animator{
    
    [self removeCompletedRows];
    
}

// know if the last row of the screen is completed by views
- (BOOL)removeCompletedRows{
    
    NSMutableArray *dropsToremove = [[NSMutableArray alloc] init];
    
    for(CGFloat y = self.gameView.bounds.size.height - DROP_SIZE.height/2; y > 0; y -= DROP_SIZE.height){
        
        BOOL rowIsComplete = YES;
        NSMutableArray *dropsFound = [[NSMutableArray alloc] init];
        
        for(CGFloat x = DROP_SIZE.width/2; x <= self.gameView.bounds.size.width-DROP_SIZE.width/2; x += DROP_SIZE.width){
            
            UIView *hitView = [self.gameView hitTest:CGPointMake(x,y) withEvent:NULL];
            if( [hitView superview] == self.gameView )
                [dropsFound addObject:hitView];
            else{
                rowIsComplete = NO;
                break;
            }
        }
        
        if(![dropsFound count])
            break;
        
        // if is complete then i have drops to remove
        if(rowIsComplete)
            [dropsToremove addObjectsFromArray:dropsFound];
        
    }
    
    // if i have drops to remove
    if([dropsToremove count]){
        
        // remove behavior in the items to avoid fighting with gravity and possible collisions
        for(UIView *drop in dropsToremove)
            [self.behavior removeItem:drop];
        
        // animate and drop the last row
        [self animateRemovingDrops:dropsToremove];
        
    }
    
    return NO;
    
}

- (void)animateRemovingDrops:(NSArray*)dropsToRemove{
    
    [UIView animateWithDuration:1.0
                     animations:^{
                         for(UIView *drop in dropsToRemove){
                             int x = (arc4random()%(int)self.gameView.bounds.size.width*5) - (int)self.gameView.bounds.size.width*2;
                             int y = self.gameView.bounds.size.height;
                             // animation movement - moving center
                             drop.center = CGPointMake(x,-y);
                         }
                     }
                     completion:^(BOOL finished){
                         [dropsToRemove makeObjectsPerformSelector:@selector(removeFromSuperview)];
                     }];
    
}

// tap gesture
- (IBAction)tap:(UITapGestureRecognizer *)sender {
    [self drop];
}

// pan gesture
- (IBAction)pan:(UIPanGestureRecognizer *)sender {
    
    // get location of the gesture in my game view
    CGPoint gesturePoint = [sender locationInView:self.gameView];
    
    // this is pretty much generic - cycle of gestures by states
    if(sender.state == UIGestureRecognizerStateBegan){
        
        [self attachDroppingViewToPoint:gesturePoint];
        
    }else if(sender.state == UIGestureRecognizerStateChanged){
        
        self.attachment.anchorPoint = gesturePoint;
        
    }else if(sender.state == UIGestureRecognizerStateEnded){
        
        [self.animator removeBehavior:self.attachment];
        // need to hide the bar!!! test commenting this :)
        self.gameView.path = nil;
        
    }
    
}

- (void)attachDroppingViewToPoint:(CGPoint)anchorPoint{
    
    if(self.dropingView){
        
        self.attachment = [[UIAttachmentBehavior alloc] initWithItem:self.dropingView
                                                    attachedToAnchor:anchorPoint];
        
        
        // every time that will animate will call this block and keep a strong pointer to it
        // warning with retain cycles
        UIView *droppingView = self.dropingView;
        __weak DropitViewController *weakSelf = self;
        
        self.attachment.action = ^{
            UIBezierPath *path = [[UIBezierPath alloc] init];
            [path moveToPoint:weakSelf.attachment.anchorPoint];
            [path addLineToPoint:droppingView.center];
            weakSelf.gameView.path = path;
        };
        
        // one try, you can't grab it again
        self.dropingView = nil;
        
        [self.animator addBehavior:self.attachment];
        
    }
    
}

static const CGSize DROP_SIZE = { 40, 40 };

// tap gesture handler
- (void)drop{
    
    CGRect frame;
    frame.origin = CGPointZero;
    frame.size = DROP_SIZE;
    int x = ( arc4random()%(int)self.gameView.bounds.size.width) / DROP_SIZE.width;
    frame.origin.x = x * DROP_SIZE.width;
    
    UIView *dropView = [[UIView alloc] initWithFrame:frame];
    dropView.backgroundColor = [self randomColor];
    
    // the one that will be able to "grab it"
    self.dropingView = dropView;
    
    // add view to the parent view
    [self.gameView addSubview:dropView];
    // add gravity and collision (wraped in class) to the view
    [self.behavior addItem:dropView];
    
}

- (UIColor *)randomColor{
    
    switch (arc4random()%5) {
        case 0: return [UIColor redColor];
        case 1: return [UIColor greenColor];
        case 2: return [UIColor orangeColor];
        case 3: return [UIColor blueColor];
        case 4: return [UIColor purpleColor];
    }
    return [UIColor blackColor];
    
}

@end
