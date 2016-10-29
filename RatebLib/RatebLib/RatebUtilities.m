#import "RatebUtilities.h"

@implementation RatebUtilities
NSString *const kGregoranDay    = @"gregoran_day";
NSString *const kGregoranMonth  = @"gregoran_month";
NSString *const kGregoranYear   = @"gregoran_year";
NSString *const kSolarDay       = @"hijri_solar_day";
NSString *const kSolarMonth     = @"hijri_solar_month";
NSString *const kSolarYear      = @"hijri_solar_year";

- (NSDictionary *)retrivenHijriSolarDateForHijriLunarDay:(NSInteger)day month:(NSInteger)month andYear:(NSInteger)year{
    @try {
        return [[[_ummulquraDates objectForKey:[NSString stringWithFormat:@"%ld", (long)year]] objectAtIndex:month-1] objectAtIndex:day-1];
    } @catch (NSException *exception) {
        @try {
            return [[[_ummulquraDates objectForKey:[NSString stringWithFormat:@"%ld", (long)year]] objectAtIndex:month-1] objectAtIndex:day-2];
        } @catch (NSException *exception) {
            return NULL;
        }
    }
}

- (NSDate *)retrivenNextRatebFromCurrentHijriLunarDay:(NSInteger)day month:(NSInteger)month andYear:(NSInteger)year {
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    [dateComponents setCalendar:[NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian]];
    NSDictionary *solarForLunarDict = [self retrivenHijriSolarDateForHijriLunarDay:day month:month andYear:year];
    NSDictionary *ratebDict;
    NSInteger tmpDay = day;
    NSInteger tmpMonth = month;
    NSInteger tmpYear = year;
    
    if ([[solarForLunarDict objectForKey:kSolarDay] intValue] == 5){
        ratebDict = solarForLunarDict;
    } else {
        BOOL found = NO;
        
        while (!found) {
            tmpDay++;
            ratebDict = [self retrivenHijriSolarDateForHijriLunarDay:tmpDay month:tmpMonth andYear:tmpYear];
            
            if (ratebDict == NULL) {
                tmpMonth++;
                tmpDay = 1;
                
                if (tmpMonth == 13) {
                    tmpMonth = 1;
                    tmpYear++;
                }
            }
            
            if ([[ratebDict objectForKey:kSolarDay] intValue] == 5) {
                found = YES;
            }
        }
    }

    [dateComponents setDay:[[ratebDict objectForKey:kGregoranDay] intValue]];
    [dateComponents setMonth:[[ratebDict objectForKey:kGregoranMonth] intValue]];
    [dateComponents setYear:[[ratebDict objectForKey:kGregoranYear] intValue]];
    
    NSDate *ratebDate = [dateComponents date];
    return ratebDate;
}

- (NSString *)monthNameForMonthNumber:(NSInteger)monthNumber andCalendar:(NSCalendar *)calendar {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setTimeZone:[NSTimeZone timeZoneWithName:@"AST"]];
    [formatter setCalendar:calendar];
    NSArray *monthNames = [formatter standaloneMonthSymbols];
    NSString *monthName = [monthNames objectAtIndex:(monthNumber - 1)];
    return monthName;
}

- (NSInteger)calculateDaysLeftToNextRatebDate:(NSDate *)ratebDate {
    NSDate *fromDate;
    NSDate *toDate;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&fromDate interval:NULL forDate:[NSDate date]];
    [calendar rangeOfUnit:NSCalendarUnitDay startDate:&toDate interval:NULL forDate:ratebDate];
    NSDateComponents *difference = [calendar components:NSCalendarUnitDay fromDate:fromDate toDate:toDate options:0];
    return [difference day];
}

- (NSString *)localizeGregorianMonth:(NSInteger)month {
    
    switch (month) {
        case 1:
            return NSLocalizedString(@"MONTH_GREGORIAN_JANUARY", nil);
            break;
            
        case 2:
            return NSLocalizedString(@"MONTH_GREGORIAN_FEBRUARY", nil);
            break;
            
        case 3:
            return NSLocalizedString(@"MONTH_GREGORIAN_MARCH", nil);
            break;
            
        case 4:
            return NSLocalizedString(@"MONTH_GREGORIAN_APRIL", nil);
            break;
            
        case 5:
            return NSLocalizedString(@"MONTH_GREGORIAN_MAY", nil);
            break;
            
        case 6:
            return NSLocalizedString(@"MONTH_GREGORIAN_JUNE", nil);
            break;
            
        case 7:
            return NSLocalizedString(@"MONTH_GREGORIAN_JULY", nil);
            break;
            
        case 8:
            return NSLocalizedString(@"MONTH_GREGORIAN_AUGUST", nil);
            break;
            
        case 9:
            return NSLocalizedString(@"MONTH_GREGORIAN_SEPTEMBER", nil);
            break;
            
        case 10:
            return NSLocalizedString(@"MONTH_GREGORIAN_OCTOBER", nil);
            break;
            
        case 11:
            return NSLocalizedString(@"MONTH_GREGORIAN_NOVEMBER", nil);
            break;
            
        case 12:
            return NSLocalizedString(@"MONTH_GREGORIAN_DECEMBER", nil);
            break;
            
        default:
            return @"";
            break;
    }
    
}


- (NSString *)localizeHijriLunarMonth:(NSInteger)month {
    
    switch (month) {
        case 1:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_MUHARRAM", nil);
            break;
            
        case 2:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_SAFAR", nil);
            break;
            
        case 3:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_RABI_ALAWWAL", nil);
            break;
            
        case 4:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_RABI_ALTHANI", nil);
            break;
            
        case 5:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_JUMADA_ALAWWAL", nil);
            break;
            
        case 6:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_JUMAADA_ALAKHIR", nil);
            break;
            
        case 7:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_RAJAB", nil);
            break;
            
        case 8:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_SHABAN", nil);
            break;
            
        case 9:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_RAMADAN", nil);
            break;
            
        case 10:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_SHAWWAL", nil);
            break;
            
        case 11:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_DHU_ALQIDAH", nil);
            break;
            
        case 12:
            return NSLocalizedString(@"MONTH_HIJRI_LUNAR_DHU_ALHIJJAH", nil);
            break;
            
        default:
            return @"";
            break;
    }
    
}

- (NSString *)localizeHijriSolarMonth:(NSInteger)month {
    
    switch (month) {
        case 1:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_ARIES", nil);
            break;
            
        case 2:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_TAURUS", nil);
            break;
            
        case 3:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_GEMINI", nil);
            break;
            
        case 4:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_CANCER", nil);
            break;
            
        case 5:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_LEO", nil);
            break;
            
        case 6:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_VIRGO", nil);
            break;
            
        case 7:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_LIBRA", nil);
            break;
            
        case 8:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_SCORPIO", nil);
            break;
            
        case 9:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_SAGITTARIUS", nil);
            break;
            
        case 10:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_CAPRICORN", nil);
            break;
            
        case 11:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_AQUARIUS", nil);
            break;
            
        case 12:
            return NSLocalizedString(@"MONTH_HIJRI_SOLAR_PISCES", nil);
            break;
            
        default:
            return @"";
            break;
    }
    
}

@end
