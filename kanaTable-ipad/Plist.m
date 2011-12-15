//
//  Settings.m
//  Madwife Proto
//
//  Created by Alexander Alemayhu on 18.05.11.
//  Copyright 2011 FLEXNOR. All rights reserved.
//

#import "Plist.h"

@implementation Plist

-(id) init
{
    
	if( (self=[super init])) {
    }
	return self;
}


- (NSDictionary *) readPlist:(NSString *)fileName{
    
    NSString *errorDesc = nil; 
    NSPropertyListFormat format; 
    NSString *plistPath; 
    
    plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *dict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML 
                                                                          mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                                                                                    format:&format errorDescription:&errorDesc];
    if (!dict)
        NSLog(@"Error reading plist: %@", errorDesc);
    
    return dict;
}

@end