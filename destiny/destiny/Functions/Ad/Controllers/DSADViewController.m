//
//  DSADViewController.m
//  destiny
//
//  Created by Fengur on 2016/11/14.
//  Copyright © 2016年 code.sogou.fengur. All rights reserved.
//

#import "DSADViewController.h"
#import "DSSentenceModel.h"
#import "AppDelegate.h"
@interface DSADViewController (){
    UILabel *_contentLabel;
    UILabel *_autorLabel;
    DSSentenceModel *_currentModel;
    UIImageView *_godImage;
}
@end

@implementation DSADViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    _godImage = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ScreenHeight)];
    _godImage.alpha = 1;
    _godImage.contentMode = UIViewContentModeScaleAspectFill;
    _godImage.image = ImageOfName(@"god");
    [self.view addSubview:_godImage];
    _currentModel = [DSSentenceModel new];
    _currentModel.content = DefaultSentence;
    _currentModel.mrname = DefaultAutor;
    [self requestForContent];

}


- (void)setupUIControls{
    _contentLabel = [[UILabel alloc]initWithFrame:CGRectMake(Padding, ScreenHeight*GoldenScale, ScreenWidth-Padding*2, 60)];
    _contentLabel.numberOfLines = 0;
    _contentLabel.textColor = [UIColor whiteColor];
    _contentLabel.text = [NSString stringWithFormat:@"%@\n\n\t%@",_currentModel.content,_currentModel.mrname];
    [self.view addSubview:_contentLabel];
    _contentLabel.font = DailyFont(20.f);
    _contentLabel.alpha = 0;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    _contentLabel.transform = CGAffineTransformMakeScale(0, 0);
    
    
    [UIView animateWithDuration:3 animations:^{
        _contentLabel.alpha = 1;
            _contentLabel.transform = CGAffineTransformMakeScale(1, 1);
        _godImage.alpha = 0.3;
    } completion:^(BOOL finished) {
        
        [NSThread sleepForTimeInterval:1.5];
        [UIView animateWithDuration:3.f animations:^{
            
            _contentLabel.alpha = 0.618;
            _contentLabel.y = _contentLabel.y + 120;
            _godImage.alpha = 1;
        } completion:^(BOOL finished) {
            
            [SharedApp setAppRootVC];
            
        }];
        
    }];
}

- (void)requestForContent{
    [FGHttpTool updateBaseUrl:SentenceUrl];
    NSMutableDictionary *paramDict = [[NSMutableDictionary alloc]init];
    [FGHttpTool getWithURL:@"" params:paramDict success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        NSData *doubi = responseObject;
        
        NSString *shabi =  [[NSString alloc]initWithData:doubi encoding:NSUTF8StringEncoding];
        id response = [responseObject objectForKey:@"newslist"];
        _currentModel = [DSSentenceModel yy_modelWithDictionary:response[0]];
        [self setupUIControls];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
            [self setupUIControls];
    }];
}
- (NSMutableAttributedString *)setColorAttributeStringWithString:(NSString *)string {
    NSArray *seletcArray = [string componentsSeparatedByString:@"\n\n"];
    NSInteger sizeCount;
    if (seletcArray.count > 0) {
        sizeCount = ((NSString *)seletcArray[0]).length + 1;
    }
    NSMutableAttributedString *hintString =
    [[NSMutableAttributedString alloc] initWithString:string];
    NSRange range1 = NSMakeRange(0, sizeCount);
    NSRange range2 = NSMakeRange(sizeCount, hintString.length - sizeCount);
    [hintString addAttribute:NSFontAttributeName
                       value:DailyFont(20.f)
                       range:range1];
    [hintString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor whiteColor]
                       range:range1];
    
    [hintString addAttribute:NSFontAttributeName
                       value:DailyFont(15.f)
                       range:range2];
    [hintString addAttribute:NSForegroundColorAttributeName
                       value:[UIColor whiteColor]
                       range:range2];
    return hintString;
}


- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}
@end
