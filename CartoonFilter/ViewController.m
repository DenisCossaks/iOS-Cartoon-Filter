//
//  ViewController.m
//  CartoonFilter
//
//  Created by MAYA on 3/31/14.
//  Copyright (c) 2014 iMac. All rights reserved.
//

#import "ViewController.h"

#import "FilterViewController.h"



@interface ViewController ()<UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIActionSheetDelegate>

@property (nonatomic, strong) UIImage * chooseImage;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = YES;
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction) onTakeImage:(id)sender
{
    UIActionSheet* action = [[UIActionSheet alloc] initWithTitle:@"Choose Image" delegate:self
                                               cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil
                                               otherButtonTitles:@"Camera", @"Gallery", nil];
    action.tag = 1989;
    [action showInView:[self.view window]];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.tag == 1989) {
        if (buttonIndex == 0) { // Camera
            [self onCamera];
        }
        else if (buttonIndex == 1) {//Gallery
            [self onPhoto];
        }
    }
}
-(IBAction) onShowImages:(id)sender
{
    
}


-(void) onCamera
{
    if( ![UIImagePickerController isCameraDeviceAvailable: UIImagePickerControllerCameraDeviceFront ])
        return;
    
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypeCamera;
//    [imagePicker setAllowsEditing:YES];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

-(void) onPhoto
{
    UIImagePickerController* imagePicker = [[UIImagePickerController alloc] init];
    imagePicker.delegate = self;
    imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
//    [imagePicker setAllowsEditing:YES];
    
    [self presentViewController:imagePicker animated:YES completion:nil];
}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(NSDictionary *)editingInfo
{
    self.chooseImage = [image copy];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
    [self gotoNext];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(void) gotoNext
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main_iPhone" bundle:nil];
    FilterViewController *yourViewController = (FilterViewController *)[storyboard instantiateViewControllerWithIdentifier:@"FilterViewController"];

    [yourViewController initWithImage:self.chooseImage];
    
    [self.navigationController pushViewController:yourViewController animated:YES];

}
@end
