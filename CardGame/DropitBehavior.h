//
//  DropitBehavior.h
//  CardGame
//
//  Created by grivero on 5/12/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DropitBehavior : UIDynamicBehavior
- (void)addItem:(id <UIDynamicItem>)item;
- (void)removeItem:(id <UIDynamicItem>)item;
@end
