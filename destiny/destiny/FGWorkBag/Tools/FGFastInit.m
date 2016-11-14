//
//  FGFastInit.m
//  yeoner
//
//  Created by 王智超 on 16/1/26.
//  Copyright © 2016年 Sheldon. All rights reserved.
//

#import "FGFastInit.h"

@implementation FGFastInit

+ (UITextField *)textFieldPlaceHolder:(NSString *)ph
                             fontSize:(CGFloat)size
                                frame:(CGRect)frame
                            alignment:(NSTextAlignment)align
                           leftString:(NSString *)leftString {
    UITextField *field = [[UITextField alloc] initWithFrame:frame];
    field.placeholder = ph;
    field.font = [UIFont systemFontOfSize:size];
    field.textAlignment = align;
    UILabel *textLabel = [[UILabel alloc] init];
    textLabel.textAlignment = NSTextAlignmentCenter;
    textLabel.textColor = [UIColor grayColor];
    textLabel.text = leftString;
    field.tintColor = [UIColor blackColor];
    textLabel.font = [UIFont systemFontOfSize:size - 1];
    if (leftString.length != 0) {
        textLabel.frame = CGRectMake(0, 0, frame.size.height + 50, frame.size.height);
        field.leftViewMode = UITextFieldViewModeAlways;
        field.leftView = textLabel;
    }
    field.backgroundColor = [UIColor whiteColor];
    return field;
}

+ (UIButton *)buttonWithTitle:(NSString *)title
                   titleColor:(UIColor *)titleC
                      bgColor:(UIColor *)bgC
                    imageName:(NSString *)imgName
                     fontSize:(CGFloat)fontSize;
{
    UIButton *imgBtn = [[UIButton alloc] init];
    [imgBtn setTitle:title forState:UIControlStateNormal];
    imgBtn.titleLabel.font = [UIFont systemFontOfSize:fontSize];
    [imgBtn setTitleColor:titleC forState:UIControlStateNormal];
    if (bgC) {
        imgBtn.backgroundColor = bgC;
    }
    [imgBtn setImage:[UIImage imageNamed:imgName] forState:UIControlStateNormal];
    imgBtn.layer.cornerRadius = 5;
    return imgBtn;
}

+ (UIView *)sigleLine:(CGRect)rect Color:(UIColor *)color {
    UIView *l1 = [[UIView alloc] initWithFrame:rect];
    l1.backgroundColor = color;
    return l1;
}
+ (UILabel *)labelWithTitle:(NSString *)title
                  textColor:(UIColor *)color
                       size:(CGFloat)size
                  alignment:(NSTextAlignment)aligenment
            backgroundColor:(UIColor *)bColor {
    UILabel *label = [[UILabel alloc] init];
    label.text = title;
    if (color) {
        label.textColor = color;
    } else {
        label.textColor = [UIColor blackColor];
    }

    label.font = [UIFont systemFontOfSize:size];
    label.textAlignment = aligenment;
    if (bColor) {
        label.backgroundColor = bColor;
    }
    return label;
}
+ (UIView *)navBarTitle:(NSString *)title {
    CGFloat view_w = 90.0, view_h = 20;
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, view_w, view_h)];
    label.font = NavFont(17.0);
    label.text = title;
    label.textAlignment = NSTextAlignmentCenter;
    label.textColor = [UIColor blackColor];
    return label;
}

+ (UIView *)navBarCenterView:(NSString *)imageName{
    CGFloat view_w = 20,view_h=20;
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, view_w, view_h)];
    imageView.contentMode = UIViewContentModeScaleToFill;
    imageView.clipsToBounds = YES;
    imageView.image = ImageOfName(imageName);
    return imageView;
}

+ (UIBarButtonItem *)rightBarButtonItem:(id)target
                                 action:(SEL)sel
                            rightString:(NSString *)rightString {
    UIBarButtonItem *rightItem = [[UIBarButtonItem alloc] initWithTitle:rightString
                                                                  style:UIBarButtonItemStylePlain
                                                                 target:target
                                                                 action:sel];
    rightItem.tintColor = [UIColor blackColor];
    return rightItem;
}

+ (UIBarButtonItem *)leftBarButtonItem:(id)target
                                action:(SEL)sel
                             imageName:(NSString *)imageName
                            leftString:(NSString *)leftString {
    if (imageName) {
        UIBarButtonItem *leftItem =
            [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:imageName]
                                             style:UIBarButtonItemStylePlain
                                            target:target
                                            action:sel];
        leftItem.tintColor = [UIColor blackColor];
        return leftItem;
        
    } else if (leftString) {
        UIBarButtonItem *leftItem = [[UIBarButtonItem alloc] initWithTitle:leftString
                                                                     style:UIBarButtonItemStylePlain
                                                                    target:target
                                                                    action:sel];
        leftItem.tintColor = [UIColor blackColor];
        return leftItem;
    } else {
        return [UIBarButtonItem new];
    }
}
@end
