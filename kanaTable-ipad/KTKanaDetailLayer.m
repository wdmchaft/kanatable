//
//  KanaDetailView.m
//  kanaTable
//
//  Created by Alexander Alemayhu on 17.09.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "KTKanaDetailLayer.h"
#import "SimpleAudioEngine.h"
#import "KTMenuLayer.h"
#import "KTKanaLayer.h"
#import "KTGlobal.h"

@interface KTKanaDetailLayer(Drawing)
-(void) startDrawing;
-(void) endDrawing;
-(void) clearDrawing;
@end

@implementation KTKanaDetailLayer

#pragma mark -
#pragma Initialization

-(id) initWithKana:(KTKana *)aKana{
    
    if (self = [super init]) {
        self.isTouchEnabled = YES;
        
        kanaObject = [aKana retain];
        kanaType = kanaObject.kanaType;
        
        [self setupDetailKana];
    }
    
    return self;
}

#pragma mark -
#pragma mark Setup 

-(void) setupDetailKana{
    
    winSize = [[CCDirector sharedDirector] winSize];
    
    kanaLabel = [CCLabelTTF labelWithString:kanaObject.kana 
                                   fontName:@"Arial" 
                                   fontSize:300];
    romajiLabel = [CCLabelTTF labelWithString:kanaObject.romaji 
                                     fontName:@"Arial" 
                                     fontSize:300];
    
    //We want to first show the japanese kana.
    isKanaVisible = YES;
    [romajiLabel setVisible:NO];
    kanaLabel.position = ccp(winSize.width/2, winSize.height/2);
    romajiLabel.position = ccp(winSize.width/2, winSize.height/2);
    [self addChild:romajiLabel];
    [self addChild:kanaLabel];
    
    
    if ([kanaObject isDiatric])
        [self setupMiniMenuDiatric];
    else {
        background = [CCSprite spriteWithFile:@"kanabackground_one.png"];
        background.anchorPoint = ccp(0, 0);
        [self addChild:background z:-1];
    }
    
    NSString *sound = [NSString stringWithFormat:@"%@.wav", romajiLabel.string];
    [[SimpleAudioEngine sharedEngine] preloadEffect:sound];
    
    [self setupMenu];
}

-(void) setupMenu{
    
    isTransition = NO;
    
    //Back button
    CCMenuItemImage *backItem = [CCMenuItemImage itemFromNormalImage:@"kana_table.png" 
                                                       selectedImage:@"kana_table_sel.png" 
                                                              target:self 
                                                            selector:@selector(returnToTable)];    
    CCMenu *backMenu = [CCMenu menuWithItems:backItem, nil];
    [backMenu setContentSize:CGSizeMake(backItem.contentSize.width, backItem.contentSize.height)];
    backMenu.position = ccp(winSize.width/2, 47);
    [self addChild:backMenu];
    
    
    //Sound button
    CCMenuItemImage *playItem = [CCMenuItemImage itemFromNormalImage:@"play.png" 
                                                       selectedImage:@"play_sel.png" 
                                                              target:self 
                                                            selector:@selector(playKanaSound)];
    //Draw button
    pencilItem = [CCMenuItemImage itemFromNormalImage:@"pen_default.png" 
                                        selectedImage:@"pen_default.png" 
                                               target:self 
                                             selector:@selector(startDrawing)];
    
    CCMenu *optionsMenu = [CCMenu menuWithItems:playItem, pencilItem, nil];
    [optionsMenu setContentSize:CGSizeMake(playItem.contentSize.width + pencilItem.contentSize.width, 
                                           playItem.contentSize.height + pencilItem.contentSize.height)];
    [optionsMenu alignItemsHorizontally];
    optionsMenu.position = ccp(512, 620);
    [self addChild:optionsMenu];
    
    
    
    finishedSprite = [CCSprite spriteWithFile:@"v_default.png"];//endDrawing
    clearSprite = [CCSprite spriteWithFile:@"x_default.png"];//Cleardrawing
    
    finishedSprite.position = ccp(583, 588);
    clearSprite.position = ccp(552, 588);
    
    [finishedSprite setVisible:NO];
    [clearSprite setVisible:NO];
    
    [self addChild:clearSprite];
    [self addChild:finishedSprite];
}


