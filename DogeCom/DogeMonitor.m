//
//  DogeMonitor.m
//  DogeCom
//
//  Created by Aurelian Oancea on 26/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import "DogeMonitor.h"

@interface DogeMonitor()

@property FSEventStreamRef stream;

void fsEventCallback(ConstFSEventStreamRef streamRef,
                     void *clientCallBackInfo,
                     size_t numEvents,
                     void *eventPaths,
                     const FSEventStreamEventFlags eventFlags[],
                     const FSEventStreamEventId eventIds[]);

@end

@implementation DogeMonitor

@synthesize manager = _manager;
@synthesize stream;

- (id) initWithManager:(SchnitzelManager *)aManager
{
    if (self = [super init])
    {
        _manager = aManager;
    }
    return self;
}

- (void) startMonitoring
{
    FSEventStreamContext reference = {0, (__bridge_retained void *)self, NULL, NULL, NULL};

    // TODO: check if stream is NULL, if is not, stopMonitorig and redo.
    stream = FSEventStreamCreate(NULL,
                                 &fsEventCallback,
                                 &reference,
                                 (__bridge CFArrayRef)[self.manager tracksPaths],
                                 kFSEventStreamEventIdSinceNow,
                                 3.0,
                                 kFSEventStreamCreateFlagFileEvents);

    FSEventStreamScheduleWithRunLoop(stream, CFRunLoopGetCurrent(), kCFRunLoopDefaultMode);
    FSEventStreamStart(stream);
}

void fsEventCallback(ConstFSEventStreamRef streamRef,
                     void *clientCallBackInfo,
                     size_t numEvents,
                     void *eventPaths,
                     const FSEventStreamEventFlags eventFlags[],
                     const FSEventStreamEventId eventIds[])
{
    char **paths = eventPaths;
    DogeMonitor *monitor= (__bridge DogeMonitor *)(clientCallBackInfo);

    for(int i = 0; i < numEvents; i++)
    {
        if(eventFlags[i] & kFSEventStreamEventFlagItemIsFile)
        {
            if(eventFlags[i]  & kFSEventStreamEventFlagItemCreated)
            {
                // converts char * paths[i] to a path suitable for NSURL
                NSURL *file = [NSURL fileURLWithPath:[[NSString stringWithFormat:@"%s", paths[i]] stringByExpandingTildeInPath]];
                NSLog(@"--> created: %@", file);
                [monitor.manager trackCreated:file];
            }
        }
    }
}

@end
