//
//  MenuLayer.m
//  kanaTable
//
//  Created by Alexander Alemayhu on 25.08.11.
//  Copyright Flexnor 2011. All rights reserved.
//


// Import the interfaces
#import "KTMenuLayer.h"
#import "KTKanaLayer.h"
#import "KTInfoLayer.h"
#import "KTGlobal.h"
#import "KTMemoryMenuLayer.h"

@interface KTMenuLayer(navigationMethods)
/* When the user selects a button one of the open methods replaces the current 
 scene with a new table scene. */
-(void) openHiraganaTable;
-(void) openKatakanaTable;
-(void) openInfoLayer;
//Open games
-(void) openMemoryGameLayer;
@end

@implementation KTMenuLayer

+(CCScene *) scene
{
	
	CCScene *scene = [CCScene node];
	
	KTMenuLayer *layer = [KTMenuLayer node];
	
	
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
    
    background = [CCSprite spriteWithFile:@"background.png"];
    background.anchorPoint = ccp(0, 0);
    [self addChild:background];
    
    hirItem = [CCMenuItemImage itemFromNormalImage:@"hiragana_but.png" 
                                     selectedImage:@"hiragana_but_sel.png" 
                                            target:self 
                                          selector:@selector(openHiraganaTable)];
    katItem = [CCMenuItemImage itemFromNormalImage:@"katakana_but.png" 
                                     selectedImage:@"katakana_but_sel.png" 
                                            target:self 
                                          selector:@selector(openKatakanaTable)];
    
    menu = [CCMenu menuWithItems:hirItem, katItem, nil];
    [menu alignItemsHorizontallyWithPadding:3];
    [self addChild:menu];
    
    infoItem = [CCMenuItemImage itemFromNormalImage:@"infobut.png"
                                      selectedImage:@"infobut_sel.png" 
                                             target:self 
                                           selector:@selector(openInfoLayer)];
    
    infoMenu = [CCMenu menuWithItems:infoItem, nil];
    infoMenu.position = ccp(infoItem.contentSize.width/2, infoItem.contentSize.height/2);
    [self addChild:infoMenu];
    
    
    CCLabelTTF *labelOne = [CCLabelTTF labelWithString:@"Addon #1" 
                                              fontName:@"Arial" 
                                              fontSize:25];
    CCMenuItemLabel *itemOne = [CCMenuItemLabel itemWithLabel:labelOne 
                                                       target:self 
                                                     selector:@selector(openMemoryGameLayer)];

    gameMenu = [CCMenu menuWithItems:itemOne, nil];
    [gameMenu alignItemsHorizontallyWithPadding:10];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    gameMenu.position = ccp(winSize.width/2, itemOne.contentSize.height);
    [self addChild:gameMenu];
}


#pragma mark Menu 

-(void) openHiraganaTable{
    
    CCScene *kanaScene = [CCScene node];
    KTKanaLayer *kanaLayer = [[KTKanaLayer alloc] initWithKanaType:HIRAGANA];
    [kanaScene addChild:kanaLayer];
    [kanaLayer release];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR 
                                               transitionWithDuration:SCENE_TRANSITION_DURATION 
                                               scene:kanaScene]];
}


-(void) openKatakanaTable{
    
    CCScene *kanaScene = [CCScene node];
    KTKanaLayer *kanaLayer = [[KTKanaLayer alloc] initWithKanaType:KATAKANA];
    [kanaScene addChild:kanaLayer];
    [kanaLayer release];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInR 
                                               transitionWithDuration:SCENE_TRANSITION_DURATION
                                               scene:kanaScene]];
}

-(void) openInfoLayer{
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL 
                                               transitionWithDuration:SCENE_TRANSITION_DURATION
                                               scene:[KTInfoLayer node]]];    
}

-(void) openMemoryGameLayer{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInB
                                               transitionWithDuration:SCENE_TRANSITION_DURATION
                                               scene:[KTMemoryMenuLayer node]]];    
}


// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
