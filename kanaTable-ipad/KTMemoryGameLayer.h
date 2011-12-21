//
//  KTMemoryGameLayer.h
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 21.12.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface KTMemoryGameLayer : CCLayer {
    CCSprite *background;    
    
    //Menu for aligning items.
    CCMenu *menu;    
}

+(CCScene *) scene;

-(void) setupGameBoard;
@end