//
//  CustomCameraViewController.m
//  CordovaApp
//
//  Created by Inga on 7/27/17.
//
//

#import "CustomCameraViewController.h"
#import "PhotosPlugin.h"

@interface CustomCameraViewController ()

@end

@implementation CustomCameraViewController


- (void)viewDidLoad {
    
    [super viewDidLoad];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    if (self) {

        self.picker = [[UIImagePickerController alloc] init];
        self.picker.sourceType = UIImagePickerControllerSourceTypeCamera;
        self.picker.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
        self.picker.cameraDevice = UIImagePickerControllerCameraDeviceRear;
        self.picker.showsCameraControls = NO;
        self.picker.delegate = self;
        
        // Set the frames to be full screen
        CGRect screenFrame = [[UIScreen mainScreen] bounds];
        self.view.frame = screenFrame;
        self.picker.view.frame = screenFrame;
        
        // Set this VC's view as the overlay view for the UIImagePickerController
        self.picker.cameraOverlayView = self.view;
    }
    
    return self;
    
}


- (IBAction)takePhotoButtonPressed:(id)sender forEvent:(UIEvent *)event {
    
     NSLog(@"IN takePhotoButtonPressed METHOD");
    [self.picker takePicture];
    
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    
    // Get a reference to the captured image
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    
    // Get a file path to save the JPEG
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *filename = [[NSUUID UUID] UUIDString];;
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:filename];
    
    // Get the image data (blocking; around 1 second)
    NSData *imageData = UIImageJPEGRepresentation(image, 0.5);
    
    // Write the data to the file
    [imageData writeToFile:imagePath atomically:YES];
    
    // Tell the plugin class that we're finished processing the image
    [self.photosPlugin capturedImageWithPath:imagePath];
    
}


- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
}


@end
