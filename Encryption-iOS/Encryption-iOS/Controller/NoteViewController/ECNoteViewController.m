//
//  ECNoteViewController.m
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECNoteViewController.h"
#import "ECNote.h"
#import "ECNoteManager.h"

@interface ECNoteViewController ()

@property (weak, nonatomic) IBOutlet UITextView *noteTextView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topLayout;
@property (assign, nonatomic) CGFloat layoutConstant;
@property (strong, nonatomic) ECNoteManager *manager;

@end

@implementation ECNoteViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.noteTextView.text = self.currentNote.noteText;
    if (!self.noteTextView.text.length) {
        [self.noteTextView becomeFirstResponder];
    }
    self.layoutConstant = self.topLayout.constant;
    self.manager = [ECNoteManager sharedInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:YES];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWasShown:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillBeHidden:)
                                                 name:UIKeyboardWillHideNotification
                                               object:nil];
}

-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:YES];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillShowNotification
                                                  object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self
                                                    name:UIKeyboardWillHideNotification
                                                  object:nil];
}

- (void)keyboardWasShown:(NSNotification*)aNotification {
    NSDictionary* info = [aNotification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    UIEdgeInsets contentInsets = UIEdgeInsetsMake(0.0, 0.0, kbSize.height, 0.0);
    self.noteTextView.contentInset = contentInsets;
    self.noteTextView.scrollIndicatorInsets = contentInsets;
    self.topLayout.constant = kbSize.height /4;
}

- (void)keyboardWillBeHidden:(NSNotification*)aNotification {
    UIEdgeInsets contentInsets = UIEdgeInsetsZero;
    self.noteTextView.contentInset = contentInsets;
    self.noteTextView.scrollIndicatorInsets = contentInsets;
    self.topLayout.constant = self.layoutConstant;
}

- (IBAction)SaveButtonPressed:(id)sender {
    if (!self.delegate) {
        self.currentNote.noteText = self.noteTextView.text;
    } else {
        ECNote *newNote = [ECNote new];
        newNote.noteText = self.noteTextView.text;
        [self.manager saveNote:newNote usingKey:self.key];
        [self.delegate detailsViewController:self saveNote:newNote];
    }
    [self.navigationController popViewControllerAnimated:YES];
}

@end
