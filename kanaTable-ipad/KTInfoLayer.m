//
//  KTInfoLayer.m
//  kanaTable
//
//  Created by Alexander Alemayhu on 10.11.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "KTInfoLayer.h"
#import "KTMenuLayer.h"
#import "KTGlobal.h"
//Private methods for setup and navigation.  Implemented basic layer code.
@interface KTInfoLayer(privateMethods)
//Setup a back button the menu.
-(void) setupInfo;
//Allow user to return to the menu.
-(void) returnToMenu;
@end

@implementation KTInfoLayer

+(CCScene *) scene
{
	
	CCScene *scene = [CCScene node];
	
	KTInfoLayer *layer = [KTInfoLayer node];
	
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init{
    
    if (self = [super init]) {
        
        [self setupInfo];
    }
    
    return self;
}

-(void) setupInfo{
    background = [CCSprite spriteWithFile:@"credits.png"];
    background.anchorPoint = ccp(0, 0);
    [self addChild:background];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    backItem = [CCMenuItemImage itemFromNormalImage:@"menu_button_short.png" 
                                      selectedImage:@"menu_button_short_sel.png" 
                                             target:self 
                                           selector:@selector(returnToMenu)];
    
    navMenu = [CCMenu menuWithItems: backItem, nil];
    [navMenu setContentSize:CGSizeMake(backItem.contentSize.width, backItem.contentSize.height)];
    [navMenu alignItemsVertically];
    
    //Magic number: 
    //It positions the button below the table with some distance
    navMenu.position = ccp(winSize.width/2, winSize.height/2 - 147); 
    
    [self addChild:navMenu];

}


-(void) returnToMenu{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL 
                                               transitionWithDuration:SCENE_TRANSITION_DURATION 
                                               scene:[KTMenuLayer node]]];
}

@end
