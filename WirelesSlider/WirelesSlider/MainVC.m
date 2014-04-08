//
//  MainVC.m
//  WirelesSlider
//
//  Created by Dan Moore on 4/8/14.
//  Copyright (c) 2014 Dan Moore. All rights reserved.
//

#import "MainVC.h"
#import "AppDelegate.h"

@interface MainVC ()

// a refernce to the global multipeer object
@property (strong, nonatomic) AppDelegate *appDelegate;

// UI
@property (strong, nonatomic) UISlider *slider;
@property (strong, nonatomic) UILabel *myLabel;
@property (strong, nonatomic) UILabel *theirLabel;
@property (strong, nonatomic) UIButton *browseButton;

@end

@implementation MainVC

@synthesize appDelegate;

#pragma mark ____Lifecycle

-(void)viewDidLoad
{
    [super viewDidLoad];
    
    // create subviews
    [self.view addSubview:self.slider];
    [self.view addSubview:self.myLabel];
    [self.view addSubview:self.theirLabel];
    [self.view addSubview:self.browseButton];
    
    // autolayout subviews
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(_slider, _myLabel, _browseButton);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"|-[_slider]-|" options:0 metrics:nil views:viewsDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-40-[_slider]-[_myLabel]" options:NSLayoutFormatAlignAllCenterX metrics:nil views:viewsDictionary]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.theirLabel attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.theirLabel attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0.0]];
    [self.view addConstraint:[NSLayoutConstraint constraintWithItem:self.view attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.browseButton attribute:NSLayoutAttributeCenterX multiplier:1.0 constant:0.0]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:[_browseButton]-|" options:0 metrics:nil views:viewsDictionary]];
    
    
    // setup multipeer object
    self.appDelegate = (AppDelegate *) [[UIApplication sharedApplication] delegate];
    [self.appDelegate.mpcHandler setupPeerWithDisplayName:[UIDevice currentDevice].name];
    [self.appDelegate.mpcHandler setupSession];
    [self.appDelegate.mpcHandler advertiseSelf:YES];
}

#pragma mark ____UIConnections

- (void)updateLabel:(UISlider *)sender
{
    self.myLabel.text = [NSString stringWithFormat:@"%0.2f", sender.value];
}

- (void)browsePushed
{
    [self.appDelegate.mpcHandler setupBrowser];
    [self presentViewController:self.appDelegate.mpcHandler.browser animated:YES completion:nil];
    
}

#pragma mark ____Lazy

// I would like to send these values to a friend...
-(UISlider *)slider
{
    if(!_slider) {
        _slider = [[UISlider alloc] init];
        _slider.translatesAutoresizingMaskIntoConstraints = NO;
        _slider.minimumValue = 0.0f;
        _slider.maximumValue = 1.0f;
        _slider.value = 0.5f;
        [_slider addTarget:self action:@selector(updateLabel:) forControlEvents:UIControlEventValueChanged];
    }
    return _slider;
}

// this will display the value of our own slider
-(UILabel *)myLabel
{
    if(!_myLabel) {
        _myLabel = [[UILabel alloc] init];
        _myLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _myLabel.text = @"0.50";
    }
    return _myLabel;
}

// this should display my friend's slider value
-(UILabel *)theirLabel
{
    if(!_theirLabel) {
        _theirLabel = [[UILabel alloc] init];
        _theirLabel.translatesAutoresizingMaskIntoConstraints = NO;
        _theirLabel.text = @"send me slider values from a peer...";
    }
    return _theirLabel;
}

// press this to look for peers
-(UIButton *)browseButton
{
    if(!_browseButton) {
        _browseButton = [UIButton buttonWithType:UIButtonTypeSystem];
        _browseButton.translatesAutoresizingMaskIntoConstraints = NO;
        [_browseButton setTitle:@"BROWSE" forState:UIControlStateNormal];
        [_browseButton addTarget:self action:@selector(browsePushed) forControlEvents:UIControlEventTouchDown];
    }
    return _browseButton;
}

@end
