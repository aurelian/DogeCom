//
//  AppDelegate.h
//  DogeCom
//
//  Created by Aurelian Oancea on 26/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import <Cocoa/Cocoa.h>

#import "DogeMonitor.h"
#import "SchnitzelManager.h"
#import "DogePreferencesController.h"

@class DogePreferencesController;

@interface AppDelegate : NSObject <NSApplicationDelegate>
{
    IBOutlet NSMenu *statusMenu;
    NSStatusItem *statusItem;
    DogePreferencesController *preferencesController;
}

- (IBAction)doPreferences:(id)sender;
- (IBAction)doAbout:(id)sender;
- (IBAction)doQuit:(id)sender;

@end
