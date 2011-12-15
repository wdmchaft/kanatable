//
//  KanaDetailView.h
//  kanaTable
//
//  Created by Alexander Alemayhu on 17.09.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "cocos2d.h"
#import "KTGlobal.h"
#import "KTKana.h"

//Make the user wait, when tapped a kana.
@protocol TouchDelegate <NSObject>
-(void) recievedTouch;
-(void) enableTouch;
@end

@interface KTKanaDetailLayer : CCLayer<TouchDelegate, KTKanaDiatricDataSource, KTKanaDiatricDelegate>{
    CCLabelTTF *kanaLabel;
    CCLabelTTF *romajiLabel;
    
    BOOL isKanaVisible;
    
    TKKanaType kanaType;
    KTKana *kanaObject;
    
    CCMenu *diatricKanaMenu, *drawMenuOne, *drawMenuTwo;
    CCMenuItemLabel *previousItem;
    CCMenuItemImage *pencilItem;
    CGSize winSize;
    
    CCSprite *background;
    
    
    //Draw stuff
    BOOL isDrawing;
    CCSprite *brush;
    CCRenderTexture *target;
}

// Setup the kana to display and pronunciation. Add the back button.
-(id) initWithKana:(KTKana *)aKana;
//Add the kana to the layer.
-(void) setupDetailKana;
-(void) setupMenu;
// Pop the running scene and return to the table.
-(void) returnToTable;
//Load in the diatric kanas and add them to the menu
-(void) setupMiniMenuDiatric;
//Play preloaded sounds.
-(void) playKanaSound;
//Used when user's tap a diatric kana
-(void) fadeOutLabel:(CCLabelTTF *) label;
-(void) fadeInLabel:(CCLabelTTF *) label;

@end
