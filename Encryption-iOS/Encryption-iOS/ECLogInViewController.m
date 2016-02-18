//
//  ViewController.m
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECLogInViewController.h"
#import "ECNotesTableViewController.h"

@interface ECLogInViewController () <UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *centerYConstraint;
@property (weak, nonatomic) IBOutlet UIButton *enterButton;
@property (assign, nonatomic) CGFloat centerYConstantValue;

@end

@implementation ECLogInViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.centerYConstantValue = self.centerYConstraint.constant;
    self.enterButton.enabled = NO;
    self.passwordField.delegate = self;
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Keyboard manipulation

- (IBAction)dismissKeyboard:(id)sender {
    [self.passwordField resignFirstResponder];
}

- (void)keyboardWasShown:(NSNotification *)notification {
    NSDictionary *userInfo = notification.userInfo;
    CGSize kbSize = [[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    self.centerYConstraint.constant =- kbSize.height /2;
}

- (void)keyboardWillBeHidden:(NSNotification *)notification {
    self.centerYConstraint.constant = self.centerYConstantValue;
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [self.passwordField resignFirstResponder];
    return YES;
}

- (IBAction)editingChanged:(UITextField *)sender {
    if (sender.text.length > 0) {
        self.enterButton.enabled = YES;
    }
}

#pragma mark - Navigation

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
        if ([segue.identifier isEqualToString:@"showNotes"]) {
            UINavigationController *navController = [segue destinationViewController];
            ECNotesTableViewController *notesTable = navController.viewControllers[0];
            notesTable.key = self.passwordField.text;
    }
}

@end
