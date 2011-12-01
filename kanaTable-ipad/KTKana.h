//
//  Kana.h
//  kanaTable
//
//  Created by Alexander Alemayhu on 19.09.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTGlobal.h"
#import "cocos2d.h"

@class KTKana;
@protocol KTKanaDiatricDataSource <NSObject>
// Returns number of kana to be displayed. 
-(NSUInteger) numberOfDiatricKana;
//Returns the diatric kana at the current index.     
-(KTKana *) diatricKanaAtIndex:(NSUInteger)index;
@end

@protocol KTKanaDiatricDelegate <NSObject>
//Do with the selected kana. 
-(void) didSelectDiatricKanaItem:(CCMenuItemLabel *)item;
@end

@interface KTKana : NSObject{
    
    NSString *kana;
    NSString *romaji;
    NSUInteger tagID;
    TKKanaType kanaType;
}

@property (nonatomic, readonly) NSString *kana;
@property (nonatomic, readonly) NSString *romaji;
@property (readonly) NSUInteger tagID;
@property (readonly) TKKanaType kanaType;

//Initialize and set the tagId and kanatype. Call the setKanaProperties.
-(id) initWithKanaID:(NSUInteger)aTagID kanaType:(TKKanaType) aKanaType;
/* Use the item tag and set correct syllable and pronanucation for the detaillayer.
 * The kana and romaji are both loaded from a plist which is setup to work with the 
 * tagID. */
-(void) setKanaProperties;
// Check if kana is diatric.
-(BOOL) isDiatric;
@end
