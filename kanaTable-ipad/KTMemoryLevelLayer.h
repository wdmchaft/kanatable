//
//  KTMemoryLevelLayer.h
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 21.12.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "KTGlobal.h"

@interface KTMemoryLevelLayer : CCLayer {
    CCSprite *background;    
    
    //Menu for aligning items.
    CCMenu *menu;    

    TKKanaType kanaType;
}

-(void) setupMenu;

-(id) initKatLevel;
-(id) initHirLevel;

@end
