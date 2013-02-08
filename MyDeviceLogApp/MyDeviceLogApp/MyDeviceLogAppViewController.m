//
//  MyDeviceLogAppViewController.m
//  MyDeviceLogApp
//
//  Created by Charles Konkol on 2/8/13.
//  Copyright (c) 2013 RVC Student. All rights reserved.
//

#import "MyDeviceLogAppViewController.h"

@interface MyDeviceLogAppViewController ()

@end

@implementation MyDeviceLogAppViewController
//@sythesize
@synthesize txtData;
@synthesize txtViewData;

//Form level variables
NSString *fileContent;
NSString *Platform;

//---finds the path to the application’s Documents folder---
-(NSString *) documentsPath {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(
                                                         NSDocumentDirectory, NSUserDomainMask, YES); NSString *documentsDir = [paths objectAtIndex:0];
    return documentsDir; }

//---write content into a specified file path---
-(void) writeToFile:(NSString *) text withFileName:(NSString *) filePath {
    NSMutableArray *array = [[NSMutableArray alloc] init]; [array addObject:text];
    [array writeToFile:filePath atomically:YES];
    [array release];
}

//---read content from a specified file path---
-(NSString *) readFromFile:(NSString *) filePath {
    //—-check if file exists—-
    if ([[NSFileManager defaultManager] fileExistsAtPath:filePath]) {
        NSArray *array =
        [[NSArray alloc] initWithContentsOfFile: filePath];
        NSString *data =
        [NSString stringWithFormat:@"%@",
         [array objectAtIndex:0]];
        [array release];
        return data;
    }
    else
        return nil;
}

- (void)viewDidLoad
{
#if (__IPHONE_OS_VERSION_MAX_ALLOWED >= 30200)
    //Date to write
    CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), CFTimeZoneCopySystem());
    NSString *strDate = [NSString stringWithFormat:@"%02d/%02d %02d:%02d:%2.0f", currentDate.month,currentDate.day,currentDate.hour, currentDate.minute, currentDate.second];
    NSString *str;
    if (UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiomPad) {
        str = [@"iPad Access Log: " stringByAppendingString:strDate];
        Platform=@"iPad Access Log: ";
    } else {
        str = [@"iPhone Access Log: " stringByAppendingString:strDate];
        Platform=@"iPhone Access Log ";
    }
    //output window
    NSLog(@"%@",str);
    
#endif
    
    // Do any additional setup after loading the view, typically from a nib.
    //---formulate filename---
    NSString *fileContents;
    NSString *fileNames =
    //Get doc path to write
    [[self documentsPath] stringByAppendingPathComponent:@"data.txt"];
    //Read doc into fileContents
    fileContents = [self readFromFile:fileNames];
    //Concatenate existing file with new
    fileContents = [NSString stringWithFormat:@"%@\r%@", fileContents,str];
    //write files
    [self writeToFile:fileContents withFileName:fileNames];
    //fill bottom text with data
    txtViewData.text = fileContents;
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc {
    [txtData release];
    [txtViewData release];
    [super dealloc];
}


- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [txtData resignFirstResponder];
    [txtViewData resignFirstResponder];
}

- (IBAction)txtDataReturn:(id)sender {
      [sender resignFirstResponder];
}

- (IBAction)btnSave:(id)sender {
    //---formulate filename---
    NSString *fileContents;
    //Path to file going to write and read to
    NSString *fileName =
    [[self documentsPath] stringByAppendingPathComponent:@"data.txt"];
    //Read file
    fileContents = [self readFromFile:fileName];
    //Concatenate string with newlline \r
    fileContents = [NSString stringWithFormat:@"%@\r%@", fileContents,txtData.text];
    //load new data in bottom textview
    txtViewData.text = fileContents;
    //write to file
    [self writeToFile:fileContents withFileName:fileName];
    //---read it back---
    //---display the content read in the Debugger Console window---
    NSLog(@"%@",txtViewData.text);
    //hide keyboard
    [txtData resignFirstResponder];
    //clear top textview after user presses OK button
    txtData.text=@"";
}
- (IBAction)btnClear:(id)sender {
    //Date
    CFGregorianDate currentDate = CFAbsoluteTimeGetGregorianDate(CFAbsoluteTimeGetCurrent(), CFTimeZoneCopySystem());
    //format date string
    NSString *strDate = [NSString stringWithFormat:@"%02d/%02d %02d:%02d:%2.0f", currentDate.month,currentDate.day,currentDate.hour, currentDate.minute, currentDate.second];
    //clear data
    txtViewData.text =@"";
    NSString *fileName =
    [[self documentsPath] stringByAppendingPathComponent:@"data.txt"];
    //Concatenate string
    NSString *StrPlatform =  [NSString stringWithFormat:@"%@%@", Platform,strDate];
    //write
    [self writeToFile:StrPlatform withFileName:fileName];
    //LOg
    NSLog(@"%@",@"Clear Log");
    //load data in textview
    txtViewData.text =StrPlatform;
}

@end
