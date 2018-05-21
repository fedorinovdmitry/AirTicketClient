//
//  ProgressView.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 21.05.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "ProgressView.h"


@implementation ProgressView{
    BOOL isActive;
}
+(instancetype)sharedInstance{
    static ProgressView *instance;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ProgressView alloc] initWithFrame:[UIApplication sharedApplication].keyWindow.bounds];
        [instance setup];
    });
    return instance;
}

-(void)setup{
    UIImageView *backgroundImageView = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImageView.image = [UIImage imageNamed:@"sky"];
    backgroundImageView.contentMode = UIViewContentModeScaleAspectFill;
    backgroundImageView.clipsToBounds = YES;
    [self addSubview: backgroundImageView];
    
//    UIVisualEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
//    UIVisualEffectView *blurView = [[UIVisualEffectView alloc] initWithEffect:effect];
//    blurView.frame = self.bounds;
//    [self addSubview:blurView];
    
    [self createPlane];
    
}
-(void)createPlane{
    UIImageView *plane = [[UIImageView alloc] initWithFrame:CGRectMake(self.bounds.size.width - 230, (self.bounds.size.height / 2) - self.bounds.size.height / 7.36, 228, 67) ];
    plane.image = [UIImage imageNamed:@"airplane"];
    plane.contentMode = UIViewContentModeScaleAspectFit;
    plane.tag = 1;
    NSLog(@"height %f",self.bounds.size.height );
    [self addSubview:plane];
    
}

-(void)startAnimating:(NSInteger)planeId{
    if (!isActive) return;
    UIImageView *plane = [self viewWithTag:1];
    if(plane){
        [UIView animateWithDuration:5 animations:^{
            plane.frame = CGRectMake(30, self.bounds.size.height / 6, 5, 1.5);
        } completion:^(BOOL finished) {
            
            plane.frame = CGRectMake(self.bounds.size.width - 230, (self.bounds.size.height / 2) - 100, 228, 67);
        }];
//        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
//            [self startAnimating:planeId];
//        });
    }
}
-(void)show:(void (^)(void))completion{
    self.alpha = 0.0;
    isActive = YES;
    [self startAnimating:1];
    [[[UIApplication sharedApplication] keyWindow] addSubview:self];
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 1.0;
    } completion:^(BOOL finished) {
        completion();
    }];
}
-(void)dismiss:(void (^)(void))completion{
    [UIView animateWithDuration:0.5 animations:^{
        self.alpha = 0.0;
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
        isActive = NO;
        if (completion){
            completion();
        }
    }];
}




@end
