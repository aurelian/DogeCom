//
//  DogeDevice.h
//  DogeCom
//
//  Created by Aurelian Oancea on 26/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DogeDevice : NSObject

@property NSString *identifier;
@property NSURL    *baseURL;
@property NSURL    *tracksURL;

-(id) initFromBaseURL:(NSURL *)theBaseURL;
- (NSString *)description;

@end
