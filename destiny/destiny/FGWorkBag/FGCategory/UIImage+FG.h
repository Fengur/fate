//
//  UIImage+FG.h
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, FGIconImageSize) {
    FGIconImageSize29,
    FGIconImageSize40,
    FGIconImageSize60
};


@interface UIImage (FG)

/**
 *  返回的图片拉伸不变形
 */
+ (UIImage *)resizableImage:(NSString *)imageName;

/**
 *  将颜色合成图片
 */
+ (UIImage *)imageWithColor:(UIColor *)color;

/**
 *  图片截取处理
 */
+ (UIImage *)rotateImage:(UIImage *)image;

/**
 *  view转化成image
 */
+(UIImage *) imageWithView:(UIView *)view;


/**
 *  返回LaunchImage
 */
+ (UIImage *)fg_getLaunchImage;

/**
 *  返回size尺寸的IconImage
 */
+ (UIImage *)fg_getIconImageWithSize:(FGIconImageSize)iconImageSize;

/**
 *  保存图片到Documents
 *
 *  @param image 要保存的图片对象
 *  @param name  保存的名字
 */
+ (void)saveImage:(UIImage *)image withName:(NSString *)name;
/**
 *  获取已保存的图片
 *
 *  @param name 图片的名字
 *
 *  @return 返回相应图片
 */
+ (UIImage *)getSavedImageWithName:(NSString *)name;
/**
 *  获取已经保存的图片的路径
 *
 *  @param name 图片的名字
 *
 *  @return 返回路径
 */
+ (NSString *)getImagePathWithImageName:(NSString *)name;

@end
