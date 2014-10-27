//
//  DogeMonitor.h
//  DogeCom
//
//  Created by Aurelian Oancea on 26/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#include <CoreServices/CoreServices.h>

#import <Foundation/Foundation.h>
#import "SchnitzelManager.h"

@interface DogeMonitor : NSObject

@property SchnitzelManager *manager;

- (id) initWithManager:(SchnitzelManager *)aManager;
- (void) startMonitoring;

@end
