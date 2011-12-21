//
//  KTMemoryCard.m
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 21.12.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "KTMemoryCard.h"


@implementation KTMemoryCard

+(id) newCard{

    return [[[self alloc] init] autorelease];
}

-(id) init{
    
    if (self = [super initWithFile:@"card_tmp.png"]) {
        
    }
    
    return self;
}

-(void) flipCard{
    
    
}

@end
