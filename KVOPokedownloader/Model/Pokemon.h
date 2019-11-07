//
//  Pokemon.h
//  KVOPokedownloader
//
//  Created by K Y on 11/7/19.
//  Copyright © 2019 K Y. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Pokemon : NSObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *imageLink;

- (instancetype)initWithData:(NSData *)data;

@end

NS_ASSUME_NONNULL_END
