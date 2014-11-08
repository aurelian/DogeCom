//
//  SchnitzelManager.m
//  DogeCom
//
//  Created by Aurelian Oancea on 27/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import "SchnitzelManager.h"

@implementation SchnitzelManager

@synthesize devices = _devices;
@synthesize duplicateFileDestination = _duplicateFileDestination;
@synthesize fm      = _fm;

- (id) init
{
    if(self = [super init])
    {
        _fm      = [NSFileManager defaultManager];
        _devices = [NSMutableArray array];
        
        NSString *path= [[NSUserDefaults standardUserDefaults] stringForKey:@"DuplicateFileUrl"];
        _duplicateFileDestination = [NSURL URLWithString:path];
    }
    return self;
}

- (void) detectDevices
{
    NSError *error = nil;
    
    NSURL *basePath = [[_fm    URLForDirectory:NSApplicationSupportDirectory
                                      inDomain:NSUserDomainMask
                             appropriateForURL:nil
                                        create:NO
                                         error:&error]
                            URLByAppendingPathComponent:@"Garmin/GarminConnect"];
    
    // TODO: check for error
    // TODO: maybe check if basePath exists if dirEnumerator does not check
    NSDirectoryEnumerator *dirEnumerator = [_fm enumeratorAtURL:basePath
                                     includingPropertiesForKeys:@[ NSURLNameKey, NSURLIsDirectoryKey ]
                                                        options:NSDirectoryEnumerationSkipsHiddenFiles |  NSDirectoryEnumerationSkipsSubdirectoryDescendants
                                                   errorHandler:nil];
    
    for(NSURL *deviceURL in dirEnumerator)
    {
        NSNumber *isDirectory;
        
        [deviceURL getResourceValue:&isDirectory forKey:NSURLIsDirectoryKey error:&error];
        if([isDirectory boolValue])
        {
            DogeDevice *device = [[DogeDevice alloc] initFromBaseURL:deviceURL];            
            [_devices addObject:device];
        }
    }
}

-(void) syncExistingFiles
{
    
    for (int i = 0; i < _devices.count; i++)
    {
        // TODO: extract this to device?
        NSDirectoryEnumerator *tracks = [_fm enumeratorAtURL:[_devices[i] tracksURL] includingPropertiesForKeys:@[NSURLNameKey] options:NSDirectoryEnumerationSkipsHiddenFiles|NSDirectoryEnumerationSkipsSubdirectoryDescendants errorHandler:nil];
        
        for(NSURL *file in tracks)
        {
            [self copyFile:file];
        }
    }
}

/*
-(BOOL)cloudFileExists:(NSURL *)deviceFile
{
    return [_fm fileExistsAtPath:[[self cloudFileFromDeviceFile:deviceFile] path]];
}

-(NSURL *)cloudFileFromDeviceFile:(NSURL *)aFile
{
    return [_cloud URLByAppendingPathComponent:[aFile lastPathComponent]];
}
*/

// copy file from device if not already copied.
-(void) copyFile:(NSURL *)deviceFile
{
    
    // transforms: Garmin/Devices/.../foo.txt to Cloud/..../foo.txt
    NSURL * cloudFile = [_duplicateFileDestination URLByAppendingPathComponent:[deviceFile lastPathComponent]];
    
    // TODO: check if file is a valid track
    
    // TODO: see comment on fileExistsAtPath
    if(![_fm fileExistsAtPath:[cloudFile path]])
    {
        // TODO: check for error
        [_fm copyItemAtURL:deviceFile toURL:cloudFile error:nil];
        NSLog(@"+++> %@ -> %@", deviceFile, cloudFile);
    } else {
        NSLog(@"---> %@ -> %@", deviceFile, cloudFile);
    }
}

-(void) sendUserNotification:(NSURL *)deviceFile
{
    NSUserNotification *userNotification = [NSUserNotification new];
    userNotification.title = @"New Track Added";
    userNotification.subtitle = [deviceFile lastPathComponent];
    // userNotification.informativeText = [NSString stringWithFormat:@"DogeCom detected a new Garmin track: %@", deviceFile];
    userNotification.hasActionButton = NO;
    userNotification.contentImage = [NSImage imageNamed:@"doge"];

    NSUserNotificationCenter *center = [NSUserNotificationCenter defaultUserNotificationCenter];
    [center scheduleNotification:userNotification];
}

-(NSMutableArray *) tracksPaths
{
    NSMutableArray *paths = [NSMutableArray array];

    for (int i = 0; i < _devices.count; i++)
    {
        NSURL *url = [_devices[i] tracksURL];
        [paths addObject:url.path];
    }
    
    return paths;
}

@end
