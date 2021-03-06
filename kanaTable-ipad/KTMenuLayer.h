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
    
    CCSprite *background;
    
    //Two buttons
    CCMenuItemImage *hirItem;
    CCMenuItemImage *katItem;
    
    CCMenuItemImage *infoItem;
    
}

+(CCScene *) scene;
@end
