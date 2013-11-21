//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Alexander on 21.11.13.
//  Copyright (c) 2013 Alexander Lapin. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@end

@implementation CardMatchingGame

- (NSMutableString *)log
{
  if (!_log) {
    _log = [[NSMutableString alloc] init];
  }

  return _log;
}

- (NSMutableArray *)cards
{
  if (!_cards) {
    _cards = [[NSMutableArray alloc] init];
  }
  
  return _cards;
}

- (instancetype)initWithCardsCount:(NSUInteger)cardsCount
                         usingDeck:(Deck *)deck
{
  self = [super init];
  
  if (self) {
    for (int index = 0; index < cardsCount; ++index) {
      Card *card = [deck drawRandomCard];
      if (card) {
        [self.cards addObject:card];
      } else {
        self = nil;
        break;
      }
    }
  }
  
  return self;
}

- (Card *)cardAtIndex:(NSUInteger)index
{
  if (index < [self.cards count]) {
    return self.cards[index];
  }
  
  return nil;
}

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (void)chooseCardAtIndex:(NSUInteger)index
{
  Card *card = [self cardAtIndex:index];
  NSMutableArray *choosedNotMatchedCards = [[NSMutableArray alloc] init];
  
  [self.log setString:@"Chosen cards: "];
  
  for (Card *otherCard in self.cards) {
    if (otherCard.isChosen && !otherCard.isMatched) {
      [choosedNotMatchedCards addObject:otherCard];
    }
  }
  
  if (card && !card.isMatched && !card.isChosen)
    [choosedNotMatchedCards addObject:card];
  
  for (Card *choosedCard in choosedNotMatchedCards) {
    [self.log appendFormat:@" %@",choosedCard.contents];
  }
  
  if (card && !card.isMatched) {
    if (card.isChosen) {
      card.chosen = NO;
    } else {
      int matchScore = 0;
      if ([choosedNotMatchedCards count] == self.cardsToMatch)
      {
        for (Card *choosedCard in choosedNotMatchedCards) {
          matchScore += [choosedCard matchCards:choosedNotMatchedCards];
        }
      }
      
      if (matchScore) {
        NSLog(@"Score: %d", matchScore);
        self.score += matchScore * MATCH_BONUS;
        for (Card *choosedCard in choosedNotMatchedCards)
          choosedCard.matched = YES;
      } else if ([choosedNotMatchedCards count] == self.cardsToMatch) {
        self.score -= MISMATCH_PENALTY;
        for (Card *otherCard in choosedNotMatchedCards)
          otherCard.matched = NO;
      }
      
      if ([choosedNotMatchedCards count] == self.cardsToMatch) {
        for (Card *choosedCard in choosedNotMatchedCards) {
          if (!choosedCard.isMatched) {
            choosedCard.chosen = NO;
          }
        }
      }

      self.score -= COST_TO_CHOOSE;
      card.chosen = YES;
    }
  }
  
  NSLog(@"%@",self.log);
}

@end
