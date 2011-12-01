//
//  Settings.m
//  Madwife Proto
//
//  Created by Alexander Alemayhu on 18.05.11.
//  Copyright 2011 FLEXNOR. All rights reserved.
//

#import "Plist.h"
#import "ccMacros.h"

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
    NSString *rootPath; 
    
    rootPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    plistPath = [rootPath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist", fileName]]; 
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:plistPath]) {
        CCLOG(@"Error plist does not exist: %@", plistPath);
        plistPath = [[NSBundle mainBundle] pathForResource:fileName ofType:@"plist"];
    }
    
    NSData *plistXML = [[NSFileManager defaultManager] contentsAtPath:plistPath];
    NSDictionary *dict = (NSDictionary *)[NSPropertyListSerialization propertyListFromData:plistXML 
                                                            mutabilityOption:NSPropertyListMutableContainersAndLeaves 
                                                                      format:&format errorDescription:&errorDesc];
    if (!dict)
        CCLOG(@"Error reading plist: %@", errorDesc);
    
    return dict;
}

@end