-(void) setupMiniMenuDiatric{
    
    background = [CCSprite spriteWithFile:@"kanabackground_two.png"];
    background.anchorPoint = ccp(0, 0);
    [self addChild:background z:-1];
    
    diatricKanaMenu = [CCMenu menuWithItems:nil];
    
    CCLabelTTF *firstdiatricKanaLabel = [CCLabelTTF labelWithString:kanaObject.kana fontName:@"Arial" fontSize:50];
    CCMenuItemLabel *firstdiatricKanaItem = [CCMenuItemLabel itemWithLabel:firstdiatricKanaLabel 
                                                                    target:self 
                                                                  selector:@selector(didSelectDiatricKanaItem:)];
    previousItem = firstdiatricKanaItem;
    firstdiatricKanaItem.tag = kanaObject.tagID;
    [firstdiatricKanaLabel setColor:ccRED];
    [diatricKanaMenu addChild:firstdiatricKanaItem];
    
    NSUInteger diatricCount = [self numberOfDiatricKana];
    
    //The combinations use the (tag * 100) as keys.
    NSUInteger index = (kanaObject.tagID * 100);
    
    //By Incrementing we get all combinations
    for (int i = 0; i <= diatricCount; i++) {
        
        //Read in the kana. 
        KTKana *diatricKana = [self diatricKanaAtIndex:index];
        
        //Use the kana's properties.
        CCLabelTTF *diatricKanaLabel = [CCLabelTTF labelWithString:diatricKana.kana fontName:@"Arial" fontSize:50];
        CCMenuItemLabel *diatricKanaItem = [CCMenuItemLabel itemWithLabel:diatricKanaLabel 
                                                                   target:self 
                                                                 selector:@selector(didSelectDiatricKanaItem:)];
        //Set the tag and add it to the diatric menu
        diatricKanaItem.tag = index;
        [diatricKanaMenu addChild:diatricKanaItem];
        index++;
        
        NSString *sound = [NSString stringWithFormat:@"%@.wav", diatricKana.romaji];
        [[SimpleAudioEngine sharedEngine] preloadEffect:sound];
        
    }
    
    diatricKanaMenu.position = ccp(winSize.width/2, winSize.height - 40);
    [diatricKanaMenu alignItemsHorizontallyWithPadding:30];
    
    [self addChild:diatricKanaMenu];
}


#pragma mark -

-(void) returnToTable{
    
    KTKanaLayer *kanaLayer = [[KTKanaLayer alloc] initWithKanaType:kanaObject.kanaType];
    CCScene *kanaTableScene = [CCScene node];
    [kanaTableScene addChild:kanaLayer];
    [kanaLayer release];
    
    [[CCDirector sharedDirector] replaceScene:[CCTransitionSlideInL 
                                               transitionWithDuration:SCENE_TRANSITION_DURATION
                                               scene:kanaTableScene]];
}

-(void) playKanaSound{
    NSString *sound = [NSString stringWithFormat:@"%@.wav", romajiLabel.string];
    
    [[SimpleAudioEngine sharedEngine] playEffect:sound];
}

#pragma mark -
#pragma - DRAWING methods

-(void) startDrawing{
    
    if (isKanaVisible == NO || isTransition == YES) { return ; }
    
    [clearSprite setVisible:YES];
    [finishedSprite setVisible:YES];
    
    [kanaLabel setOpacity:20];
    [pencilItem setOpacity:128];
    [pencilItem setIsEnabled:NO];
    isDrawing = YES;
    
    
    if (brush == nil) {
        brush = [[CCSprite spriteWithFile:@"fire.png"] retain];   
    }
    
    if (target == nil) {
        target = [[CCRenderTexture renderTextureWithWidth:winSize.width height:winSize.height] retain];
        [target setPosition:ccp(winSize.width/2, winSize.height/2)];
        [self addChild:target z:-1];
    }
}

