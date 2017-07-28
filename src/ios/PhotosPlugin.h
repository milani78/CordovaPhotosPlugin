//
//  PhotosPlugin.h
//  HelloCordova
//
//  Created by Inga on 7/26/17.
//
//

#import <Cordova/CDV.h>
#import "CustomCameraViewController.h"

@interface PhotosPlugin : CDVPlugin

@property (strong, nonatomic) CustomCameraViewController *customCameraVC;
@property (strong, nonatomic) CDVInvokedUrlCommand *latestCommand;
@property (strong, nonatomic) NSString *imageURL;
@property (nonatomic) BOOL hasPendingOperation;

- (void)openCamera:(CDVInvokedUrlCommand *)command;

- (void)capturedImageWithPath:(NSString *)imagePath;

- (void)saveToCameraRoll:(CDVInvokedUrlCommand*)command;

- (void)saveTodaysDate:(CDVInvokedUrlCommand *)command;

- (void)writeToDocuments:(NSString *)dateStr;


@end
