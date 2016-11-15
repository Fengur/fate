//
//  DSTravelCell.h
//  destiny
//
//  Created by Fengur on 2016/11/15.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <UIKit/UIKit.h>
@class DSTravelModel;
@interface DSTravelCell : UITableViewCell

@property (nonatomic, strong) UIImageView *headImage;

- (CGFloat)getCellHeight;

- (void)setTravelCellDetailWithModel:(DSTravelModel *)travelModel;

@end
