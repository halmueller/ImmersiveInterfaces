//
//  DetailViewController.m
//  Voices demo
//
//  Created by Hal Mueller on 4/15/14.
//  Copyright (c) 2014 Mobile Geographics. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()
- (void)configureView;
@property (strong, nonatomic) AVSpeechSynthesizer *speechSynthesizer;
@end

@implementation DetailViewController

- (AVSpeechSynthesizer *)speechSynthesizer
{
    if (!_speechSynthesizer) {
        _speechSynthesizer = [[AVSpeechSynthesizer alloc] init];
    }
    return _speechSynthesizer;
}

#pragma mark - Managing the detail item

- (void)setSelectedVoice:(id)newDetailItem
{
    if (_selectedVoice != newDetailItem) {
        _selectedVoice = newDetailItem;

    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    NSLog(@"%f %f %f", AVSpeechUtteranceMinimumSpeechRate, AVSpeechUtteranceDefaultSpeechRate, AVSpeechUtteranceMaximumSpeechRate);
    self.rateLabel.text = [NSString stringWithFormat:@"%f", self.rateSlider.value];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    if (self.selectedVoice) {
        self.detailDescriptionLabel.text = [self.selectedVoice description];
    }
    self.rateSlider.minimumValue = AVSpeechUtteranceMinimumSpeechRate;
    self.rateSlider.maximumValue = AVSpeechUtteranceMaximumSpeechRate;
    self.rateSlider.value = AVSpeechUtteranceDefaultSpeechRate;
    self.pitchSlider.minimumValue = 0.5;
    self.pitchSlider.maximumValue = 2.0;
    self.pitchSlider.value = 1.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidAppear:(BOOL)animated
{
    // Update the view.
    [self configureView];
    [self sayIt:nil];
}
- (IBAction)changeRate:(id)sender
{
    self.rateLabel.text = [NSString stringWithFormat:@"rate: %f", self.rateSlider.value];
}

- (IBAction)changePitch:(id)sender
{
    self.pitchLabel.text = [NSString stringWithFormat:@"pitch: %f", self.pitchSlider.value];
}

- (IBAction)sayIt:(id)sender
{
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:@"You have 30 seconds remaining."];
    utterance.voice = self.selectedVoice;
    utterance.rate = self.rateSlider.value;
    utterance.pitchMultiplier = self.pitchSlider.value;
    [self.speechSynthesizer speakUtterance:utterance];
}
@end
