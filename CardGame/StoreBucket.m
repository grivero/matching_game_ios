//
//  StoreBucket.m
//  CardGame
//
//  Created by grivero on 5/6/14.
//  Copyright (c) 2014 grivero. All rights reserved.
//

#import "StoreBucket.h"

@interface StoreBucket() < NSCoding >
    @property (nonatomic) NSString*         name;
    @property (nonatomic) NSInteger         score;
    @property (nonatomic) NSMutableArray*   history;
@end

@implementation StoreBucket

- (NSMutableArray *) history{

    if(!_history)
        _history = [[NSMutableArray alloc] init];
    return _history;
    
}

+ (StoreBucket *) createStoreBucket:(NSMutableArray *)history withScore:(NSInteger)score andName:(NSString *)name{
 
    StoreBucket *newBucket = [[StoreBucket alloc] init];
    newBucket.name = name;
    newBucket.score = score;
    newBucket.history = history;
    return newBucket;
}

#pragma mark - NSCoding, required delegate methods implementations

- (void)encodeWithCoder:(NSCoder *)encoder{
    
    [encoder encodeObject:self.name forKey:@"name"];
    [encoder encodeObject:[NSNumber numberWithInt:(int)self.score] forKey:@"score"];
    [encoder encodeObject:self.history forKey:@"history"];
    
}

- (id)initWithCoder:(NSCoder *)decoder{
    
    // classic when we are reWriteing a init
    self = [super init];
    if(self !=nil ){
        self.name   = [[decoder decodeObjectForKey:@"name"] copy]; // retain value
        self.score  = [[decoder decodeObjectForKey:@"score"] intValue];
        self.history= [[decoder decodeObjectForKey:@"history"] copy]; // retain value
    }
    return self;
    
}

@end
