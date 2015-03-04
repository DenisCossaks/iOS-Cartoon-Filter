//
//  FilterViewController.m
//  CartoonFilter
//
//  Created by MAYA on 3/31/14.
//  Copyright (c) 2014 iMac. All rights reserved.
//

#import "FilterViewController.h"



@interface FilterViewController ()
{
    IBOutlet UIImageView * mImageView;
    
    BOOL m_bSaved;
    
    GPUImageSmoothToonFilter * selectedFilter;
    
    float value1;
    int   value2;
}

@property(nonatomic, strong) UIImage * imgFilter;

@end

@implementation FilterViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) initWithImage:(UIImage*) chooseImage
{
    if (self) {
        self.imgFilter = chooseImage;
    }
}

-(void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBarHidden = NO;
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIView * viewRight = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    
    UIButton * btnOrigin = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, 40, 30)];
    [btnOrigin setTitle:@"Origin" forState:UIControlStateNormal];
    btnOrigin.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [btnOrigin setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnOrigin addTarget:self action:@selector(onOrigin) forControlEvents:UIControlEventTouchUpInside];
    [viewRight addSubview:btnOrigin];
    
    UIButton * btnEdit = [[UIButton alloc] initWithFrame:CGRectMake(40, 0, 40, 30)];
    [btnEdit setTitle:@"Filter" forState:UIControlStateNormal];
    btnEdit.titleLabel.font = [UIFont systemFontOfSize:12.0f];
    [btnEdit setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [btnEdit addTarget:self action:@selector(onFilter) forControlEvents:UIControlEventTouchUpInside];
    [viewRight addSubview:btnEdit];
    
    UIBarButtonItem * btnItemRight = [[UIBarButtonItem alloc] initWithCustomView:viewRight];
    self.navigationItem.rightBarButtonItem = btnItemRight;

    [mImageView setImage:self.imgFilter];
    
    m_bSaved = NO;
    
    
    selectedFilter = [[GPUImageSmoothToonFilter alloc] init];
    value1 = 0.2;
    value2 = 10;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (void) onFilter
{
/*
    CGRect frame = CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height);
    GPUImageView * mImageView2 = [[GPUImageView alloc] initWithFrame:frame];
    [self.view addSubview:mImageView2];
    
    
    GPUImagePicture* gpuImage = [[GPUImagePicture alloc] initWithImage:self.imgFilter];
    
    GPUImageBilateralFilter * filter1 = [[GPUImageBilateralFilter alloc] init];
    filter1.distanceNormalizationFactor = 1.0;
    GPUImageUnsharpMaskFilter * filter2 = [[GPUImageUnsharpMaskFilter alloc] init];
//    filter2.blurRadiusInPixels = 10.0f;
    filter2.intensity = 1.0f;
    
    GPUImageSharpenFilter * filter3 = [[GPUImageSharpenFilter alloc] init];
    filter3.sharpness = 0.0f;
    
    
    [gpuImage addTarget:filter1];
    [filter1 addTarget:filter2];
    [filter2 addTarget:filter3];
    [filter2 addTarget:mImageView2];
    
    [gpuImage processImage];
*/
    
    
//    selectedFilter.threshold = 0.5f;
//    selectedFilter.quantizationLevels = 8.0f;
//    selectedFilter.blurRadiusInPixels = 1.5;


    UIImage *filteredImage = [selectedFilter imageByFilteringImage:self.imgFilter];
    [mImageView setImage:filteredImage];
    
//    [self saveImageToAlbum:filteredImage];
    
}
-(void) onOrigin
{
    [mImageView setImage:self.imgFilter];
}

-(void) onChange
{
    selectedFilter.threshold = value1;
    selectedFilter.quantizationLevels = value2;
    
    UIImage *filteredImage = [selectedFilter imageByFilteringImage:self.imgFilter];
    [mImageView setImage:filteredImage];
    
}

-(IBAction) onthreshold:(id) sender
{
    value1 = ((UISlider*) sender).value;
    
    [self onChange];
}

-(IBAction) onColorLevel:(id)sender
{
    value2 = (int)((UISlider*) sender).value;

        [self onChange];
}


- (IBAction)saveImageToAlbum:(UIImage*) saveImg
{
    if (!m_bSaved) {
        UIImageWriteToSavedPhotosAlbum(saveImg, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    }
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error contextInfo:(void *)contextInfo
{
    NSString *alertTitle;
    NSString *alertMessage;
    
    if(!error)
    {
        alertTitle   = @"Image Saved";
        alertMessage = @"Image saved to photo album successfully.";
        
        m_bSaved = YES;
    }
    else
    {
        alertTitle   = @"Error";
        alertMessage = @"Unable to save to photo album.";
    }
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:alertTitle
                                                    message:alertMessage
                                                   delegate:self
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
    [alert show];
}

@end
