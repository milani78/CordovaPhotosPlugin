//
//  PhotosPlugin.m
//  HelloCordova
//
//  Created by Inga on 7/26/17.
//
//

#import <Cordova/CDV.h>
#import "PhotosPlugin.h"

@implementation PhotosPlugin


#pragma mark - Camera Methods

- (void)openCamera:(CDVInvokedUrlCommand *)command {
    
    NSLog(@"IN openCamera METHOD");
    
    // Set the hasPendingOperation field to prevent the webview from crashing
    self.hasPendingOperation = YES;
    
    // Save the CDVInvokedUrlCommand as a property. We will need it later.
    self.latestCommand = command;
    
    // Make the overlay view controller.
    self.customCameraVC = [[CustomCameraViewController alloc] initWithNibName:@"CustomCameraViewController" bundle:nil];
    self.customCameraVC.photosPlugin = self;
    
    [self.viewController presentViewController:self.customCameraVC.picker animated:YES completion:nil];

}


- (void)capturedImageWithPath:(NSString *)imagePath {

    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:[NSString stringWithFormat:@"%@/%@", @"file://", imagePath]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:self.latestCommand.callbackId];
    
    // Capturing the image path to save it to the camera roll
    self.imageURL = [NSString stringWithFormat:@"%@/%@", @"file://", imagePath];
    
    // Reset the self.hasPendingOperation property
    self.hasPendingOperation = NO;
    
    [self.viewController dismissViewControllerAnimated:YES completion:nil];
    
}


- (void)saveToCameraRoll:(CDVInvokedUrlCommand*)command {
    
    NSString *imageURL = [command argumentAtIndex:0];
    NSLog(@"IN saveToCameraRoll METHOD argumentAtIndex:0: %@", imageURL);
    
    NSURL *url = [NSURL URLWithString:imageURL];
    NSData *imageData = [NSData dataWithContentsOfURL:url];
    UIImage *image = [UIImage imageWithData:imageData scale:0.2];
    UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK messageAsString:@"Image saved!"];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}


#pragma mark - Writing to File Methods

- (void)saveTodaysDate:(CDVInvokedUrlCommand *)command {
        
    NSString *dateStr = [command.arguments objectAtIndex:0];
    NSString *nameStr = [command.arguments objectAtIndex:1];
    NSLog(@"IN cordovaSaveTodaysDate METHOD argumentAtIndex:0: %@", dateStr);
    NSLog(@"IN cordovaSaveTodaysDate METHOD argumentAtIndex:1: %@", nameStr);
    
    [self writeToDocuments: dateStr];
    
    CDVPluginResult *pluginResult = [CDVPluginResult resultWithStatus:CDVCommandStatus_OK
                                                      messageAsString:[NSString stringWithFormat:@"Hi, %@!", nameStr]];
    [self.commandDelegate sendPluginResult:pluginResult callbackId:command.callbackId];
    
}


- (void)writeToDocuments:(NSString *)dateStr {
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *fileName = [NSString stringWithFormat:@"%@/myTextFile.txt", documentsDirectory];
    
    [dateStr writeToFile : fileName
              atomically : NO
                encoding : NSStringEncodingConversionAllowLossy
                   error : nil];

}



@end
