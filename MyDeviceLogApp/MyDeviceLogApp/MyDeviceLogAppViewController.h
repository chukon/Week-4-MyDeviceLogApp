//
//  MyDeviceLogAppViewController.h
//  MyDeviceLogApp
//
//  Created by Charles Konkol on 2/8/13.
//  Copyright (c) 2013 RVC Student. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyDeviceLogAppViewController : UIViewController
//READ WRITE FILE
-(NSString *) documentsPath;
-(NSString *) readFromFile:(NSString *) filePath;
-(void) writeToFile:(NSString *) text
       withFileName:(NSString *) filePath;
//Create Outlet for txtField
//@property (retain, nonatomic) IBOutlet UITextField *txtData;
////Create Outlet for txtVieew
//@property (retain, nonatomic) IBOutlet UITextView *txtViewData;
//Create Action for Submit Button
//- (IBAction)btnSave:(id)sender;
//Create Action for txtField to hide keyboard
//- (IBAction)txtDataReturn:(id)sender;
//Create Action for Clear Button
//- (IBAction)btnClear:(id)sender;
@property (retain, nonatomic) IBOutlet UITextField *txtData;

@property (retain, nonatomic) IBOutlet UITextView *txtViewData;
@property (retain, nonatomic) IBOutlet UIButton *btnSave;
@property (retain, nonatomic) IBOutlet UIButton *btnClear;
- (IBAction)txtDataReturn:(id)sender;

@end
