//
//  KTKanaDiatric.h
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 26.12.11.
//  Copyright (c) 2011 Flexnor. All rights reserved.
//

#ifndef kanaTable_ipad_KTKanaDiatric_h
#define kanaTable_ipad_KTKanaDiatric_h

@class KTKana, CCMenuItemLabel;
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

#endif
