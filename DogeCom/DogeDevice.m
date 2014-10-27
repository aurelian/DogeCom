//
//  DogeDevice.m
//  DogeCom
//
//  Created by Aurelian Oancea on 26/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import "DogeDevice.h"

@implementation DogeDevice

@synthesize baseURL = _baseURL;
@synthesize tracksURL = _tracksURL;
@synthesize identifier = _identifier;

-(id)initFromBaseURL:(NSURL *)theBaseURL
{

    if(self = [super init])
    {
        _baseURL    = theBaseURL;
        _tracksURL  = [_baseURL URLByAppendingPathComponent:@"Upload/FitnessHistory"];
        _identifier = [_baseURL.pathComponents lastObject];
        
        NSLog(@"%@", self);
    }
    return self;
}

- (NSString *)description
{
    return [NSString stringWithFormat: @"DogeDevice Reporting: {\n\tIdentifier: %@,\n\tTracks: %@\n}", _identifier, _tracksURL];
}

@end
