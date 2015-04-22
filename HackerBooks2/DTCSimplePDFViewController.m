//
//  DTCSimplePDFViewController.m
//  HackerBooks2
//
//  Created by David de Tena on 21/04/15.
//  Copyright (c) 2015 David de Tena. All rights reserved.
//

#import "DTCSimplePDFViewController.h"
#import "DTCBook.h"
#import "DTCPdf.h"

@interface DTCSimplePDFViewController ()

// Queue for NSURLSession tasks
@property (strong,nonatomic) NSOperationQueue *delegateQueue;
// Tasks for NSURLSession
@property (strong,nonatomic) NSURLSessionDownloadTask *task;
@property (strong,nonatomic) NSURLSession *downloadSession;

@property (strong,nonatomic) NSURL *urlToDownload;

@end

@implementation DTCSimplePDFViewController


#pragma mark - Init
-(id) initWithModel:(DTCBook *)model{
    if (self = [super initWithNibName:nil bundle:nil]) {
        _model = model;
        self.title = model.title;
        
        // Set delegate
        self.browser.delegate = self;
    }
    return self;
}

#pragma mark - View Lifecycle
-(void) viewDidLoad{
    [super viewDidLoad];
    
    
     // Si no hay datos de pdf en el libro configuramos session
     if (!self.model.pdf.pdfData) {
         NSLog(@"No hay datos de pdf");
    
         // New instance for the delegateQueue of NSURLSession
         self.delegateQueue = [[NSOperationQueue alloc] init];
         
         [self setupDownloadSession];
         self.urlToDownload = [NSURL URLWithString:self.model.pdf.url];
     
         NSLog(@"URL del pdf: %@", [self.urlToDownload path]);
         self.task = [self.downloadSession downloadTaskWithURL:self.urlToDownload];
         [self.task resume];
     
     }
     else{
         NSLog(@"Hay datos de pdf");
     }
}

-(void) viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
    // Make sure the view not to use the whole screen when embeded in navs or tabbar
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    // Sets up Navigation buttons
    [self setupButtons];
    [self enableLoadingStatus];
}

- (void) didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark - UI configuration

// Sets up two buttons for the right bar button items in Nav.Controller
-(void) setupButtons{
    UIBarButtonItem *newAnnotationButton = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemCompose
                                            target:self
                                            action:@selector(presentNewAnnotationModally)];
    self.navigationItem.rightBarButtonItem = newAnnotationButton;
    
}


// Takes pdf from local or remote and displays on the browser.
-(void) syncWithModel{
    
    /*
     [self enableLoadingStatus];
     
     // Si no hay datos de pdf, los cargamos
     if (!self.model.pdf.pdfData) {
     // Sessions
     [self setupDownloadSession];
     }
     else{
     [self displayPdfInBrowser];
     }
     */
}

// Displays pdf in browser
-(void) displayPdfInBrowser{
    
    [self disableLoadingStatus];
    [self.browser loadData:self.model.pdf.pdfData
                  MIMEType:@"application/pdf"
          textEncodingName:@"utf-8"
                   baseURL:self.urlToDownload];
    
}


// Make activity view and "loading" lable visible. AV starts animating
-(void) enableLoadingStatus{
    self.activityView.hidden = NO;
    [self.activityView startAnimating];
    
    self.loadingLabel.hidden = NO;
}

// Make activity view and "loading" lable hidden. AV stops animating
-(void) disableLoadingStatus{
    self.activityView.hidden = YES;
    [self.activityView stopAnimating];
    
    self.loadingLabel.hidden = YES;
}




-(void) setupDownloadSession{
    
    // Default configuration for NSURLSession
    NSURLSessionConfiguration *configuration = [NSURLSessionConfiguration defaultSessionConfiguration];
    
    // Create session whith this VC as NSURLSession delegate
    self.downloadSession = [NSURLSession sessionWithConfiguration:configuration
                                                         delegate:self
                                                    delegateQueue:self.delegateQueue];
}


#pragma mark - UIWebViewDelegate
- (void) webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error{
    [self disableLoadingStatus];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"ERROR"
                                                    message:@"Error while loading url in browser"
                                                   delegate:nil
                                          cancelButtonTitle:nil
                                          otherButtonTitles:@"Done", nil];
    [alert show];
}


- (void) webViewDidFinishLoad:(UIWebView *)webView{
    [self disableLoadingStatus];
}


- (BOOL) webView:(UIWebView *)webView
shouldStartLoadWithRequest:(NSURLRequest *)request
  navigationType:(UIWebViewNavigationType)navigationType{
    
    // Disable links within the pdf
    if(navigationType == UIWebViewNavigationTypeLinkClicked){
        return NO;
    }
    return YES;
}



#pragma mark - NSURLSessionDownloadDelegate
// Download progress
-(void) URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
      didWriteData:(int64_t)bytesWritten
 totalBytesWritten:(int64_t)totalBytesWritten
totalBytesExpectedToWrite:(int64_t)totalBytesExpectedToWrite{
    
    NSLog(@"Session %@ in progress!",session);
}

// Download progress when resumed
-(void) URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
 didResumeAtOffset:(int64_t)fileOffset
expectedTotalBytes:(int64_t)expectedTotalBytes{
    
    NSLog(@"Session %@ resumed!",session);
}

// Download finished
-(void) URLSession:(NSURLSession *)session
      downloadTask:(NSURLSessionDownloadTask *)downloadTask
didFinishDownloadingToURL:(NSURL *)location{
    
    NSLog(@"Session %@ finished!",session);
    
    // Estamos en cola no principal => movemos fichero temporal
    // descargado al pdf del libro y actualizamos interfaz en
    // primer plano
    
    NSData *pdfData = [NSData dataWithContentsOfURL:location];
    //[self.model.pdf setValue:pdfData forKey:DTCPdfAttributes.pdfData];
    //self.model.pdf.pdfData = pdfData;
    
    // Paramos y ocultamos activity view y mostramos pdf en
    // cola principal porque son tareas de UIKit
    dispatch_async(dispatch_get_main_queue(), ^{

        // EL NAVEGADOR NO MUESTRA EL PDF TRAS DESCARGARSE CON
        // NSURLSESSION
        [self disableLoadingStatus];
        [self.browser loadData:pdfData
                      MIMEType:@"application/pdf"
              textEncodingName:@"UTF-8"
                       baseURL:self.urlToDownload];
    });
}


-(void) URLSession:(NSURLSession *)session
              task:(NSURLSessionTask *)task
didCompleteWithError:(NSError *)error{
    
    if (error) {
        NSLog(@"Error in session %@\n%@",session,error.localizedDescription);
    }
    else{
        NSLog(@"Session %@ finished", session);
    }
}



#pragma mark - Actions

// Create a new instance of New Annotation View and presents it modally
-(void) presentNewAnnotationModally{
    
}


@end
