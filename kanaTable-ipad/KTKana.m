//
//  Kana.m
//  kanaTable
//
//  Created by Alexander Alemayhu on 19.09.11.
//  Copyright 2011 Flexnor. All rights reserved.
//

#import "KTKana.h"
#import "Plist.h"

@implementation KTKana

@synthesize kana, romaji, tagID, kanaType;

-(id) initWithKanaID:(NSUInteger)aTagID kanaType:(TKKanaType)aKanaType{
    
    if (self = [super init]) {
        tagID = aTagID;
        kanaType = aKanaType;
        [self setKanaProperties];
    }
    
    return self;
}

-(void) setKanaProperties{
    
    NSString *kanaPlist = @"ddd";
    NSString *romajiPlist = @"romaji";
    
    if (kanaType == HIRAGANA)
        kanaPlist = @"hiragana";
    else if (kanaType == KATAKANA)
        kanaPlist = @"katakana";
    
    Plist *plist = [[Plist alloc] init];
    
    NSDictionary *kanaDict = [[NSDictionary alloc] initWithDictionary:[plist readPlist:kanaPlist]];
    NSDictionary *romajiDict = [[NSDictionary  alloc ] initWithDictionary:[plist readPlist:romajiPlist]];
    [plist release];
    
    NSString *kanaKey = [NSString stringWithFormat:@"%d", tagID];    
    kana = [[kanaDict objectForKey:kanaKey] copy];
    [kanaDict release];
    
    romaji = [[romajiDict objectForKey:kanaKey] copy];
    [romajiDict release];
}


-(BOOL) isDiatric{
    
    if (
        ([romaji isEqualToString:@"ka"])  || ([romaji isEqualToString:@"ki"])  ||
        ([romaji isEqualToString:@"ku"])  || ([romaji isEqualToString:@"ke"])  ||
        ([romaji isEqualToString:@"ko"])  || ([romaji isEqualToString:@"sa"])  || 
        ([romaji isEqualToString:@"shi"]) || ([romaji isEqualToString:@"su"])  || 
        ([romaji isEqualToString:@"se"])  || ([romaji isEqualToString:@"so"])  || 
        ([romaji isEqualToString:@"ta"])  || ([romaji isEqualToString:@"chi"]) ||
        ([romaji isEqualToString:@"tsu"]) || ([romaji isEqualToString:@"te"])  || 
        ([romaji isEqualToString:@"to"])  || ([romaji isEqualToString:@"ha"])  ||
        ([romaji isEqualToString:@"hi"])  || ([romaji isEqualToString:@"fu"])  ||
        ([romaji isEqualToString:@"he"])  || ([romaji isEqualToString:@"ho"])  || 
        ([romaji isEqualToString:@"ni"])  || ([romaji isEqualToString:@"mi"])  || 
        ([romaji isEqualToString:@"ri"])
        ){
        return YES;
    }
    
    return NO;
}


#pragma mark -

-(void) dealloc{
    
    [kana release];
    [romaji release];
    [super dealloc];
}

@end
