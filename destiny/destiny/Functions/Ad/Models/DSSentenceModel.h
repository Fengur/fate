//
//  DSSentenceModel.h
//  destiny
//
//  Created by Fengur on 2016/11/15.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <Foundation/Foundation.h>

#define DefaultSentence @"不是我以天下人为猪狗，我就是猪狗"
#define DefaultAutor @"江南——《九州缥缈录》"

@interface DSSentenceModel : NSObject

@property (nonatomic, copy) NSString *content;
@property (nonatomic, copy) NSString *mrname;

@end
