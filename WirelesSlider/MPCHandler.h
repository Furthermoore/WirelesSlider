//
//  MPCHandler.h
//  Oscilloscope
//
//  Created by Dan Moore on 4/6/14.
//  Copyright (c) 2014 Dan Moore. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MultipeerConnectivity/MultipeerConnectivity.h>

@interface MPCHandler : NSObject <MCSessionDelegate, MCBrowserViewControllerDelegate>

@property (nonatomic, strong) MCPeerID *peerID;
@property (nonatomic, strong) MCSession *session;
@property (nonatomic, strong) MCBrowserViewController *browser;
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;

- (void)setupPeerWithDisplayName:(NSString *)displayName;
- (void)setupSession;
- (void)setupBrowser;
- (void)advertiseSelf:(BOOL)advertise;

@end
