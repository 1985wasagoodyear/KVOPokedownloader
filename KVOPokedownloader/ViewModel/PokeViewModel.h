//
//  PokeViewModel.h
//  KVOPokedownloader
//
//  Created by K Y on 11/7/19.
//  Copyright © 2019 K Y. All rights reserved.
//

#import <Foundation/Foundation.h>

// typealias VoidBlock = ()->Void
typedef void(^VoidBlock)(void);
typedef void(^ImageBlock)(NSData *_Nullable);

NS_ASSUME_NONNULL_BEGIN

@interface PokeViewModel : NSObject

@property (readonly) NSInteger count;

- (void)bindWithBlock:(VoidBlock)block;
- (void)bindWithBlockAndFire:(VoidBlock)block;
- (void)unbind;

- (void)download;

- (NSString *)nameAtIndex:(NSInteger)index;
- (void)imageAtIndex:(NSInteger)index withCompletion:(ImageBlock)completion;

@end

NS_ASSUME_NONNULL_END
