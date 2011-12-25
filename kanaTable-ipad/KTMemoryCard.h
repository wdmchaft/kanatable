//
//  KTMemoryCard.h
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 21.12.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class KTKana;
@interface KTMemoryCard : CCSprite{    
    KTKana *kana;
    CCLabelTTF *label;
    BOOL isFacedUp;
}

@property (assign) BOOL isFacedUp;

+(id) withKey:(NSUInteger)key;
-(id) initCardWithKey:(NSUInteger)key;

-(void) flipCard;
@end
