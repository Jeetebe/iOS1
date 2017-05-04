//
//  WebviewController.swift
//  IOS8SwiftTabBarControllerTutorial
//
//  Created by MacBook on 4/30/17.
//  Copyright © 2017 Arthur Knopper. All rights reserved.
//
import UIKit
import CoreData
import GoogleMobileAds
import Social

class WebviewController: UIViewController , GADNativeExpressAdViewDelegate, GADVideoControllerDelegate {
    //var strtinh: String!
    var tinhobj:TinhObj!
    var listyeuthik=[TinhObj]()
    //var chua:Bool=false

    @IBOutlet weak var bannerView: GADBannerView!
    @IBOutlet weak var bttYeuthik: UIButton!
   // @IBOutlet weak var nativeExpressAdViewMedium: GADNativeExpressAdView!
    // Retreive the managedObjectContext from AppDelegate
    
    @IBAction func actionShare(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let controller = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            controller.setInitialText("Thông tin cúp điện")
            controller.addImage(captureScreen())
            self.presentViewController(controller, animated:true, completion:nil)
        }
            
        else {
            print("no Facebook account found on device")
            var alert = UIAlertView(title: "Thông báo", message: "Bạn chưa đăng nhập facebook", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

    }
    
    //@IBOutlet weak var nativeExpressAdViewMedium: GADNativeExpressAdView!
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    //let adUnitId = "ca-app-pub-8623108209004118/4361721581"//medium
    //let adUnitId = "ca-app-pub-8623108209004118/6575771983"//big
let adUnitId = "ca-app-pub-8623108209004118/8052505184"//banner
    
    @IBAction func them_yeuthik(sender: AnyObject) {
        
     
        
        if (checkchua())
        {
            print("->chua")
            bttYeuthik.setImage(UIImage(named: "Heartsempty"),forState: .Normal)
            

        }
        else
        {
            print("-> ko chua")
            bttYeuthik.setImage(UIImage(named: "Heartsfill"),forState: .Normal)
            let newItem = NSEntityDescription.insertNewObjectForEntityForName("LogItem", inManagedObjectContext: self.managedObjectContext!) as! LogItem
            
            newItem.title = tinhobj._tinhdau
            newItem.itemText = tinhobj._tinhid
        }
      
        
    }
    
    @IBOutlet weak var lbTinhTitle: UILabel!
    @IBAction func bactionback(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)

    }
       var url = "http://123.30.100.126:8081/weblogalarm/lichmatdienv3.1.jsp?huyenid=toantinh&device=ios&tinhid="
    @IBOutlet weak var mywebview: UIWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(tinhobj._tinhid)
        lbTinhTitle.text=tinhobj._tinhdau
        url=url+tinhobj._tinhid
        //print(url)
        
        let requestURL = NSURL(string:url)
        let request = NSURLRequest(URL: requestURL!)
        
        mywebview.loadRequest(request)
        
        
        if (checkchua())
        {
            bttYeuthik.setImage(UIImage(named: "Heartsfill"),forState: .Normal)

        }
        else
        {
             bttYeuthik.setImage(UIImage(named: "Heartsblank"),forState: .Normal)
        }
        
        //admod
//        nativeExpressAdViewMedium.adUnitID = adUnitId
//        nativeExpressAdViewMedium.rootViewController = self
//        nativeExpressAdViewMedium.delegate = self
        
        // The video options object can be used to control the initial mute state of video assets.
        // By default, they start muted.
//        let videoOptions = GADVideoOptions()
//        videoOptions.startMuted = false
//        nativeExpressAdViewMedium.setAdOptions([videoOptions])
        
        // Set this UIViewController as the video controller delegate, so it will be notified of events
        // in the video lifecycle.
        //nativeExpressAdViewMedium.videoController.delegate = self
        
        
//        let request2 = GADRequest()
//        print("request ads")
//        request2.testDevices = [kGADSimulatorID]
//        nativeExpressAdViewMedium.loadRequest(request2)
        
        print("Google Mobile Ads SDK version: \(GADRequest.sdkVersion())")
        bannerView.adUnitID = adUnitId
        //bannerView = GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        bannerView.rootViewController = self
        bannerView.loadRequest(GADRequest())

        
    }
    // MARK: - GADNativeExpressAdViewDelegate
    
//    func nativeExpressAdViewDidReceiveAd(_ nativeExpressAdView: GADNativeExpressAdView) {
//        if nativeExpressAdViewMedium.videoController.hasVideoContent() {
//            print("Received an ad with a video asset.")
//        } else {
//            print("Received an ad without a video asset.")
//        }
//        print("nativeExpressAdViewDidReceiveAd ads")
//
//    }
//    
//    // MARK: - GADVideoControllerDelegate
//    
//    func videoControllerDidEndVideoPlayback(_ videoController: GADVideoController) {
//        print("The video asset has completed playback.")
//    }
//    override func didReceiveMemoryWarning() {
//        super.didReceiveMemoryWarning()
//        // Dispose of any resources that can be recreated.
//    }
    func captureScreen() -> UIImage
    {
        
        UIGraphicsBeginImageContextWithOptions(self.view.bounds.size, false, 0);
        
        self.view.drawViewHierarchyInRect(view.bounds, afterScreenUpdates: true)
        
        let image: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return image
    }
    
    func checkchua()->Bool
    {
        var chua:Bool=false
        let fetchRequest = NSFetchRequest(entityName: "LogItem")
        
        listyeuthik.removeAll()
        // Execute the fetch request, and cast the results to an array of LogItem objects
        if let fetchResults = (try? managedObjectContext!.executeFetchRequest(fetchRequest)) as? [LogItem] {
            //3
            print("size \(fetchResults.count)")
            for tinh in fetchResults
            {
                print(tinh)
                if (tinh.itemText==tinhobj._tinhid)
                {
                    //bttYeuthik.setImage(UIImage(named: "Hearts-64"),forState: .Normal)
                    chua=true
                    
                }
            }
        }
        return chua

    }

}
