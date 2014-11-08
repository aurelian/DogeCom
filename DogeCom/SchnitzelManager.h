//
//  SchnitzelManager.h
//  DogeCom
//
//  Created by Aurelian Oancea on 27/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "DogeDevice.h"

// This guy knows where the devices are and schizels

@interface SchnitzelManager : NSObject

@property NSMutableArray *devices;
@property NSURL          *duplicateFileDestination;
@property NSFileManager  *fm;

- (id) init;
- (void) detectDevices;
- (void) syncExistingFiles;

- (void) copyFile:(NSURL *)deviceFile;
- (void) sendUserNotification:(NSURL *)deviceFile;

- (NSMutableArray *) tracksPaths;

@end
