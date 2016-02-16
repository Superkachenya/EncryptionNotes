//
//  ECNote.m
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import "ECNote.h"

@implementation ECNote

- (instancetype)init {
    if (self = [super init]) {
        _creationDate = [NSDate date];
    }
    return self;
}

@end
