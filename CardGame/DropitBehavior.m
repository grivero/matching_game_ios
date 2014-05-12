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
@end

@implementation DropitBehavior

// lazy instiantiation
- (UICollisionBehavior *) collider{
    if(!_collider){
        _collider = [[UICollisionBehavior alloc] init];
        _collider.translatesReferenceBoundsIntoBoundary = YES;
    }
    return _collider;
}

// lazy instiantiation
- (UIGravityBehavior *) gravity{
    if(!_gravity){
        _gravity = [[UIGravityBehavior alloc] init];
        _gravity.magnitude = 0.9;
    }
    return _gravity;
}

// add item to the behaviour environment
- (void)addItem:(id <UIDynamicItem>)item{
    
    [self.gravity addItem:item];
    [self.collider addItem:item];
    
}

// remove item to the behaviour environment
- (void)removeItem:(id <UIDynamicItem>)item{
    
    [self.gravity removeItem:item];
    [self.collider removeItem:item];
    
}

// rewrite init, add behaviors to the parent view
- (instancetype)init{
    
    self = [super init];
    [self addChildBehavior:self.gravity];
    [self addChildBehavior:self.collider];
    return  self;
    
}
@end
