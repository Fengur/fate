//
//  FGTextField.m
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "FGTextField.h"
#import <objc/objc.h>
#import <objc/runtime.h>

@interface FGTextField()

@property(nonatomic, assign) BOOL enableLimitCount;

@end

static NSString *kLimitTextLengthKey = @"kLimitTextLengthKey";

@implementation FGTextField
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)init {
    self = [super init];
    if (self) {
        [self textFieldCommonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self textFieldCommonInit];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self textFieldCommonInit];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
                  cornerRadio:(CGFloat)radio
                  borderWidth:(CGFloat)bWidth
            borderNormalColor:(UIColor *)bNormalColor
             borderLightColor:(UIColor *)bLightColor {
    self = [self initWithFrame:frame];
    if (self) {
        _borderNormalColor = bNormalColor;
        _borderLightColor = bLightColor;
        _cornerRadio = radio;
        _borderWidth = bWidth;
        
        [self.layer setCornerRadius:_cornerRadio];
        [self.layer setBorderColor:_borderNormalColor.CGColor];
        [self.layer setBorderWidth:_borderWidth];
        [self setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [self setBackgroundColor:[UIColor whiteColor]];
        [self.layer setMasksToBounds:NO];
    }
    return self;
}

- (void)textFieldCommonInit {
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(beginEditing:)
                                                 name:UITextFieldTextDidBeginEditingNotification
                                               object:self];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(endEditing:)
                                                 name:UITextFieldTextDidEndEditingNotification
                                               object:self];
}

- (void)beginEditing:(NSNotification *)notification {
    //    [[self layer] setShadowOffset:CGSizeMake(0, 0)];
    //    [[self layer] setShadowRadius:_lightSize];
    //    [[self layer] setShadowOpacity:1];
    //    [[self layer] setShadowColor:_lightColor.CGColor];
    [self.layer setBorderColor:_borderLightColor.CGColor];
}

- (BOOL)endEditing:(BOOL)force {
    //    [[self layer] setShadowOffset:CGSizeZero];
    //    [[self layer] setShadowRadius:0];
    //    [[self layer] setShadowOpacity:0];
    //    [[self layer] setShadowColor:nil];
    [self.layer setBorderColor:_borderNormalColor.CGColor];
    return YES;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}



//控制显示文本的位置
- (CGRect)textRectForBounds:(CGRect)bounds

{
CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width - 25,
                          bounds.size.height);
    return inset;
}

//控制编辑文本的位置
- (CGRect)editingRectForBounds:(CGRect)bounds

{
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width - 25,
                              bounds.size.height);
    return inset;
}

//控制placeHolder的位置，左右缩20
- (CGRect)placeholderRectForBounds:(CGRect)bounds

{
    CGRect inset = CGRectMake(bounds.origin.x, bounds.origin.y, bounds.size.width - 25,
                              bounds.size.height - 25);
    return inset;
}

//控制placeHolder的颜色、字体
- (void)drawPlaceholderInRect:(CGRect)rect
{
    [[UIColor grayColor] setFill];
    [[self placeholder] drawInRect:rect withFont:[UIFont systemFontOfSize:16]];
}

@end
