//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Alexander on 21.11.13.
//  Copyright (c) 2013 Alexander Lapin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardsCount:(NSUInteger)cardsCount
                         usingDeck:(Deck *)deck;

- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;

@property (nonatomic) NSUInteger cardsToMatch;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic, strong) NSMutableString *log;

@end
