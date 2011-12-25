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
#import "KTMemoryCard.h"
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

+(id) withLevel:(KTLevel)lvl{
    
    return [[[self alloc] initWithLevel:lvl] autorelease];
}

// on "init" you need to initialize your instance
-(id) initWithLevel:(KTLevel)lvl
{
    
	if( (self=[super init])) {
        self.isTouchEnabled = YES;
        
        level = lvl;
        [self setupGameBoard];
    }
    
	return self;
}

-(void) setupGameBoard{
    
    background = [CCSprite spriteWithFile:@"gameboard.png"];
    background.anchorPoint = ccp(0, 0);
    [self addChild:background];
    
    cards = [[NSMutableArray alloc] init];
    
    CGSize winSize = [[CCDirector sharedDirector] winSize];
    
    CCLabelTTF *labelOne = [CCLabelTTF labelWithString:@"Level menu" fontName:@"Arial" fontSize:40];
    CCLabelTTF *labelTwo = [CCLabelTTF labelWithString:@"Main menu" fontName:@"Arial" fontSize:40];
    
    CCMenuItemLabel *itemOne = [CCMenuItemLabel itemWithLabel:labelOne target:self 
                                                     selector:@selector(returnToLevelMenu)];
    CCMenuItemLabel *itemTwo = [CCMenuItemLabel itemWithLabel:labelTwo target:self
                                                     selector:@selector(returnToMainMenu)];
    
    CCMenu *navMenu = [CCMenu menuWithItems: itemOne, itemTwo, nil];
    [navMenu alignItemsHorizontallyWithPadding:10];
    navMenu.position = ccp(winSize.width/2, itemOne.contentSize.height/2);
    
    [self addChild:navMenu];
    
    //TODO: Load correct cards for all levels(1-6);
    
    int cardWidth = 145;
    int x = cardWidth/2 + 20;
    int y = winSize.height - 100;
    
    for (int i = 0; i < 6; i++) {
        
        for (int j = 0; j < 6; j++) {
            
            KTMemoryCard *card = [KTMemoryCard withKey:i+j];
            card.position = ccp(x, y);
            [self addChild:card];
            [cards addObject:card];
            x += cardWidth + 20;
            //            NSLog(@"Card contentsize: %@", NSStringFromCGSize(card.contentSize));
            //            NSLog(@"Card position: %@", NSStringFromCGPoint(card.position));
        }
        
        x = 145/2 + 20;
        y -= 100;
    }
    
    
    [self scheduleUpdate];    
}

-(void) update:(ccTime)dt{
    
    /* 
     * TODO: check if cards are equal.
     * If the cards are equal, vaporish the card and play the pronuciation.
     * Otherwise flip the cards back.
     */
}

#pragma mark - CCStandardTouchDelegate

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch *touch = [touches anyObject];
    
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView:[touch view]]];
    
    for (int i = 0; i < [cards count]; i++) {
        
        KTMemoryCard *card = [cards objectAtIndex:i];        
        CGRect locationRect = CGRectMake(location.x, location.y, card.contentSize.width/2, card.contentSize.height/2);
        
        if (CGRectIntersectsRect(locationRect, [card boundingBox])) {
            [card flipCard];
            return ;//Flip only one card per touch
        }            
    }
}

#pragma mark -
#pragma mark Navigation

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
