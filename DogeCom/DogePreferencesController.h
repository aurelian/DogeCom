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
}

@property IBOutlet NSButton *sendNotificationCheckbox;

-(IBAction) toggleSendNotification: (id)sender;

@end