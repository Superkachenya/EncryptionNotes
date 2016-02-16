//
//  ECEncryptor.h
//  Encryption-iOS
//
//  Created by Danil on 16.02.16.
//  Copyright © 2016 Cleveroad. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ECEncryptor : NSObject

+ (NSString *)encryptMe:(NSString *)string withKey:(NSString *)key;

@end
