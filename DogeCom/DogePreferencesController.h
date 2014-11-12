//
//  DogePreferencesController.h
//  DogeCom
//
//  Created by Aurelian Oancea on 28/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import <Cocoa/Cocoa.h>

// TODO: dude... wtf, checkout NSUserDefaultsController LOL

// TODO: when copy is NO, change should be disabled.

@interface DogePreferencesController : NSWindowController {
    NSButton *sendNotificationCheckbox;
    NSButton *duplicateFileCheckbox;
    NSTextField *duplicateDestination;
}

@property IBOutlet NSButton *sendNotificationCheckbox;
@property IBOutlet NSButton *duplicateFileCheckbox;
@property IBOutlet NSTextField *duplicateDestination;

@property BOOL canChangeDuplicateFileDestination;

-(IBAction) selectDupicateDestination:(id)sender;
-(IBAction) toggleSendNotification: (id)sender;
-(IBAction) toggleDuplicateFile: (id)sender;

@end