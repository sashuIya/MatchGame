//
//  PlayingCard.m
//  Matchismo
//
//  Created by Alexander on 21.11.13.
//  Copyright (c) 2013 Alexander Lapin. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

- (NSString *)contents
{
  NSArray *rankStrings = [PlayingCard rankStrings];
  return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

- (int)matchCards:(NSArray *)cards
{
  int score = 0;
  
  for (PlayingCard *otherCard in cards) {
    if (otherCard.rank == self.rank && [otherCard.suit isEqualToString:self.suit]) {
      score += 0;
    } else if (otherCard.rank == self.rank) {
      score += 4;
    } else if ([otherCard.suit isEqualToString:self.suit]) {
      score += 1;
    }
  }
  
  return score;
}

/* suit */
@synthesize suit = _suit;

+ (NSArray *)validSuits
{
  return @[@"♥",@"♦",@"♠",@"♣"];
}

- (void)setSuit:(NSString *)suit
{
  if ([[PlayingCard validSuits] containsObject:suit]) {
    _suit = suit;
  }
}

- (NSString *)suit
{
  return _suit ? _suit : @"?";
}

/* rank */
+ (NSArray *)rankStrings
{
  return @[@"?", @"A", @"2", @"3", @"4", @"5",
           @"6", @"7", @"8", @"9", @"10", @"J",
           @"Q", @"K"];
}

+ (NSUInteger)maxRank
{
  NSUInteger rankStringsSize = [[PlayingCard rankStrings] count];
  NSUInteger result = rankStringsSize;
  if (rankStringsSize > 0)
    result--;
  return result;
}

- (void)setRank:(NSUInteger)rank
{
  if (rank <= [PlayingCard maxRank]) {
    _rank = rank;
  }
}

@end
