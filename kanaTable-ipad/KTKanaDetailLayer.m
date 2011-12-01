//
//  KanaDetailView.m
//  kanaTable
//
//  Created by Alexander Alemayhu on 17.09.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "KTKanaDetailLayer.h"
#import "com.ccColor3B.h"
#import "KTMenuLayer.h"
#import "KTKanaLayer.h"
#import "KTGlobal.h"

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
    
    kanaLabel.position = ccp(winSize.width/2, winSize.height/2);
    romajiLabel.position = ccp(winSize.width/2, winSize.height/2);
    
    //We want to first show the japanese kana.
    isKanaVisible = YES;
    [romajiLabel setVisible:NO];
    [self addChild:romajiLabel];
    [self addChild:kanaLabel];
    
    //Sound button
    CCMenuItemImage *playItem = [CCMenuItemImage itemFromNormalImage:@"play.png" 
                                                       selectedImage:@"play_sel.png" 
                                                              target:self 
                                                            selector:@selector(playKanaSound)];
    CCMenu *soundMenu = [CCMenu menuWithItems:playItem, nil];
    [soundMenu setContentSize:CGSizeMake(playItem.contentSize.width, playItem.contentSize.height)];
    soundMenu.position = ccp(512, 620);
    [self addChild:soundMenu];
    
    NSLog(@"soundMenu: %fx%f", soundMenu.contentSize.width, soundMenu.contentSize.height);
    
    //Add the back button
    CCMenuItemImage *backItem = [CCMenuItemImage itemFromNormalImage:@"kana_table.png" 
                                                       selectedImage:@"kana_table_sel.png" 
                                                              target:self 
                                                            selector:@selector(returnToTable)];    
    CCMenu *backMenu = [CCMenu menuWithItems:backItem, nil];
    [backMenu setContentSize:CGSizeMake(backItem.contentSize.width, backItem.contentSize.height)];
    backMenu.position = ccp(winSize.width/2, 47);
    [self addChild:backMenu];
    
    if ([kanaObject isDiatric])
        [self setupMiniMenuDiatric];
    else {
        background = [CCSprite spriteWithFile:@"kanabackground_one.png"];
        background.anchorPoint = ccp(0, 0);
        [self addChild:background z:-1];
    }
    
    NSString *sound = [NSString stringWithFormat:@"%@.wav", romajiLabel.string];
    [[SimpleAudioEngine sharedEngine] preloadEffect:sound];
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
#pragma mark CCStandardTouchDelegate

-(void) ccTouchesBegan:(NSSet *)touches withEvent:(UIEvent *)event{
    
    UITouch* touch = [touches anyObject];
    
    
    CGPoint location = [[CCDirector sharedDirector] convertToGL: [touch locationInView:[touch view]]];
    CGRect touchArea, locationRect;
    
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

#pragma mark -
#pragma mark TouchDelegate 

-(void) recievedTouch{
    
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
    [label runAction:actionFadeIn];
}



@end
