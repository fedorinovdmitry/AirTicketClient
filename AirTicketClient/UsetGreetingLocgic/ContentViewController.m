//
//  ContentViewController.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 21.05.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "ContentViewController.h"

@interface ContentViewController ()

@property (nonatomic, strong) UIImageView *imageview;
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UILabel *contentLabel;

@end

@implementation ContentViewController

-(instancetype)init{
    self = [super init];
    if(self){
        [self createImageBackground];
        [self createTitleLabel];
        [self createContentLabel];
    }
    return self;
}
-(void)createImageBackground{
    _imageview = [[UIImageView alloc] initWithFrame:[UIScreen mainScreen].bounds];
    _imageview.contentMode = UIViewContentModeScaleAspectFill;
    _imageview.clipsToBounds = YES;
    [self.view addSubview: _imageview];
}
-(void)createTitleLabel{
    _titleLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 100, 70, 250, 21)];
    _titleLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:27.0];
    _titleLabel.textColor = UIColor.whiteColor;
    _titleLabel.shadowColor = [UIColor colorWithRed:16.0f/255.0f green:75.0f/255.0f blue:201.0f/255.0f alpha:1.0f];
    _titleLabel.shadowOffset = CGSizeMake(1, 1);
    _titleLabel.numberOfLines = 0;
    _titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_titleLabel];
}
-(void)createContentLabel{
    _contentLabel = [[UILabel alloc] initWithFrame:CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 150, [UIScreen mainScreen].bounds.size.height / 2 + 150, 300, 21)];
    _contentLabel.backgroundColor = [UIColor colorWithRed:170.0f/255.0f
                                                    green:235.0f/255.0f
                                                     blue:250.0f/255.0f
                                                    alpha:0.6f];
    _contentLabel.font = [UIFont fontWithName:@"SnellRoundhand-Bold" size:24.0];
    _contentLabel.textColor = UIColor.whiteColor;
    _contentLabel.numberOfLines = 0;
    _contentLabel.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:_contentLabel];
}
-(void)setTitle:(NSString *)title{
    _titleLabel.text = title;
    float height = heightForText(title, _titleLabel.font, 200);
    _titleLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 125, 70, 250, height);
}
-(void)setContentText:(NSString *)contentText{
    _contentText = contentText;
    _contentLabel.text = contentText;
    float height = heightForText(contentText, _contentLabel.font, 200);
    _contentLabel.frame = CGRectMake([UIScreen mainScreen].bounds.size.width / 2 - 150, [UIScreen mainScreen].bounds.size.height / 2 + 150, 300, height);
    
}
-(void)setImage:(UIImage *)image{
    _image = image;
    _imageview.image = image;
}

float heightForText(NSString *text, UIFont *font, float width){
    if (text && [text isKindOfClass:[NSString class]]){
        CGSize size = CGSizeMake(width,FLT_MAX);
        CGRect needLabel = [text boundingRectWithSize:size options:(NSStringDrawingUsesLineFragmentOrigin|NSStringDrawingUsesFontLeading) attributes:@{NSFontAttributeName:font} context:nil];
        return ceil(needLabel.size.height);
        
    }
    return 0.0;
}



@end
