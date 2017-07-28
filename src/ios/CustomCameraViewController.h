//
//  CustomCameraViewController.h
//  CordovaApp
//
//  Created by Inga on 7/27/17.
//
//

#import <UIKit/UIKit.h>

@class PhotosPlugin;

@interface CustomCameraViewController : UIViewController  <UIImagePickerControllerDelegate, UINavigationControllerDelegate>

@property (strong, nonatomic) PhotosPlugin *photosPlugin;
@property (strong, nonatomic) UIImagePickerController *picker;

- (IBAction)takePhotoButtonPressed:(id)sender forEvent:(UIEvent *)event;


@end
