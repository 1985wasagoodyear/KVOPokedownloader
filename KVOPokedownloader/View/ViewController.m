//
//  ViewController.m
//  KVOPokedownloader
//
//  Created by K Y on 11/7/19.
//  Copyright © 2019 K Y. All rights reserved.
//

#import "ViewController.h"
#import "PokeViewModel.h"
#import "PokemonCollectionViewCell.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UICollectionView *collectionView;
@property (nonatomic, strong) PokeViewModel *vm;

@end

@interface ViewController (CollectionView) <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // setup collectionView
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    UINib *nib = [UINib nibWithNibName:@"PokemonCollectionViewCell" bundle:nil];
    [_collectionView registerNib:nib forCellWithReuseIdentifier:@"PokemonCollectionViewCell"];
    
    // setup VM
    self.vm = [[PokeViewModel alloc] init];
    [self.vm bindWithBlock:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
    }];
    [self.vm download];
}

@end

@implementation ViewController (CollectionView)

// MARK: - UICollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.vm.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    PokemonCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"PokemonCollectionViewCell" forIndexPath:indexPath];
    NSInteger row = indexPath.row;
    
    cell.nameLabel.text = [self.vm nameAtIndex:row];
    cell.imageView.image = nil;
    [self.vm imageAtIndex:row withCompletion:^(NSData *data) {
        dispatch_async(dispatch_get_main_queue(), ^{
            UIImage *image = [UIImage imageWithData:data];
            cell.imageView.image = image;
        });
    }];
    
    return cell;
}

// MARK: - UICollectionView Delegate Flow Layout

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    CGFloat width = collectionView.frame.size.width / 3.0;
    return CGSizeMake(width, width);
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0.0;
}


@end

