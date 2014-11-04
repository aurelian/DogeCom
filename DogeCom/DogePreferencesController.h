//
//  DogePreferencesController.h
//  DogeCom
//
//  Created by Aurelian Oancea on 28/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface DogePreferencesController : NSWindowController {
    NSButton *sendNotificationCheckbox;
    NSButton *duplicateFileCheckbox;
}

@property IBOutlet NSButton *sendNotificationCheckbox;
@property IBOutlet NSButton *duplicateFileCheckbox; // cannot use copyFileCheckbox :D

-(IBAction) toggleSendNotification: (id)sender;
-(IBAction) toggleDuplicateFile: (id)sender;

@end