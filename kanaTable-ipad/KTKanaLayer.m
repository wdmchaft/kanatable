//
//  KanaLayer.m
//  kanaTable
//
//  Created by Alexander Alemayhu on 13.10.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "KTKanaLayer.h"
#import "KTMenuLayer.h"
#import "KTGlobal.h"
#import "NSDictionary+readPlist.h"
#import "KTKana.h"
#import "KTKanaDetailLayer.h"


@implementation KTKanaLayer

-(id) initWithKanaType:(TKKanaType)kType{
    
    if (self = [super init]) {
        
        kanaType = kType;
        
        background = [CCSprite spriteWithFile:@"kanabackground_one.png"];
        background.anchorPoint = ccp(0, 0);
        [self addChild:background];
        
        CGSize winSize = [[CCDirector sharedDirector] winSize];
        backItem = [CCMenuItemImage itemFromNormalImage:@"menu_button.png" 
                                          selectedImage:@"menu_button_sel.png" 
                                                 target:self 
                                               selector:@selector(returnToMenu)];
        
        CCMenu *navMenu = [CCMenu menuWithItems: backItem, nil];
        [navMenu alignItemsVertically];
        
        //Magic number: 
        //It positions the button below the table with some distance
        navMenu.position = ccp(winSize.width/2, 47); 
        
        [self addChild:navMenu];
        
        [self setupTable];
    }
    
    return self;
}

-(void) setupTable{
    //Overriden in the subclasses.
    
    float fontSize = 50.0f;
    int basicKanaCount = 43;
    
    NSString *plistName = @"ddd";
    NSString *fontName = @"Arial";
    
    if (kanaType == HIRAGANA) {
        plistName = @"hiragana";
    }
    else if (kanaType == KATAKANA) {
        plistName = @"katakana";
    }
    
    tableMenu = [CCMenu menuWithItems: nil];
    
    //Create a dictionary with all the kana.
    NSDictionary *kanaDict = [NSDictionary readPlist:plistName];
    
    /* For the table we want to use the kanas which use the key values 0-43.
     The loop Use the dictionary to load in the kanas. Then it creates 
     the items from a label and sets the tag to the current index.
     Finally the kana is added to the table menu.
     */
    for (int i = 0; i <= basicKanaCount; i++) {
        
        NSString *kanaKey = [NSString stringWithFormat:@"%d", i];
        NSString *kanaSyllable = [kanaDict objectForKey:kanaKey];
        
        CCLabelTTF *kanaLabel = [CCLabelTTF labelWithString:kanaSyllable 
                                                   fontName:fontName 
                                                   fontSize:fontSize];
        
        CCMenuItemLabel *kanaItem = [CCMenuItemLabel itemWithLabel:kanaLabel 
                                                            target:self 
                                                          selector:@selector(didSelectKana:)];
        kanaItem.tag = i;
        [tableMenu addChild:kanaItem];
        
        /* Because ya, yu,  and yo only are three syllables 
         we add empty labels to align them correctly */
        if (i == 35 || i == 36) {
            CCLabelTTF *labelEmpty = [CCLabelTTF labelWithString:@"" 
                                                        fontName:fontName 
                                                        fontSize:fontSize];
            CCMenuItemLabel *emptyItem = [CCMenuItemLabel itemWithLabel:labelEmpty 
                                                                 target:nil 
                                                               selector:nil];            
            [tableMenu addChild:emptyItem];
        }
    }
    
    /* Align all the kana to be listed like this: 
     あ    い   う   え   お
     か    き   く   け   こ     
     さ    し   す   せ   そ
     た    ち   つ   て   と
     な    に   ぬ   ね   の
     は    ひ   ふ   へ   ほ
     ま    み   む   め   も
     や         ゆ       よ
     ら    り   る   れ   ろ
     　         ん
     */
    [tableMenu alignItemsInColumns:[NSNumber numberWithInt:5], [NSNumber numberWithInt:5], 
     [NSNumber numberWithInt:5], [NSNumber numberWithInt:5],
     [NSNumber numberWithInt:5],[NSNumber numberWithInt:5],
     [NSNumber numberWithInt:5], [NSNumber numberWithInt:5],
     [NSNumber numberWithInt:5], [NSNumber numberWithInt:1],
     nil];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    //Magic number:
    //It positions the table almost in the middle of the screen, it appears to be middle, which it isn't.
    tableMenu.position = ccp(winSize.width/2, winSize.height - 347);
    
    [self addChild:tableMenu];
}

-(void) returnToMenu{
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL 
                                               transitionWithDuration:SCENE_TRANSITION_DURATION 
                                               scene:[KTMenuLayer node]]];
}


-(void) didSelectKana:(CCMenuItemLabel *)sender{
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    KTKana *aKana = [[KTKana alloc] initWithKanaID:sender.tag kanaType:kanaType];
    CCScene *kanaScene = [CCScene node];
    KTKanaDetailLayer *kanaDetailLayer = [[KTKanaDetailLayer alloc] initWithKana:aKana];
    
    [aKana release];
	[kanaScene addChild:kanaDetailLayer];
    
    [self runAction:[CCMoveBy actionWithDuration:SCENE_TRANSITION_DURATION 
                                        position:ccp(-winSize.width,0)]];    
    
    [[CCDirector sharedDirector] replaceScene:
     [CCTransitionMoveInR transitionWithDuration:SCENE_TRANSITION_DURATION
                                           scene:kanaScene]];
    [kanaDetailLayer release];
}
@end
