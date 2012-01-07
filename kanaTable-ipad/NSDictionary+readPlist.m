//
//  NSDictionary+readPlist.m
//  kanaTable-ipad
//
//  Created by Alexander Alemayhu on 07.01.12.
//  Copyright (c) 2012 Flexnor. All rights reserved.
//

#import "NSDictionary+readPlist.h"
#import "ccMacros.h"

@implementation NSDictionary (readPlist)

+(NSDictionary *) readPlist:(NSString *)fileName{
    
    NSString *errorDesc = nil; 
    NSPropertyListFormat format; 
    NSString *plistPath; 
    
    plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *dict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML 
                                                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                                                                                    format:&format errorDescription:&errorDesc];
    if (!dict)
        CCLOG(@"Error reading plist: %@", errorDesc);
    
    return dict;
}

@end
