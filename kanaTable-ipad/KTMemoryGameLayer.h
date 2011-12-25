//
//  KTMemoryGameLayer.h
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 21.12.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "KTGlobal.h"

@interface KTMemoryGameLayer : CCLayer {
    CCSprite *background;        
    KTLevel level;    
    NSMutableArray *cards;
}

+(CCScene *) scene;
+(id) withLevel:(KTLevel)lvl;

-(void) setupGameBoard;
-(id) initWithLevel:(KTLevel)lvl;
@end