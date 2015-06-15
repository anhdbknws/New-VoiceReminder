//
//  VRHoroscopeController.m
//  VoiceReminder
//
//  Created by GemCompany on 6/15/15.
//  Copyright (c) 2015 Owner. All rights reserved.
//

#import "VRHoroscopeController.h"

@interface VRHoroscopeController () <UIWebViewDelegate>

@end

@implementation VRHoroscopeController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.webview];
    
    [self.webview autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:0];
    [self.webview autoPinEdgeToSuperviewEdge:ALEdgeLeading withInset:0];
    [self.webview autoPinEdgeToSuperviewEdge:ALEdgeTrailing withInset:0];
    [self.webview autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:0];
    
    [self loadHoroscopeDetail];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
}

- (void)loadHoroscopeDetail {
    NSString *indexPath = [[NSBundle mainBundle] pathForResource:[NSString stringWithFormat:@"www/cung/%@", self.horoscope] ofType:@"html" inDirectory:nil];
    [self.webview loadRequest:[NSURLRequest requestWithURL:[NSURL fileURLWithPath:indexPath]]];
}

- (UIWebView *)webview {
    if (!_webview) {
        _webview = [[UIWebView alloc] initForAutoLayout];
        _webview.delegate = self;
    }
    
    return _webview;
}

- (void)webViewDidStartLoad:(UIWebView *)webView {
    
}

- (void)webViewDidFinishLoad:(UIWebView *)webView {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
