MyDeviceLogApp
==============

Week 4

<object width="640" height="360"><param name="movie" value="http://www.youtube.com/v/jjGgmWezYgk&hl=en_US&feature=player_embedded&version=3"></param><param name="allowFullScreen" value="true"></param><param name="allowScriptAccess" value="always"></param><embed src="http://www.youtube.com/v/jjGgmWezYgk&hl=en_US&feature=player_embedded&version=3" type="application/x-shockwave-flash" allowfullscreen="true" allowScriptAccess="always" width="640" height="360"></embed></object>

<img src="https://www.evernote.com/shard/s71/sh/5cffde91-08c8-401d-aff5-906c9c627dc3/df924ea29bd9380fe2e9c80f4d3023b5/deep/0/Screenshot%202/8/13%2010:57%20AM.jpg" alt="Screenshot%202/8/13%2010:57%20AM" />

This app shows how to convert an iPhone app into an Universal App. Here are the specifics of the app:

Description of the app:

    1) Creates a log file displaying "[iPad or iPhone] access log [Date and time]"
    2) Allows user to add messages to the log
    3) Allows user the option to clear all logs
    
    This app uses the filecreate option of objective C and actually saves a file to the ios Documents Path found 
    in the Application Directory of your Mac.
    
    Mac : 
     Go > Go to Folder > Type: ~/Library and click GO > Application Support > iPhone Simulator > [Version] 
      > Applications > [App Version Folder] > Documents > data.txt
    
    iOS
     /var/mobile/Applications/<application_id>/Documents/data.txt
          
Create app:

1) Create a new single view iPhone App
    Product Name: MyDeviceLogApp
    Class Sequence: MyDeviceLogApp
    
2) Convert to Universal App
    Click on your project under TARGETS
    Change DEVICES from iPhone to Universal
    
3) Click on nib and add objects, adjust layout for iPad or iPhone:


   a) Add Objects see screenshot: 
   
  
   <img src="https://www.evernote.com/shard/s71/sh/16f18db7-2c8f-4e46-a7df-1080ed2c50b6/d830ad37e13cbe5f7708dd65286ebe0a/deep/0/Screenshot%202/8/13%2012:00%20PM.jpg" alt="Screenshot%202/8/13%2012:00%20PM" />
   
  
   b) Uncheck AutoLayout: 
  
   <img src="https://www.evernote.com/shard/s71/sh/f82d44e0-939c-47be-9bfb-2f4feaa67213/790eb5fd375538f4500d8f97e400e44d/deep/0/Screenshot%202/8/13%2012:10%20PM.jpg" alt="Screenshot%202/8/13%2012:10%20PM" />
   
  
   c) Dock Objects: 
  
   <img src="https://www.evernote.com/shard/s71/sh/f82d44e0-939c-47be-9bfb-2f4feaa67213/790eb5fd375538f4500d8f97e400e44d/deep/0/Screenshot%202/8/13%2012:10%20PM.jpg" alt="Screenshot%202/8/13%2012:10%20PM" />
   
   <img src="https://www.evernote.com/shard/s71/sh/0616b16f-2eb8-4177-b21f-20c149806f1f/55ec532fdb2e474f54cb8635818fa2e5/deep/0/Screenshot%202/8/13%2012:16%20PM.jpg" alt="Screenshot%202/8/13%2012:16%20PM" />
   
   <img src="https://www.evernote.com/shard/s71/sh/3f58a026-6923-4f93-9702-f5f8232f99eb/a545dc8ee30ab8bf21e56b64810f39b9/deep/0/Screenshot%202/8/13%2012:18%20PM.jpg" alt="Screenshot%202/8/13%2012:18%20PM" />
    
   <img src="https://www.evernote.com/shard/s71/sh/0ab07697-9251-4806-ada4-37d905e09bc7/2829c4306c2f95e6187b1fb70b2ea5ed/deep/0/Screenshot%202/8/13%2012:19%20PM.jpg" alt="Screenshot%202/8/13%2012:19%20PM" />
    
   <img src="https://www.evernote.com/shard/s71/sh/a61525d4-d445-42be-9fb6-1e03a0453199/06bcc8054a926fe29e97ea29f212e03a/deep/0/Screenshot%202/8/13%2012:21%20PM.jpg" alt="Screenshot%202/8/13%2012:21%20PM" />
  
    
4) MyDeviceLogAppViewController.h: Add needed initializers

    @interface MyDeviceLogAppViewController : UIViewController
    //READ WRITE FILE
    -(NSString *) documentsPath;
    -(NSString *) readFromFile:(NSString *) filePath;
    -(void) writeToFile:(NSString *) text
           withFileName:(NSString *) filePath;
    //Create Outlet for txtField
    @property (retain, nonatomic) IBOutlet UITextField *txtData;
    //Create Outlet for txtVieew
    @property (retain, nonatomic) IBOutlet UITextView *txtViewData;
    //Create Action for Submit Button
    - (IBAction)btnSave:(id)sender;
     //Create Action for txtField to hide keyboard
    - (IBAction)txtDataReturn:(id)sender;
     //Create Action for Clear Button
    - (IBAction)btnClear:(id)sender;
    @end
    
5) Connect your Outlets and Actions to FileOwner for textfield, textview, and buttons

6) Connect Outlet for view  

7) MyiPhoneAppViewController.m: Add @sythesize 

    //@sythesize
    @synthesize txtData;
    @synthesize txtViewData;
    
    //correct the dealloc. Delete the _ 
    - (void)dealloc {
    [txtData release]; // 
    [txtViewData release];
    [super dealloc];

8) MyiPhoneAppViewController.m: Add code for filecreate and read 

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
    
9) MyiPhoneAppViewController.m : add code for ViewDidLoad

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

10) MyiPhoneAppViewController.m : Hide Keyboard for return in textdfield or touching the view


    - (IBAction)txtDataReturn:(id)sender {
        [sender resignFirstResponder];
    }
    - (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
    {
        [txtData resignFirstResponder];
         [txtViewData resignFirstResponder];
    }

11) MyiPhoneAppViewController.m: Submit button logic

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


12) MyiPhoneAppViewController.m : Clear button logic

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

13) Test...Done!


