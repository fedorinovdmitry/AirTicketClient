//
//  FavoriteTicket+CoreDataProperties.h
//  
//
//  Created by Дмитрий Федоринов on 18.05.2018.
//
//

#import "FavoriteTicket+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface FavoriteTicket (CoreDataProperties)

+ (NSFetchRequest<FavoriteTicket *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSDate *created;
@property (nullable, nonatomic, copy) NSString *to;
@property (nullable, nonatomic, copy) NSString *from;
@property (nullable, nonatomic, copy) NSString *airline;
@property (nullable, nonatomic, copy) NSDate *returnDate;
@property (nullable, nonatomic, copy) NSDate *expires;
@property (nullable, nonatomic, copy) NSDate *departure;
@property (nonatomic) int16_t flightNumber;
@property (nonatomic) int64_t price;
@property (nullable, nonatomic, copy) NSString *toFullName;
@property (nullable, nonatomic, copy) NSString *fromFullName;

@end

NS_ASSUME_NONNULL_END
