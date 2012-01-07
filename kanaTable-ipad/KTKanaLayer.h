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
@end
