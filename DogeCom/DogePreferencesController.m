//
//  DogePreferencesController.m
//  DogeCom
//
//  Created by Aurelian Oancea on 28/10/14.
//  Copyright (c) 2014 Aurelian Oancea. All rights reserved.
//

#import "DogePreferencesController.h"

@implementation DogePreferencesController

@synthesize sendNotificationCheckbox;
@synthesize duplicateFileCheckbox;
@synthesize duplicateDestination;

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    
    return self;
}

-(void) awakeFromNib {
    NSLog(@"---> awake from nib");
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    
    [self.sendNotificationCheckbox setState:[defaults boolForKey:@"SendNotification"]];
    
    [self.duplicateFileCheckbox setState:[defaults boolForKey:@"DuplicateFile"]];
    
    // TODO -- remove percent encoding.
    [self.duplicateDestination setStringValue: [defaults stringForKey:@"DuplicateFileUrl"]];
}

-(IBAction) toggleSendNotification:(id)sender {
    [[NSUserDefaults standardUserDefaults]
            setBool:[self.sendNotificationCheckbox state] forKey:@"SendNotification"];
}

-(IBAction) toggleDuplicateFile:(id)sender {
    [[NSUserDefaults standardUserDefaults]
            setBool:[self.duplicateFileCheckbox state] forKey:@"DuplicateFile"];
}

-(IBAction) selectDupicateDestination:(id)sender {
    NSOpenPanel *panel = [NSOpenPanel openPanel];
    [panel setCanChooseFiles:NO];
    [panel setCanChooseDirectories:YES];
    [panel setCanCreateDirectories:YES];
    [panel setAllowsMultipleSelection:NO];
    [panel setPrompt:@"Select"];

    if ([panel runModal] == NSModalResponseOK) {
        [self.duplicateDestination setStringValue:[[panel URL] description]];
        NSLog(@"-- url: %@", [[panel URL] description]);
        [[NSUserDefaults standardUserDefaults] setValue:[[panel URL] description] forKey:@"DuplicateFileUrl"];
    }
}

@end
