//
//  MasterViewController.m
//  Voices demo
//
//  Created by Hal Mueller on 4/15/14.
//  Copyright (c) 2014 Mobile Geographics. All rights reserved.
//

#import "MasterViewController.h"

#import "DetailViewController.h"
@import AVFoundation;

@interface MasterViewController ()

@property (nonatomic, strong) NSArray *voices;

@end

@implementation MasterViewController

- (void)awakeFromNib
{
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSArray *allVoices = [AVSpeechSynthesisVoice speechVoices];
    allVoices = [allVoices filteredArrayUsingPredicate:[NSPredicate predicateWithBlock:^BOOL(id evaluatedObject, NSDictionary *bindings) {
        return [[evaluatedObject language] hasPrefix:@"en"];
    }]];
    self.voices = [allVoices sortedArrayUsingSelector:@selector(language)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.voices.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    AVSpeechSynthesisVoice *voice = self.voices[indexPath.row];
    cell.textLabel.text = voice.language;
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showDetail"]) {
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        AVSpeechSynthesisVoice *voice = self.voices[indexPath.row];
        [[segue destinationViewController] setSelectedVoice:voice];
    }
}

@end
