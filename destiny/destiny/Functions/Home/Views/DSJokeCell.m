//
//  DSJokeCell.m
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "DSJokeCell.h"
#import "DSJuziModel.h"

@interface DSJokeCell(){
    UIView *_backView;
    UILabel *_containLabel;
    CGFloat _cellHeight;
}

@end

@implementation DSJokeCell

- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        self.backgroundColor = [UIColor blackColor];
        [self setupControls];
    }
    return self;
}

- (void)setJokeCellDetailWithModel:(DSJokeModel *)jokeModel{
//    jokeModel.text = [jokeModel.text stringByReplacingOccurrencesOfString:@"<p>" withString:@""];
//    jokeModel.text = [jokeModel.text stringByReplacingOccurrencesOfString:@"</p>" withString:@""];
//    jokeModel.text = [jokeModel.text stringByReplacingOccurrencesOfString:@"\r" withString:@""];
//    jokeModel.text = [jokeModel.text stringByReplacingOccurrencesOfString:@"\t" withString:@""];
//    jokeModel.text = [jokeModel.text stringByReplacingOccurrencesOfString:@"1、" withString:@""];
//    jokeModel.text = [jokeModel.text stringByReplacingOccurrencesOfString:@"2、" withString:@""];
//    jokeModel.text = [jokeModel.text stringByReplacingOccurrencesOfString:@"3、" withString:@""];
//    jokeModel.text = [jokeModel.text stringByReplacingOccurrencesOfString:@"4、" withString:@""];
//    jokeModel.text = [jokeModel.text stringByReplacingOccurrencesOfString:@"5、" withString:@""];
//    
    _containLabel.numberOfLines = 0;
//    _containLabel.text = jokeModel.text;
    _containLabel.font = SingleFont(16.f);
    _containLabel.frame = CGRectMake(Padding*GoldenScale, Spadding, _backView.width-Padding, 0);
    _containLabel.attributedText = [self setAttributeStringWithString:_containLabel.text];
    [_containLabel sizeToFit];
    _containLabel.backgroundColor = [UIColor whiteColor];
    _backView.height = _containLabel.height+Padding*GoldenScale*2;
    _cellHeight = _backView.height+Padding;
}

- (CGFloat)getCellHeight{
    return _cellHeight;
}

- (void)setupControls{
    _backView = [[UIView alloc]initWithFrame:CGRectMake(0, Spadding, ScreenWidth, 0)];
    [self addSubview:_backView];
    _backView.backgroundColor = [UIColor whiteColor];
    _containLabel = [[UILabel alloc]init];
    [_backView addSubview:_containLabel];
}


- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    if (self.highlighted) {
        POPBasicAnimation *scaleAnimation = [POPBasicAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.duration = 0.5;
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(0.9, 0.9)];
        [self pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    } else {
        POPSpringAnimation *scaleAnimation = [POPSpringAnimation animationWithPropertyNamed:kPOPViewScaleXY];
        scaleAnimation.toValue = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.velocity = [NSValue valueWithCGPoint:CGPointMake(1, 1)];
        scaleAnimation.springBounciness = 5.f;
        [self pop_addAnimation:scaleAnimation forKey:@"scaleAnimation"];
    }
}

- (NSMutableAttributedString *)setAttributeStringWithString:(NSString *)string {
    NSMutableAttributedString *hintString =
    [[NSMutableAttributedString alloc] initWithString:string];
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];
    [hintString addAttribute:NSParagraphStyleAttributeName
                       value:paragraphStyle
                       range:NSMakeRange(0, [string length])];
    [hintString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor blackColor]
                       range:NSMakeRange(0, [string length])];
    return hintString;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

@end
