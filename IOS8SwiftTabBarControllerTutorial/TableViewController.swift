//
//  TableViewController.swift
//  IOS8SwiftTabBarControllerTutorial
//
//  Created by MacBook on 4/29/17.
//  Copyright © 2017 Arthur Knopper. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds

class TableViewController: UIViewController , GADNativeExpressAdViewDelegate, GADVideoControllerDelegate {


    @IBOutlet weak var nativeExpressAdView: GADNativeExpressAdView!
    
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    //let adUnitId = "ca-app-pub-8623108209004118/6575771983"
let adUnitId = "ca-app-pub-8623108209004118/4361721581"//medium
    
    @IBOutlet weak var myTableview: UITableView!
    //var tableData = [String]()
    //var listtinhid = [String]()
    var list=[TinhObj]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Reachability.isConnectedToNetwork() == true {
            print("Internet connection OK")
            
            let urlAsString = "http://123.30.100.126:8081/Restapi/rest/lichcupdien/getdmtinhsupportios"
            let url = NSURL(string: urlAsString)!
            let urlSession = NSURLSession.sharedSession()
            
            //2
            let jsonQuery = urlSession.dataTaskWithURL(url, completionHandler: { data, response, error -> Void in
                if (error != nil) {
                    print(error!.localizedDescription)
                }
                let err: NSError?=nil
                
                // 3
                let jsonResult = (try! NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)) as! NSDictionary
                if ( err != nil) {
                    print("JSON Error \(err!.localizedDescription)")
                }
                
                // 4
                //let results: String! = jsonResult["results"] as! String
                //let jsonTime: String! = jsonResult["time"] as! String
                var results: NSArray = jsonResult["tinhsupport"] as! NSArray
                //let results = jsonResult[0] as? [[String: Any]]
                
                //print(self.names)
                //print(results)
                
                dispatch_async(dispatch_get_main_queue(), {
                    //self.dateLabel.text = jsonDate
                    //self.timeLabel.text = jsonTime
                    //self.tableData.append(tinhdau)
                    for blog in results {
                        let tinhdau = blog["tinhdau"] as? String
                        
                        let tinhid = blog["tinhid"] as? String
                        let maxdate = blog["maxdate"] as? String
                        
                        var tinh=TinhObj(id: tinhid!,tinh: tinhdau!,ngay: maxdate!)
                        self.list.append(tinh)
                    }
                    //print(self.listtinhid)
                    self.myTableview .reloadData()
                })
            })
            // 5
            jsonQuery.resume()
            
            
            //admod
            nativeExpressAdView.adUnitID = adUnitId
            nativeExpressAdView.rootViewController = self
            nativeExpressAdView.delegate = self
            
            // The video options object can be used to control the initial mute state of video assets.
            // By default, they start muted.
            let videoOptions = GADVideoOptions()
            videoOptions.startMuted = true
            nativeExpressAdView.setAdOptions([videoOptions])
            
            // Set this UIViewController as the video controller delegate, so it will be notified of events
            // in the video lifecycle.
            nativeExpressAdView.videoController.delegate = self
            
            let request = GADRequest()
            request.testDevices = [kGADSimulatorID]
            nativeExpressAdView.loadRequest(request)
            
            
        } else {
            print("Internet connection FAILED")
            var alert = UIAlertView(title: "Thông báo", message: "Vui lòng kết nối internet và thử lại", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
            
        }
        
        
               
    }
   
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - GADNativeExpressAdViewDelegate
    
    func nativeExpressAdViewDidReceiveAd(_ nativeExpressAdView: GADNativeExpressAdView) {
        if nativeExpressAdView.videoController.hasVideoContent() {
            print("Received an ad with a video asset.")
        } else {
            print("Received an ad without a video asset.")
        }
    }
    
    // MARK: - GADVideoControllerDelegate
    
    func videoControllerDidEndVideoPlayback(_ videoController: GADVideoController) {
        print("The video asset has completed playback.")
    }

    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int
    {
        return 1
    }

    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return list.count
    }
       func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : SampleTableViewCell! = tableView.dequeueReusableCellWithIdentifier("Cell") as! SampleTableViewCell
        if(cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("Cell", owner: self, options: nil)[0] as! SampleTableViewCell;
        }
        let stringTitle = list[indexPath.row]._tinhdau as String //NOT NSString
        let ngay = list[indexPath.row]._ngay as String //NOT NSString
        cell.lbtinh.text=stringTitle
        let start = ngay.startIndex
        let end = ngay.endIndex.advancedBy(-11)
        let substring = ngay[start..<end] // www.stackoverflow        
        let stt=String(indexPath.row+1)
        cell.lbstt.text=stt
        cell.lbstt.layer.cornerRadius=5
        
        cell.lbngay.text=substring
        //cell.ivPhoto.image = UIImage(named: strCarName)
        return cell as SampleTableViewCell
    }

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "DetailSegue"
        {
            let detailViewController = ((segue.destinationViewController) as! WebviewController)
           
            let indexPath = self.myTableview!.indexPathForSelectedRow!
            let tinhobj = list[indexPath.row]
                      detailViewController.tinhobj=tinhobj
        }
    }
}
