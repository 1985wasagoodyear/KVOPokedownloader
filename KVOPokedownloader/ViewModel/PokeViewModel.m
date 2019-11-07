//
//  PokeViewModel.m
//  KVOPokedownloader
//
//  Created by K Y on 11/7/19.
//  Copyright © 2019 K Y. All rights reserved.
//

#import "PokeViewModel.h"
#import "Pokemon.h"
#import "NetworkOperation.h"

@interface PokeViewModel ()

@property (nonatomic, strong) NSArray<Pokemon *> *pokemon;
@property (nonatomic, strong) VoidBlock updateBlock;

@property (nonatomic, strong) NSURLSession *session;
@property (nonatomic, strong) NSLock *lock;

@end

@implementation PokeViewModel

/// MARK: - Initializer

- (instancetype)init {
    self = [super init];
    if (self) {
        _session = [NSURLSession sessionWithConfiguration:NSURLSessionConfiguration.defaultSessionConfiguration];
        _pokemon = [[NSArray alloc] init];
        _lock = [[NSLock alloc] init];
    }
    return self;
}

- (NSInteger)count {
    return self.pokemon.count;
}

// MARK: - Data-binding

- (void)bindWithBlock:(VoidBlock)block {
    self.updateBlock = block;
    [self addObserver:self
           forKeyPath:@"pokemon"
              options:NSKeyValueObservingOptionNew
              context:nil];
}

- (void)bindWithBlockAndFire:(VoidBlock)block {
    self.updateBlock = block;
    block();
    [self addObserver:self
           forKeyPath:@"pokemon"
              options:NSKeyValueObservingOptionNew
              context:nil];
}

- (void)observeValueForKeyPath:(NSString *)keyPath
                      ofObject:(id)object
                        change:(NSDictionary *)change
                       context:(void *)context {
    if ([keyPath isEqualToString:@"pokemon"]) {
        NSArray *arr = object;
        NSLog(@"Array has %li", arr.count);
        self.updateBlock();
    } else {
        [super observeValueForKeyPath:keyPath
                             ofObject:object
                               change:change
                              context:context];
    }
}

- (void)unbind {
    [self removeObserver:self forKeyPath:@"pokemon"];
    self.updateBlock = NULL;
}

- (void)dealloc {
}

// MARK: - Networking

- (void)download {
   // dispatch_group_t group = dispatch_group_create();
  //  dispatch_group_enter(group);
    for (int i = 0; i < 10; i++) {
        NSURL *url = [self makeRandomURL];
        [self doDownloadWithURL:url];
                     //  andGroup:group
                    // andResults:self.pokemon];
     }
    /*
    dispatch_group_notify(group, dispatch_get_main_queue(), ^{
        self.pokemon = results;
        NSLog(@"%@", self.pokemon);
    });
     */
}

- (void)doDownloadWithURL:(NSURL *)url {
               //  andGroup:(dispatch_group_t)group
              // andResults:(NSArray<Pokemon *> *)results {
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        Pokemon *pokemon = [[Pokemon alloc] initWithData:data];
        //NSLog(@"Name is: %@", pokemon.name);
        //NSLog(@"ImageLink is: %@", pokemon.imageLink);
        [self.lock lock];
        self.pokemon = [self.pokemon arrayByAddingObject:pokemon];
        [self.lock unlock];
        //dispatch_group_leave(group);
    }];
    [task resume];
}

- (NetworkOperation *)makeOperationWithURL:(NSURL *)url
                                  andGroup:(dispatch_group_t)group
                                andResults:(NSMutableArray<Pokemon *> *)results {
    return [[NetworkOperation alloc] init:_session url:url method:@"GET" completion:^(NSData *data, NSURLResponse *resp, NSError *err) {
        Pokemon *pokemon = [[Pokemon alloc] initWithData:data];
        [results addObject:pokemon];
        dispatch_group_leave(group);
    }];
}

- (NSURL *)makeRandomURL {
    long rLong = arc4random_uniform(151);
    NSString *urlStr = [NSString stringWithFormat:@"https://pokeapi.co/api/v2/pokemon/%li", rLong];
    return [NSURL URLWithString:urlStr];
}

- (NSString *)nameAtIndex:(NSInteger)index {
    return self.pokemon[index].name;
}

- (void)imageAtIndex:(NSInteger)index
      withCompletion:(ImageBlock)completion {
    NSString *urlString = self.pokemon[index].imageLink;
    NSURL *url = [NSURL URLWithString:urlString];
    NSURLSessionDataTask *task = [self.session dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        completion(data);
    }];
    [task resume];
}


@end
