//
//  deck.m
//  Matchismo
//
//  Created by Alexander on 21.11.13.
//  Copyright (c) 2013 Alexander Lapin. All rights reserved.
//

#import "deck.h"


@interface Deck()

@property (strong, nonatomic) NSMutableArray *cards; // of Card

@end

@implementation Deck

- (NSMutableArray *)cards
{
  if (!_cards)
    _cards = [[NSMutableArray alloc] init];
  return _cards;
}

- (void)addCard:(Card *)card atTop:(BOOL)atTop
{
  if (atTop) {
    [self.cards insertObject:card atIndex:0];
  }
  else {
    [self.cards addObject:card];
  }

}

- (void)addCard:(Card *)card
{
  [self addCard:card atTop:NO];
}

- (Card *)drawRandomCard
{
  Card *randomCard = nil;
  
  if ([self.cards count]) {
    unsigned index = arc4random() % [self.cards count];
    randomCard = self.cards[index];
    [self.cards removeObjectAtIndex:index];
  }
  
  return randomCard;
}

@end
