//
//  NSString+Localize.m
//  AirTicketClient
//
//  Created by Дмитрий Федоринов on 26.05.2018.
//  Copyright © 2018 Geekbrains. All rights reserved.
//

#import "NSString+Localize.h"

@implementation NSString (Localize)

    -(NSString *)localize{
        return NSLocalizedString(self, "");
    }
    
@end