-(void) endDrawing{
    
    if (isDrawing == NO) { return ; }
    
    isDrawing = NO;
    [clearSprite setVisible:NO];
    [finishedSprite setVisible:NO];
    [pencilItem setOpacity:255];
    [pencilItem setIsEnabled:YES];
    [kanaLabel setOpacity:255];
    
    [self removeChild:target cleanup:YES];
    [self removeChild:brush cleanup:YES];
    target = nil, brush = nil;
}

-(void) clearDrawing{
    
    if (isDrawing == NO) {
        return ;
    }
    
    [self removeChild:target cleanup:YES];
    target = nil;
    
    [self startDrawing];
    //    [target clear:CCRANDOM_0_1() g:CCRANDOM_0_1() b:CCRANDOM_0_1() a:CCRANDOM_0_1()];
}


#pragma mark -
#pragma mark CCStandardTouchDelegate

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch = [touches anyObject];
    
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView:[touch view]]];
    CGRect touchArea, locationRect;
    
    if (isDrawing == YES) {
        
        touchArea = CGRectMake(583, 588, 28, 28);
        locationRect = CGRectMake(location.x, location.y, touchArea.size.width, touchArea.size.height);
        
        
        if (CGRectIntersectsRect(touchArea, locationRect)) {
            [self endDrawing];
        }
        
        touchArea = CGRectMake(552, 588, 28, 28);
        locationRect = CGRectMake(location.x, location.y, touchArea.size.width, touchArea.size.height);
        
        if(CGRectIntersectsRect(touchArea, locationRect)){
            [self clearDrawing];
        }
        
        return ;
    }
    
    //Check the visible one if it is the romaji or the syllable
    if (isKanaVisible == YES)
        touchArea = CGRectMake(kanaLabel.position.x, kanaLabel.position.y, kanaLabel.contentSize.width/2, kanaLabel.contentSize.height/2);
    else
        touchArea = CGRectMake(romajiLabel.position.x, romajiLabel.position.y, romajiLabel.contentSize.width/2, romajiLabel.contentSize.height/2);
    
    locationRect = CGRectMake(location.x, location.y, touchArea.size.width, touchArea.size.height);
    
    if ( CGRectIntersectsRect(touchArea, locationRect) ){
        [self recievedTouch];
    }
}   

//Code snippet from cocos2d test
//Start snippet
-(void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint start = [touch locationInView: [touch view]];	
	start = [[CCDirector sharedDirector] convertToGL: start];
	CGPoint end = [touch previousLocationInView:[touch view]];
	end = [[CCDirector sharedDirector] convertToGL:end];
    
	// begin drawing to the render texture
	[target begin];
	
	// for extra points, we'll draw this smoothly from the last position and vary the sprite's
	// scale/rotation/offset
	float distance = ccpDistance(start, end);
	if (distance > 1)
	{
		int d = (int)distance;
		for (int i = 0; i < d; i++)
		{
			float difx = end.x - start.x;
			float dify = end.y - start.y;
			float delta = (float)i / distance;
			[brush setPosition:ccp(start.x + (difx * delta), start.y + (dify * delta))];
			[brush setRotation:rand()%360];
			float r = ((float)(rand()%50)/50.f) + 0.25f;
			[brush setScale:r];
			[brush setColor:ccc3(CCRANDOM_0_1()*127+128, 255, 255) ];
			// Call visit to draw the brush, don't call draw..
			[brush visit];
		}
	}
	// finish drawing and return context back to the screen
	[target end];	
}
//End snippet

#pragma mark -
#pragma mark TouchDelegate 

