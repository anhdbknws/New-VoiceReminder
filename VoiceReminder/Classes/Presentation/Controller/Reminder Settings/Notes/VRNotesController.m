//
//  VRNotesController.m
//  VoiceReminder
//
//  Created by GemCompany on 6/2/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRNotesController.h"

@interface VRNotesController ()<UITextViewDelegate>

@end

@implementation VRNotesController
- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Notes";
        self.view.backgroundColor = [UIColor colorWithRed:238/255.0 green:237/255.0 blue:242/255.0 alpha:1];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configTextview];
    [self leftNavigationItem:nil andTitle:@"Back" orImage:nil];
    [self rightNavigationItem:@selector(doneAction:) andTitle:@"Done" orImage:nil];
}

- (void)configTextview {
    [self.textViewNotes becomeFirstResponder];
    self.textViewNotes.delegate = self;
    self.textViewNotes.text = self.notesValue;
}

#pragma mark - actions
- (void)doneAction:(id)sender{
    [self.view endEditing:YES];
    
    if (self.doneNotesCompleted) {
        self.doneNotesCompleted(self.textViewNotes.text);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark - textview delegate

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text {
    // dismiss keyboard
    if([text isEqualToString:@"\n"]) {
        [textView resignFirstResponder];
        return NO;
    }
    
    return YES;
}

#pragma mark - memory management

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)dealloc {
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
