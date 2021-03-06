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

@interface KTMenuLayer(navigationMethods)
//Configure
-(void) setupMenu;
//Navigation
-(void) openHiraganaTable;
-(void) openKatakanaTable;
-(void) openInfoLayer;
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
