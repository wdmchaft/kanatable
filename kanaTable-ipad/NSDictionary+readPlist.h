//
//  NSDictionary+readPlist.h
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 07.01.12.
//  Copyright (c) 2012 Flexnor. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (readPlist)
+(NSDictionary *) readPlist:(NSString *) fileName;
@end
