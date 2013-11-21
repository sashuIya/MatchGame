//
//  Card.m
//  Matchismo
//
//  Created by Alexander on 21.11.13.
//  Copyright (c) 2013 Alexander Lapin. All rights reserved.
//

#import "Card.h"

@interface Card ()

@end

@implementation Card

- (int)matchCards:(NSArray *)cards
{
  int score = 0;
  
  for (Card *card in cards) {
    if ([card.contents isEqualToString:self.contents]) {
      score = 1;
    }
  }
  
  return score;
}

@end
