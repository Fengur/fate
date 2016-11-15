//
//  DSJokeCell.h
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DSJokeModel;
@interface DSJokeCell : UITableViewCell


- (CGFloat)getCellHeight;

- (void)setJokeCellDetailWithModel:(DSJokeModel *)jokeModel;

@end
