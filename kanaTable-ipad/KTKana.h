//
//  Kana.h
//  kanaTable
//
//  Created by Alexander Alemayhu on 19.09.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "KTKanaDiatric.h"
#import "KTGlobal.h"
#import "cocos2d.h"

/*	
 *
 *  KTKana
 *  This object is used for retriveing the strings that are used when displaying 
 *  labels. 
 *
 *      @kana
 *      kana is the japanese syllablel.
 * 
 *      @romaji
 *      romaji is the latin pronuciation of the syllablel.
 *
 *      @tagID
 *      The tagID is used for retriveing the kana and romaji from a plist.
 *
 *      @kanaType
 *      The enum kanaType is used to distungish between the two basic 
 *      japanese(hiragana, katakana) syllabaries.
 */

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
