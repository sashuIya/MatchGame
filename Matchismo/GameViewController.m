//
//  GameViewController.m
//  Matchismo
//
//  Created by Alexander on 21.11.13.
//  Copyright (c) 2013 Alexander Lapin. All rights reserved.
//

#import "GameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"
#import "CardMatchingGame.h"

@interface GameViewController ()
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *gameModeSegmentedControl;
//@property (nonatomic) int cardsToMatch;
@end

@implementation GameViewController

- (CardMatchingGame *)game
{
  if (!_game) {
    _game = [[CardMatchingGame alloc] initWithCardsCount:[self.cardButtons count]
                                               usingDeck:[self createDeck]];
  }
  
  return _game;
}

- (Deck *)createDeck
{
  NSLog(@"deck created");
  return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchNewGameButton:(UIButton *)sender {
  self.game = nil;
  self.gameModeSegmentedControl.enabled = YES;
  [self updateUI];
}

- (IBAction)touchCardButton:(UIButton *)sender
{
  self.game.cardsToMatch = self.gameModeSegmentedControl.selectedSegmentIndex + 2;
  self.gameModeSegmentedControl.enabled = NO;
  NSUInteger chosenButtonIndex = [self.cardButtons indexOfObject:sender];
  [self.game chooseCardAtIndex:chosenButtonIndex];
//  Card *card = [self.game cardAtIndex:chosenButtonIndex];
//  NSLog(@"Chosen: %@, isChosen = %d, isMatched = %d",
//        card.contents, card.isChosen, card.isMatched);
  [self updateUI];
}

- (void)updateUI
{
  for (UIButton *cardButton in self.cardButtons) {
    NSUInteger cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
    Card *card = [self.game cardAtIndex:cardButtonIndex];
//    NSLog(@"%@, isChosen = %d, isMatched = %d, title: %@",
//          card.contents, card.isChosen, card.isMatched,
//          [self titleForCard:card]);
    [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
    [cardButton setBackgroundImage:[self backgroundImageForCard:card] forState:UIControlStateNormal];
    cardButton.enabled = !card.isMatched;
  }
  self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", (int)self.game.score];
}

- (NSString *)titleForCard:(Card *)card
{
  return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card
{
  return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

@end