-(void) recievedTouch{
    
    if (isDrawing == YES) { return ;    }
    
    float d = 2.0f;
    //Disable touch until flip action is over
    self.isTouchEnabled = NO;
    
    id firstAction = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:90 angleX:0 deltaAngleX:0];
    id secondAction = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:270 deltaAngleZ:90 angleX:0 deltaAngleX:0];
    CCCallFunc *activateTouch = [CCCallFunc actionWithTarget:self selector:@selector(enableTouch)];
    
    if (isKanaVisible == YES) {
        isKanaVisible = NO;
        [kanaLabel runAction:firstAction];
        [kanaLabel setVisible:NO];
        [romajiLabel setVisible:YES];
        [romajiLabel runAction:[CCSequence actions:secondAction, activateTouch, nil]];
        
    }else{
        isKanaVisible = YES;
        
        [romajiLabel runAction:secondAction];
        [romajiLabel setVisible:NO];
        
        [kanaLabel setVisible:YES];
        [kanaLabel runAction:[CCSequence actions:secondAction, activateTouch, nil]];
    }
}


-(void) enableTouch{
    self.isTouchEnabled = YES;
}

#pragma mark -
#pragma mark KanaDiatricDataSource

-(NSUInteger) numberOfDiatricKana{
    
    NSUInteger tagID = kanaObject.tagID;
    
    /*
     * These magic numbers are like the kana is in the kana model. 
     * We already know which ones are diatric, since all of them
     * are in the plist.
     */
    switch (tagID) {
            
        case 25: case 27: case 28: case 29:
            return 2;
            break;
        case 21: case 31: case 39:
            return 3;
            break;
        case 6: case 11: case 16: case 26: 
            return 7;
            break;
        case 5: case 7: case 8: case 9: 
        case 10: case 12: case 13: case 14: 
        case 15: case 17: case 18: case 19:
            return 1;
            break;
        default:
            break;
    }
    
    return 0;
}


-(KTKana *) diatricKanaAtIndex:(NSUInteger)index{
    
    NSAssert( index != 0, @"%d is not a valid index");
    
    KTKana *diatricKana = [[[KTKana alloc] initWithKanaID:index kanaType:kanaType] autorelease];
    
    return diatricKana;
}

#pragma mark -
#pragma mark KanaDiatricDelegate

-(void) didSelectDiatricKanaItem:(CCMenuItemLabel *)item{
    
    if (isDrawing == YES) {
        return ;
    }
    
    isTransition = YES;
    
    //No need to make change for retapping current item.
    if (previousItem.tag == item.tag)
        return ;
    
    [previousItem setColor:ccWHITE];
    previousItem = item;
    unsigned int tagID = item.tag;
    KTKana *tempKana = [[KTKana alloc] initWithKanaID:tagID kanaType:kanaType];
    
    [item setColor:ccRED];
    [kanaObject release];
    kanaObject = [tempKana retain];
    [tempKana release];
    
    if (isKanaVisible){
        [self fadeOutLabel:kanaLabel];
        [kanaLabel setString:kanaObject.kana];
        [romajiLabel setString:kanaObject.romaji];
        [self fadeInLabel:kanaLabel];
    }else if ( isKanaVisible == NO ){
        [self fadeOutLabel:romajiLabel];
        [kanaLabel setString:kanaObject.kana];
        [romajiLabel setString:kanaObject.romaji];
        [self fadeInLabel:romajiLabel];
    }
}

#pragma mark -

-(void) fadeOutLabel:(CCLabelTTF *)label{
    
    id actionFadeOut = [CCFadeOut actionWithDuration:ACTION_DURATION];
    [label runAction:actionFadeOut];
}

-(void) fadeInLabel:(CCLabelTTF *)label{
    
    id actionFadeIn = [CCFadeIn actionWithDuration:ACTION_DURATION];
    CCCallFunc *tranEnd = [CCCallFunc actionWithTarget:self selector:@selector(transitionDone)];
    
    CCSequence *seq = [CCSequence actions:actionFadeIn, tranEnd, nil];
    
    [label runAction:seq];
}

-(void) transitionDone{
    isTransition = NO;
}



@end
