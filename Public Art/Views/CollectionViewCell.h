//
//  CollectionViewCell.h
//  Public Art
//
//  Created by Евгений on 03/10/2018.
//  Copyright © 2018 Триада. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Artefact.h"
#import "LabelSizeHelper.h"

NS_ASSUME_NONNULL_BEGIN

@interface CollectionViewCell : UICollectionViewCell

- (void)configureCellWithArtefact:(Artefact *)artefact;

@end

NS_ASSUME_NONNULL_END
