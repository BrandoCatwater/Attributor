//
//  TextStatsViewController.m
//  Attributor
//
//  Created by Brandon Chatreau on 2014-05-01.
//  Copyright (c) 2014 Brandon Chatreau. All rights reserved.
//

#import "TextStatsViewController.h"

@interface TextStatsViewController ()
@property (weak, nonatomic) IBOutlet UILabel *colorfulCharactersLabel;
@property (weak, nonatomic) IBOutlet UILabel *outlinedCharactersLabel;

@end

@implementation TextStatsViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
}


- (void)setTextToAnalyze:(NSAttributedString *)textToAnalyze {
    
    _textToAnalyze = textToAnalyze;
    if (self.view.window)[self updateUI];
}

- (void)updateUI
{
    self.colorfulCharactersLabel.text = [NSString stringWithFormat:@"%d : Colored Characters in the string",[[self charactersWithAttribute:NSForegroundColorAttributeName] length]];
    self.outlinedCharactersLabel.text = [NSString stringWithFormat:@"%d : Outlined Characters in the string",[[self charactersWithAttribute:NSStrokeWidthAttributeName] length]];
    
}

- (NSAttributedString *)charactersWithAttribute:(NSString *)attributeName
{
    NSMutableAttributedString *characters = [[NSMutableAttributedString alloc] init];
    
    int index = 0;
    while (index < [self.textToAnalyze length]){
        NSRange range;
        id value = [self.textToAnalyze attribute:attributeName atIndex:index effectiveRange:&range];
        if (value) {
            [characters appendAttributedString:[self.textToAnalyze attributedSubstringFromRange:range]];
            index = range.location + range.length;
        }
        else {
            index++;
        }
    }
    return characters;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self updateUI];
}

@end
