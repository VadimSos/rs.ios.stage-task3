#import "LexicographicallyMinimal.h"

@interface LexicographicallyMinimal()

@property (nonatomic, strong) NSMutableString *resultString;

@end

@implementation LexicographicallyMinimal

-(NSString *)findLexicographicallyMinimalForString1:(NSString *)string1 andString2:(NSString *)string2 {
    NSMutableString *result = [NSMutableString string];
    
    NSUInteger index1 = 0, index2 = 0;
    NSUInteger length1 = [string1 length], length2 = [string2 length];
    
    while (index1 < length1 && index2 < length2) {
        unichar char1 = [string1 characterAtIndex:index1];
        unichar char2 = [string2 characterAtIndex:index2];
        
        if (char1 < char2) {
            [result appendFormat:@"%C", char1];
            index1++;
        } else if (char1 > char2) {
            [result appendFormat:@"%C", char2];
            index2++;
        } else {
            // If both characters are the same, we need to look ahead to make sure we are still lexicographically minimal
            // This is essentially comparing the remaining substrings lexicographically
            NSString *remaining1 = [string1 substringFromIndex:index1];
            NSString *remaining2 = [string2 substringFromIndex:index2];
            if ([remaining1 compare:remaining2] <= 0) {
                [result appendFormat:@"%C", char1];
                index1++;
            } else {
                [result appendFormat:@"%C", char2];
                index2++;
            }
        }
    }
    
    // Append the remaining characters from either string
    if (index1 < length1) {
        [result appendString:[string1 substringFromIndex:index1]];
    }
    if (index2 < length2) {
        [result appendString:[string2 substringFromIndex:index2]];
    }
    
    return result;
}

@end
