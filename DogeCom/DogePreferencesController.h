//
//  DogePreferencesController.h
//  DogeCom
//
//  Created by Aurelian Oancea on 28/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "SchnitzelManager.h"

// TODO: dude... wtf, checkout NSUserDefaultsController LOL
@interface DogePreferencesController : NSWindowController {
    NSButton *sendNotificationCheckbox;
    NSButton *duplicateFileCheckbox;
    NSTextField *duplicateDestination;
}

-(id)initWithManager:(SchnitzelManager *)aManager;

@property IBOutlet NSButton *sendNotificationCheckbox;
@property IBOutlet NSButton *duplicateFileCheckbox;
@property IBOutlet NSTextField *duplicateDestination;
// TODO -- rename to duplicateFileEnabled
@property BOOL canChangeDuplicateFileDestination;

@property SchnitzelManager * manager;

-(IBAction) selectDupicateDestination:(id)sender;
-(IBAction) toggleSendNotification: (id)sender;
-(IBAction) toggleDuplicateFile: (id)sender;
-(IBAction) syncExistingFiles: (id)sender;

@end
