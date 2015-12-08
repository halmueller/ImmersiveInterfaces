//
//  DetailViewController.h
//  Voices demo
//
//  Created by Hal Mueller on 4/15/14.
//  Copyright (c) 2014 Mobile Geographics. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AVFoundation;

@interface DetailViewController : UIViewController

@property (strong, nonatomic) AVSpeechSynthesisVoice *selectedVoice;

@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;
@property (weak, nonatomic) IBOutlet UISlider *rateSlider;
@property (weak, nonatomic) IBOutlet UILabel *rateLabel;
@property (weak, nonatomic) IBOutlet UISlider *pitchSlider;
@property (weak, nonatomic) IBOutlet UILabel *pitchLabel;
- (IBAction)changeRate:(id)sender;
- (IBAction)sayIt:(id)sender;
@end
