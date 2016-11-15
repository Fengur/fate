//
//  DSTravelCell.m
//  destiny
//
//  Created by Fengur on 2016/11/15.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "DSTravelCell.h"
#import "DSTravelModel.h"

@interface DSTravelCell (){
    UIImageView *_userHeadImage;
    UILabel *_titleLabel;
    UILabel *_routeDaysLabel;
    UILabel *_timeLabel;
    UIView *_containView;
    UIView *_partView;
    CGFloat _cellHeight;
}
@end



@implementation DSTravelCell


- (void)awakeFromNib {
    [super awakeFromNib];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self setupControls];
        self.backgroundColor = [UIColor blackColor];
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}


- (CGFloat)getCellHeight{
    return _cellHeight;
}

- (void)setupControls{
    _headImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, 250)];
    _headImage.contentMode = UIViewContentModeScaleAspectFill;
    _headImage.clipsToBounds = YES;
    [self addSubview:_headImage];
    
    
    _containView = [[UIView alloc]initWithFrame:CGRectMake(0, _headImage.height, ScreenWidth, 0)];
    _containView.backgroundColor = [UIColor clearColor];
    [self addSubview:_containView];
    
    _userHeadImage = [[UIImageView alloc]initWithFrame:CGRectMake(Spadding, Padding, 40, 40)];
    _userHeadImage.layer.cornerRadius = Spadding;
    _userHeadImage.layer.masksToBounds = YES;
    [_containView addSubview:_userHeadImage];
    
    _titleLabel = [[UILabel alloc]init];
    _titleLabel.numberOfLines = 0;
    _titleLabel.font = DailyFont(18.f);
    [_containView addSubview:_titleLabel];
    
    
    _routeDaysLabel = [[UILabel alloc]init];
    [_containView addSubview:_routeDaysLabel];
    
    _timeLabel = [[UILabel alloc]init];
    [_containView addSubview:_timeLabel];
    
    _partView = [[UIView alloc]init];
    _partView.backgroundColor = [UIColor groupTableViewBackgroundColor];
    [_containView addSubview:_partView];
}

- (void)setTravelCellDetailWithModel:(DSTravelModel *)travelModel{
    [_headImage yy_setImageWithURL:[NSURL URLWithString:travelModel.headImage] placeholder:ImageOfName(@"godwait") options:YYWebImageOptionProgressive|YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
    
    [_userHeadImage yy_setImageWithURL:[NSURL URLWithString:travelModel.userHeadImg] placeholder:ImageOfName(@"god") options:YYWebImageOptionProgressive|YYWebImageOptionSetImageWithFadeAnimation completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
    
    _timeLabel.text = [self convertDataStringWithString:travelModel.startTime];
    _timeLabel.frame = CGRectMake(_userHeadImage.width+Padding, Padding, 150, _userHeadImage.height);
    _timeLabel.font = DailyFont(16.f);
    _timeLabel.textColor = [UIColor whiteColor];
    
    _routeDaysLabel.text = [NSString stringWithFormat:@"%@天",travelModel.routeDays];
    _routeDaysLabel.frame = CGRectMake(ScreenWidth-45, Padding, 40, 40);
    _routeDaysLabel.textAlignment = NSTextAlignmentCenter;
    _routeDaysLabel.layer.cornerRadius = 20;
    _routeDaysLabel.layer.borderWidth = 1;
    _routeDaysLabel.textColor = [UIColor whiteColor];
    _routeDaysLabel.font = DailyFont(16.f);
    _routeDaysLabel.layer.borderColor = [UIColor whiteColor].CGColor;
    
    
    _titleLabel.text = travelModel.title;
    _titleLabel.frame = CGRectMake(Spadding, _userHeadImage.y+_userHeadImage.height+Padding, ScreenWidth-Padding, 0);
    _titleLabel.attributedText = [self setAttributeStringWithString:_titleLabel.text];
    [_titleLabel sizeToFit];
    

    _containView.height = _titleLabel.y+_titleLabel.height+10;
    _partView.frame = CGRectMake(0, _titleLabel.y+_titleLabel.height+5, ScreenWidth, 5);
    _cellHeight = _containView.y+_containView.height;
}


- (NSString *)convertDataStringWithString:(NSString *)originDateString{
    NSString *resultStr = @"";
    NSArray *temoArray = [originDateString componentsSeparatedByString:@"-"];
    if(temoArray.count == 3){
        resultStr = [NSString stringWithFormat:@"%@年%@月%@日",temoArray[0],temoArray[1],temoArray[2]];
    }
    return resultStr;
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
                       value:[UIColor whiteColor]
                       range:NSMakeRange(0, [string length])];
    return hintString;
}
@end
