#import "PlayersSeparator.h"

@implementation PlayersSeparator

- (NSInteger)dividePlayersIntoTeams:(NSArray<NSNumber *>*)ratingArray {
    NSInteger countOfTeamMembers = ratingArray.count;
    if (countOfTeamMembers < 3) {
        return 0;
    }
    
    NSInteger count = 0;
    
    for (NSInteger j = 1; j < countOfTeamMembers - 1; j++) {
        NSInteger leftSmaller = 0, leftGreater = 0;
        NSInteger rightSmaller = 0, rightGreater = 0;
        NSInteger rating_j = ratingArray[j].integerValue;

        // Count players to the left of j
        for (NSInteger i = 0; i < j; i++) {
            NSInteger rating_i = ratingArray[i].integerValue;
            if (rating_i < rating_j) {
                leftSmaller++;
            } else if (rating_i > rating_j) {
                leftGreater++;
            }
        }

        // Count players to the right of j
        for (NSInteger k = j + 1; k < countOfTeamMembers; k++) {
            NSInteger rating_k = ratingArray[k].integerValue;
            if (rating_k < rating_j) {
                rightSmaller++;
            } else if (rating_k > rating_j) {
                rightGreater++;
            }
        }

        // Count valid teams
        count += leftSmaller * rightGreater;  // Increasing sequence teams
        count += leftGreater * rightSmaller;  // Decreasing sequence teams
    }
    
    return count;
}

@end
