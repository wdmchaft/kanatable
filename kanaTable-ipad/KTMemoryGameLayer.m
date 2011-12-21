//
//  KTMemoryGameLayer.m
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 21.12.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "KTMemoryGameLayer.h"
#import "KTMemoryMenuLayer.h"
#import "KTMenuLayer.h"
#import "KTGlobal.h"

@interface KTMemoryGameLayer()
-(void) returnToMainMenu;
-(void) returnToLevelMenu;
@end

@implementation KTMemoryGameLayer

+(CCScene *) scene
{
	
	CCScene *scene = [CCScene node];
	
	KTMemoryGameLayer *layer = [KTMemoryGameLayer node];
	
	
	[scene addChild: layer];
	
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    
	if( (self=[super init])) {
        [self setupGameBoard];
    }
    
	return self;
}

-(void) setupGameBoard{
    
    background = [CCSprite spriteWithFile:@"gameboard.png"];
    background.anchorPoint = ccp(0, 0);
    [self addChild:background];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCMenuItemImage *itemOne = [CCMenuItemImage itemFromNormalImage:@"lvl_menu_but.png" selectedImage:@"lvl_menu_but_sel.png"
                                target:self selector:@selector(returnToLevelMenu)];
    CCMenuItemImage *itemTwo = [CCMenuItemImage itemFromNormalImage:@"menu_but.png" selectedImage:@"menu_but_sel.png"
                                target:self selector:@selector(returnToMainMenu)];
    
    CCMenu *navMenu = [CCMenu menuWithItems: itemOne, itemTwo, nil];
    [navMenu alignItemsHorizontallyWithPadding:10];
    navMenu.position = ccp(winSize.width/2, itemOne.contentSize.height/2);

    [self addChild:navMenu];
}

-(void) returnToMainMenu{
            
        [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInT
                                                   transitionWithDuration:SCENE_TRANSITION_DURATION 
                                                   scene:[KTMenuLayer node]]];
}

-(void) returnToLevelMenu{
        
        [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL
                                                   transitionWithDuration:SCENE_TRANSITION_DURATION 
                                                   scene:[KTMemoryMenuLayer node]]];
}

@end
