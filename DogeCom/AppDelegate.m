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
        preferencesController = [[DogePreferencesController alloc] initWithWindowNibName:@"Preferences"];
    }
    
    [preferencesController showWindow:self];
    
    [[preferencesController window] orderFrontRegardless];
    
    // somehow I does not have focus here
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
    [statusItem setImage:[NSImage imageNamed:@"doge"]];
    [statusItem setHighlightMode:YES];
    
    // TODO - read from plist. via NSBundle.
    NSDictionary *defaults = [NSDictionary dictionaryWithObjects:[NSArray arrayWithObjects:@"NO", @"NO", nil]
                                                         forKeys:[NSArray arrayWithObjects:@"SendNotification", @"DuplicateFile", nil]];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaults];
    
    SchnitzelManager *schnitzel = [[SchnitzelManager alloc] init];
    [schnitzel detectDevices];
    [schnitzel syncExistingFiles];
    
    DogeMonitor * monitor = [[DogeMonitor alloc] initWithManager:schnitzel];
    [monitor startMonitoring];
    
}

@end
