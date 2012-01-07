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

    CGSize winSize;
    CCSprite *background;
    CCMenu *diatricKanaMenu;
    CCMenuItemLabel *previousItem;
    CCMenuItemImage *pencilItem;
        
    CCLabelTTF *kanaLabel;
    CCLabelTTF *romajiLabel;
    
    BOOL isKanaVisible;
    BOOL isTransition;//Used for switching the current kana
    TKKanaType kanaType;
    KTKana *kanaObject;
    
    //Draw stuff
    BOOL isDrawing;
    CCSprite *brush;
    CCRenderTexture *target;

    CCSprite *finishedSprite;
    CCSprite *clearSprite;
}

-(id) initWithKana:(KTKana *)aKana;
@end
