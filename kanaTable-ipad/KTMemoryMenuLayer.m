//
//  KTMemoryMenuLayer.m
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 21.12.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "KTMemoryMenuLayer.h"
#import "KTMenuLayer.h"
#import "KTMemoryLevelLayer.h"
#import "KTGlobal.h"

@interface KTMemoryMenuLayer()
-(void) openHiraganaLevels;
-(void) openKatakanaLevels;
@end

@implementation KTMemoryMenuLayer

+(CCScene *) scene
{
	
	CCScene *scene = [CCScene node];
	
	KTMemoryMenuLayer *layer = [KTMemoryMenuLayer node];
	
	
	[scene addChild: layer];
	
	return scene;
}

// on "init" you need to initialize your instance
-(id) init
{
    
	if( (self=[super init])) {
        [self setupMenu];
    }
	return self;
}

#pragma mark -
#pragma mark Setup

-(void) setupMenu{

    background = [CCSprite spriteWithFile:@"memo_menu.png"];
    background.anchorPoint = ccp(0, 0);
    [self addChild:background];
    
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Memory game" fontName:@"Arial" fontSize:100];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    title.position = ccp(winSize.width/2, winSize.height - title.contentSize.height);
    [self addChild:title];

    hirItem = [CCMenuItemImage itemFromNormalImage:@"hiragana_but.png" 
                                     selectedImage:@"hiragana_but_sel.png" 
                                            target:self 
                                          selector:@selector(openHiraganaLevels)];
    katItem = [CCMenuItemImage itemFromNormalImage:@"katakana_but.png" 
                                     selectedImage:@"katakana_but_sel.png" 
                                            target:self 
                                          selector:@selector(openKatakanaLevels)];
    
    menu = [CCMenu menuWithItems:hirItem, katItem, nil];
    [menu alignItemsHorizontallyWithPadding:3];
    [self addChild:menu];
    
    CCMenuItemImage *backItem = [CCMenuItemImage itemFromNormalImage:@"menu_button.png" 
                                      selectedImage:@"menu_button_sel.png" 
                                             target:self 
                                           selector:@selector(returnToMenu)];
    
    CCMenu *navMenu = [CCMenu menuWithItems: backItem, nil];
    [navMenu alignItemsVertically];    
    navMenu.position = ccp(winSize.width/2, 47);         
    [self addChild:navMenu];
}


#pragma mark navigation methods 

-(void) openHiraganaLevels{
    
    KTMemoryLevelLayer *levelLayer = [[KTMemoryLevelLayer alloc] initHirLevel];
    CCScene *newScene = [CCScene node];    
    [newScene addChild:levelLayer];        
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL 
                                               transitionWithDuration:SCENE_TRANSITION_DURATION 
                                               scene:newScene]];
}


-(void) openKatakanaLevels{
    
    KTMemoryLevelLayer *levelLayer = [[KTMemoryLevelLayer alloc] initKatLevel];
    CCScene *newScene = [CCScene  node];
    [newScene addChild:levelLayer];    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL 
                                               transitionWithDuration:SCENE_TRANSITION_DURATION 
                                               scene:newScene]];
}

-(void) returnToMenu{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL 
                                               transitionWithDuration:SCENE_TRANSITION_DURATION 
                                               scene:[KTMenuLayer node]]];
}

@end
