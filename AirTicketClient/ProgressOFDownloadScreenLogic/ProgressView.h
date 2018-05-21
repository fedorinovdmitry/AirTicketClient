//
//  ProgressView.h
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 21.05.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProgressView : UIView

+(instancetype)sharedInstance;

-(void)show:(void (^)(void))completion;
-(void)dismiss:(void (^)(void))completion;

@end
