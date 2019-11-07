//
//  Pokemon.m
//  KVOPokedownloader
//
//  Created by K Y on 11/7/19.
//  Copyright © 2019 K Y. All rights reserved.
//

#import "Pokemon.h"

@interface Pokemon ()

@property (nonatomic, strong) NSString *front_default;

@end

@implementation Pokemon

- (instancetype)initWithData:(NSData *)data {
    self = [super init];
    if (self) {
        // 1. transform data into a dictionary
        NSDictionary *dataDict = [NSJSONSerialization JSONObjectWithData:data
                                                                 options:NSJSONReadingAllowFragments
                                                                   error:nil];
        
        // 2. go through each key
        // if I have that key, I can build it
        // if I don't, I don't, and I can ignore it
        [self fillWithDict:dataDict];
    }
    return self;

}

- (NSString *)imageLink {
    return self.front_default;
}

- (void)setImageLink:(NSString *)imageLink {
    self.front_default = imageLink;
}

- (void)fillWithDict:(NSDictionary *)dataDict {
    NSArray *keys = [dataDict allKeys];
    for (NSString *key in keys) {
        if ([dataDict[key] isKindOfClass:[NSDictionary class]]) {
            [self fillWithDict: dataDict[key]];
            continue;
        }
        NSString *setterKey = key;
        SEL selector = NSSelectorFromString(setterKey);
        if ([self respondsToSelector:selector]) {
            [self setValue:dataDict[key] forKey:setterKey];
        }
    }
}

@end
