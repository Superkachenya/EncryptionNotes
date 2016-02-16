//
//  ECNote.h
//  Encryption-iOS
//
//  Created by Danil on 12.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECNote : NSObject //<NSCoding>

@property (strong, nonatomic) NSDate *creationDate;
@property (strong, nonatomic) NSString *noteText;

@end
