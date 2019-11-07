//
//  PokemonCollectionViewCell.h
//  KVOPokedownloader
//
//  Created by K Y on 11/7/19.
//  Copyright © 2019 K Y. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokemonCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

NS_ASSUME_NONNULL_END
