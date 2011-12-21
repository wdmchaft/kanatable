//
//  MenuLayer.h
//  kanaTable
//
//  Created by Alexander Alemayhu on 25.08.11.
//  Copyright Flexnor 2011. All rights reserved.
//


#import "cocos2d.h"

@interface KTMenuLayer : CCLayer
{
    //Menu for aligning items.
    CCMenu *menu;    
    CCMenu *infoMenu;    
    CCMenu *gameMenu;
    
    CCSprite *background;
    
    //Two buttons
    CCMenuItemImage *hirItem;
    CCMenuItemImage *katItem;
    
    CCMenuItemImage *infoItem;
    
}

+(CCScene *) scene;

// Set the methods to be called for the naviagtion buttons.
-(void) setupMenu;
@end
