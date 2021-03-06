//
//  SchnitzelManager.m
//  DogeCom
//
//  Created by Aurelian Oancea on 27/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import "SchnitzelManager.h"

// TODO NSError stuff should do some UI level enterprise stuff

@implementation SchnitzelManager

@synthesize devices = _devices;
@synthesize fm      = _fm;

- (id) init
{
    if(self = [super init])
    {
        _fm      = [NSFileManager defaultManager];
        _devices = [NSMutableArray array];
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

// this is called by monitor when a new file is created.
-(void) trackCreated:(NSURL *)trackFile
{
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"SendNotification"]) {
        [self sendUserNotification:trackFile];
    }
    if([[NSUserDefaults standardUserDefaults] boolForKey:@"DuplicateFile"]) {
        [self copyFile:trackFile];
    }
}

// copy file from device if not already copied.
-(void) copyFile:(NSURL *)deviceFile
{

    // transforms: Garmin/Devices/.../foo.txt to Cloud/..../foo.txt
    NSString *path    = [[NSUserDefaults standardUserDefaults] stringForKey:@"DuplicateFileUrl"];
    
    NSURL *cloudFile = [[NSURL fileURLWithPath:path isDirectory:true] URLByAppendingPathComponent:[deviceFile lastPathComponent]];
    
    // TODO: check if file is a valid track

    // TODO: see comment on fileExistsAtPath
    if(![_fm fileExistsAtPath:[cloudFile path]])
    {
        NSError *error = nil;
        [_fm copyItemAtURL:deviceFile
                     toURL:cloudFile
                     error:&error];
        if(error != nil) {
            NSLog(@"[MEGA FAIL] copy %@ to %@\tfailed with %@", deviceFile, cloudFile, error);
        } else {
           NSLog(@"+++> %@ -> %@", deviceFile, cloudFile);
        }
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
