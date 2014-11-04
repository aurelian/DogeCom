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

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    
    return self;
}

/*
- (void)windowDidLoad {
    NSLog(@"---> window loaded");
    
    [super windowDidLoad];
}
*/

-(void) awakeFromNib {
    NSLog(@"---> awake from nib");
    
    [self.sendNotificationCheckbox
            setState:[[NSUserDefaults standardUserDefaults] boolForKey:@"SendNotification" ]];
    
    [self.duplicateFileCheckbox
            setState:[[NSUserDefaults standardUserDefaults] boolForKey:@"DuplicateFile" ]];
}

-(IBAction) toggleSendNotification:(id)sender {
    [[NSUserDefaults standardUserDefaults]
            setBool:[self.sendNotificationCheckbox state] forKey:@"SendNotification" ];
}

-(IBAction) toggleDuplicateFile:(id)sender {
    [[NSUserDefaults standardUserDefaults]
     setBool:[self.duplicateFileCheckbox state] forKey:@"DuplicateFile" ];
}

@end
