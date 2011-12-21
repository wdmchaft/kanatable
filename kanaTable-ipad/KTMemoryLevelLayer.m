//
//  KTMemoryLevelLayer.m
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 21.12.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "KTMemoryLevelLayer.h"
#import "KTMemoryMenuLayer.h"

@implementation KTMemoryLevelLayer


#pragma mark -
#pragma mark Init methods

-(id) initKatLevel{
    
    if (self = [super init]) {
        CCLOG(@"%s", __FUNCTION__);
        kanaType = KATAKANA;
        [self setupMenu];
    }
    
    return self;
}

-(id) initHirLevel{
    
    if (self = [super init]) {        
        kanaType = HIRAGANA;
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
    
    CCLabelTTF *title = [CCLabelTTF labelWithString:@"Select a level" fontName:@"Arial" fontSize:100];
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    title.position = ccp(winSize.width/2, winSize.height - title.contentSize.height);
    [self addChild:title];
    
    CCLabelTTF *labelOne = [CCLabelTTF labelWithString:@"Level #1" fontName:@"Arial" fontSize:60];
    CCLabelTTF *labelTwo = [CCLabelTTF labelWithString:@"Level #2" fontName:@"Arial" fontSize:60];
    CCLabelTTF *labelThree = [CCLabelTTF labelWithString:@"Level #3" fontName:@"Arial" fontSize:60];
    CCLabelTTF *labelFour = [CCLabelTTF labelWithString:@"Level #4" fontName:@"Arial" fontSize:60];
    CCLabelTTF *labelFive = [CCLabelTTF labelWithString:@"Level #5" fontName:@"Arial" fontSize:60];
    CCLabelTTF *labelSix = [CCLabelTTF labelWithString:@"Level #6" fontName:@"Arial" fontSize:60];
    
    CCMenuItemLabel *itemOne = [CCMenuItemLabel itemWithLabel:labelOne target:nil selector:nil];
    CCMenuItemLabel *itemTwo = [CCMenuItemLabel itemWithLabel:labelTwo target:nil selector:nil];
    CCMenuItemLabel *itemThree = [CCMenuItemLabel itemWithLabel:labelThree target:nil selector:nil];
    CCMenuItemLabel *itemFour = [CCMenuItemLabel itemWithLabel:labelFour target:nil selector:nil];
    CCMenuItemLabel *itemFive = [CCMenuItemLabel itemWithLabel:labelFive target:nil selector:nil];
    CCMenuItemLabel *itemSix = [CCMenuItemLabel itemWithLabel:labelSix target:nil selector:nil];
    
    menu = [CCMenu menuWithItems: itemOne, itemTwo, itemThree, itemFour, itemFive, itemSix,nil];
    [menu alignItemsVerticallyWithPadding:10];
    [self addChild:menu];
    
    CCMenuItemImage *backItem = [CCMenuItemImage itemFromNormalImage:@"menu_button.png" 
                                                       selectedImage:@"menu_button_sel.png" 
                                                              target:self 
                                                            selector:@selector(returnToMenu)];
    
    CCMenu *navMenu = [CCMenu menuWithItems: backItem, nil];
    //Magic number: 
    //It positions the button below the table with some distance
    navMenu.position = ccp(winSize.width/2, 47); 
    [self addChild:navMenu];
}


#pragma mark -

-(void) returnToMenu{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL
                                               transitionWithDuration:SCENE_TRANSITION_DURATION 
                                               scene:[KTMemoryMenuLayer node]]];
}

@end
