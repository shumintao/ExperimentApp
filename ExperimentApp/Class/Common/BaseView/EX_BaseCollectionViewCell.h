//
//  EX_BaseCollectionViewCell.h
//  ExperimentApp
//
//  Created by GDBank on 2017/10/23.
//  Copyright © 2017年 com.GDBank.Company. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EX_BaseCollectionViewCellProtocol.h"
#import "EXBaseViewActionProtocol.h"

@interface EX_BaseCollectionViewCell : UICollectionViewCell<EX_BaseCollectionViewCellProtocol,EXBaseViewActionProtocol>
@property(nonatomic,weak)id<EX_BaseTableViewCellActionProtocol>delegate;
@property (nonatomic,weak) id <EXBaseViewActionProtocol> xm_delegate;
@end
