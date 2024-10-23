#import "DateHelper.h"
#import "NSDate+CustomDate.h"

@implementation DateHelper

#pragma mark - First

-(NSString *)monthNameBy:(NSUInteger)monthNumber {
    NSArray<NSString *> *monthNameArray = @[@"January", @"February", @"March", @"April",
                                            @"May", @"June", @"July", @"August",
                                            @"September", @"October", @"November", @"December"];
    
    if (monthNumber < 1 || monthNumber > monthNameArray.count) {
        return nil;
    }
    
    return [monthNameArray objectAtIndex:monthNumber - 1];
}

#pragma mark - Second

- (long)dayFromDate:(NSString *)date {
    NSDateFormatter *dateFormatter = [NSDateFormatter new];
    dateFormatter.dateFormat = @"yyyy-MM-dd'T'HH:mm:ss'Z'"; // ISO 8601 format
    dateFormatter.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US_POSIX"];
    dateFormatter.timeZone = [NSTimeZone timeZoneWithAbbreviation:@"UTC"];

    // Attempt to parse the date string
    NSDate *inputDate = [dateFormatter dateFromString:date];
    
    if (!inputDate) {
        return 0;
    }
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *components = [calendar components:NSCalendarUnitDay fromDate:inputDate];
    return components.day;
}

#pragma mark - Third

- (NSString *)getDayName:(NSDate*) date {
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"ru"]];
    [dateFormatter setDateFormat:@"E"];
    NSString *dayName = [dateFormatter stringFromDate:date];
    
    return dayName;
}

#pragma mark - Fourth

- (BOOL)isDateInThisWeek:(NSDate *)date {
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    // Get the start of the current week
    NSDate *startOfWeek;
    NSTimeInterval interval;
    [calendar rangeOfUnit:NSCalendarUnitWeekOfYear startDate:&startOfWeek interval:&interval forDate:[NSDate now]];
    
    // Get the end of the current week
    NSDate *endOfWeek = [startOfWeek dateByAddingTimeInterval:interval - 1];
    
    // Check if the input date falls between the start and end of the week
    return [date compare:startOfWeek] != NSOrderedAscending && [date compare:endOfWeek] != NSOrderedDescending;
}

@end
