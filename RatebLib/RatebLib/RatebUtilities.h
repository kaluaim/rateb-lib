#import <Foundation/Foundation.h>

@interface RatebUtilities : NSObject

extern NSString *const kSolarDay;
extern NSString *const kSolarMonth;
extern NSString *const kSolarYear;

@property (strong, nonatomic) NSDictionary *ummulquraDates;

- (NSDictionary *)retrivenHijriSolarDateForHijriLunarDay:(NSInteger)day month:(NSInteger)month andYear:(NSInteger)year;
- (NSDate *)retrivenNextRatebFromCurrentHijriLunarDay:(NSInteger)day month:(NSInteger)month andYear:(NSInteger)year;
- (NSString *)monthNameForMonthNumber:(NSInteger)monthNumber andCalendar:(NSCalendar *)calendar;
- (NSInteger)calculateDaysLeftToNextRatebDate:(NSDate *)ratebDate;
- (NSString *)localizeGregorianMonth:(NSInteger)month;
- (NSString *)localizeHijriLunarMonth:(NSInteger)month;
- (NSString *)localizeHijriSolarMonth:(NSInteger)month;
@end
