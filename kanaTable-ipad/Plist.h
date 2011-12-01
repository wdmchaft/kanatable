//
//  Settings.h
//  Madwife Proto
//
//  Created by Alexander Alemayhu on 18.05.11.
//  Copyright 2011 FLEXNOR. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Plist : NSObject {
    
}

-(NSDictionary *) readPlist:(NSString *) fileName;
@end
