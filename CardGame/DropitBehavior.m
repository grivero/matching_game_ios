//
//  DropitBehavior.m
//  CardGame
//
//  Created by grivero on 5/12/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "DropitBehavior.h"

@interface DropitBehavior ()
    @property (strong, nonatomic) UIGravityBehavior *gravity;
    @property (strong, nonatomic) UICollisionBehavior *collider;
    @property (strong, nonatomic) UIDynamicItemBehavior *animationOptions;
@end

@implementation DropitBehavior

#pragma mark - Lazy instantiations

- (UICollisionBehavior *) collider{
    if(!_collider){
        _collider = [[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collider;
}

- (UIGravityBehavior *) gravity{
    if(!_gravity){
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.9;
    }
    return _gravity;
}

- (UIDynamicItemBehavior *)animationOptions{
    if(!_animationOptions){
        _animationOptions = [[UIDynamicItemBehavior alloc] init];
        _animationOptions.allowsRotation = NO;
    }
    return _animationOptions;
}

#pragma mark - Public API methods

// add item to the behaviour environment
- (void)addItem:(id <UIDynamicItem>)item{
    
    [self.gravity addItem:item];
    [self.collider addItem:item];
    [self.animationOptions addItem:item];
    
}

// remove item to the behaviour environment
- (void)removeItem:(id <UIDynamicItem>)item{
    
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
    [self.animationOptions removeItem:item];
    
}

// rewrite init, add behaviors to the parent view
- (instancetype)init{
    
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    [self addChildBehavior:self.animationOptions];
    return  self;
    
}
@end
