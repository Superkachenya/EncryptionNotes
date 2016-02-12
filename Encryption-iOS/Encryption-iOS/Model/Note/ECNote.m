//
//  ECNote.m
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECNote.h"

@interface ECNote ()

@property (strong, nonatomic, readwrite) NSDate *creationDate;

@end

@implementation ECNote

- (instancetype)init {
    if (self = [super init]) {
        NSDate *currentDate = [NSDate date];
        self.creationDate = currentDate;
    }
    return self;
}

@end
