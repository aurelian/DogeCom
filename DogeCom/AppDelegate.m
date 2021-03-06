//
//  AppDelegate.m
//  DogeCom
//
//  Created by Aurelian Oancea on 26/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import "AppDelegate.h"

@implementation AppDelegate

- (IBAction)doPreferences:(id)sender
{
    
    if (!preferencesController)
    {
        preferencesController = [[DogePreferencesController alloc] initWithManager:schnitzel];
    }
    [preferencesController showWindow:self];
    [[preferencesController window] orderFrontRegardless];
    
    // somehow I does not have focus here and this doesn't help
    // [[preferencesController window] makeKeyAndOrderFront:self];
    
}

- (IBAction)doAbout:(id)sender
{
    NSLog(@"about.");
}

- (IBAction)doQuit:(id)sender
{
    [NSApp terminate: sender];
}

- (void) applicationDidFinishLaunching:(NSNotification *)aNotification
{
    statusItem = [[NSStatusBar systemStatusBar] statusItemWithLength:NSSquareStatusItemLength];
    [statusItem setMenu:statusMenu];
    
    NSImage *image = [NSImage imageNamed:@"doge"];
    [image setTemplate:YES];
    
    [statusItem setImage:image];
    [statusItem setHighlightMode:YES];
    
    // TODO - maybe read from plist. via NSBundle.
    NSDictionary *defaults = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"YES", @"NO", [[NSURL fileURLWithPath:NSHomeDirectory()] path], nil]
                                                         forKeys:[NSArray arrayWithObjects:@"SendNotification", @"DuplicateFile", @"DuplicateFileUrl", nil]];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    
    schnitzel = [[SchnitzelManager alloc] init];
    [schnitzel detectDevices];
    
    DogeMonitor * monitor = [[DogeMonitor alloc] initWithManager:schnitzel];
    [monitor startMonitoring];
    
}

@end
