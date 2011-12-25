//
//  KTMemoryCard.m
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 21.12.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "KTMemoryCard.h"
#import "KTKana.h"

@interface KTMemoryCard ()
-(void) makeOrHide;
@end


@implementation KTMemoryCard

@synthesize isFacedUp;

+(id) withKey:(NSUInteger)key{
    
    return [[[self alloc] initCardWithKey:key] autorelease];
}

-(id) initCardWithKey:(NSUInteger)key{
    
    if (self = [super initWithFile:@"card_tmp.png"]) {
        
        isFacedUp = NO;
        kana = [[KTKana alloc] initWithKanaID:key kanaType:HIRAGANA];
        
        label = [CCLabelTTF labelWithString:kana.kana fontName:@"Arial" fontSize:50];
        [label setColor:ccBLACK];
        label.position = ccp(self.contentSize.width/2, self.contentSize.height/2);
        [label setVisible:isFacedUp];
        [self addChild:label];
    }
    
    return self;
}

-(void) flipCard{
    
    //Code from cocos2d forum
    float d = 0.25f;
    id firstAction = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:0 deltaAngleZ:90 angleX:0 deltaAngleX:0];
    id secondAction = [CCOrbitCamera actionWithDuration:d/2 radius:1 deltaRadius:0 angleZ:270 deltaAngleZ:90 angleX:0 deltaAngleX:0];
    id thirdAction = [CCCallFuncN actionWithTarget:self selector:@selector(makeOrHide)];
    [self runAction: [CCSequence actions:firstAction, thirdAction, secondAction, nil]];        
}

-(void) makeOrHide{
    
    isFacedUp = !isFacedUp;
    [label setVisible:isFacedUp];
}


@end
