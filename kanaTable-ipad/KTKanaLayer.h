//
//  KanaLayer.h
//  kanaTable
//
//  Created by Alexander Alemayhu on 13.10.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "cocos2d.h"
#import "KTGlobal.h"

@interface KTKanaLayer : CCLayer {
    CCMenu *tableMenu;
    CCMenuItemImage *backItem;
    TKKanaType kanaType;
    CCSprite *background;
}

//Init for the appropriate table
-(id) initWithKanaType:(TKKanaType) kaType;
//Setup a back button the menu.
-(void) setupTable;
//Allow user to return to the menu, by tapping the backItem.
-(void) returnToMenu;
//Do something with the selected kana.
-(void) didSelectKana:(CCMenuItemLabel *)sender;
@end
