//
//  KTMemoryMenuLayer.h
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 21.12.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface KTMemoryMenuLayer : CCLayer {
    
    CCSprite *background;    
    
    //Menu for aligning items.
    CCMenu *menu;    
    
    //Two buttons
    CCMenuItemImage *hirItem;
    CCMenuItemImage *katItem;    
}

+(CCScene *) scene;

// Set the methods to be called for the naviagtion buttons.
-(void) setupMenu;
@end