//
//  DSSentenceModel.h
//  destiny
//
//  Created by Fengur on 2016/11/15.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DefaultSentence @"Stay hungry, Stay foolish"
#define DefaultSentence1 @"Slow Down Your Heart"
#define DefaultAutor @""

@interface DSSentenceModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *mrname;

@end
