//
//  FarViewController.swift
//  IOS8SwiftTabBarControllerTutorial
//
//  Created by MacBook on 4/30/17.
//  Copyright © 2017 Arthur Knopper. All rights reserved.
//

import UIKit
import CoreData
import GoogleMobileAds
import Social

class FarViewController: UIViewController ,GADNativeExpressAdViewDelegate, GADVideoControllerDelegate {
    let adUnitId = "ca-app-pub-8623108209004118/6575771983"
    let link:String="Ứng dụng Lịch cúp điện  http://itunes.apple.com/app/id1232657493"

       @IBOutlet weak var tableFar: UITableView!
    // Retreive the managedObjectContext from AppDelegate
    let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    var tableData=[TinhObj]()
    
    
    @IBAction func share_click(sender: AnyObject) {
        if SLComposeViewController.isAvailableForServiceType(SLServiceTypeFacebook) {
            let controller = SLComposeViewController(forServiceType: SLServiceTypeFacebook)
            
            controller.setInitialText(link)
            //controller.addImage(captureScreen())
            self.presentViewController(controller, animated:true, completion:nil)
        }
            
        else {
            print("no Facebook account found on device")
            var alert = UIAlertView(title: "Thông báo", message: "Bạn chưa đăng nhập facebook", delegate: nil, cancelButtonTitle: "OK")
            alert.show()
        }

        
    }
       @IBOutlet weak var nativeExpressAdView: GADNativeExpressAdView!
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
             // Create a new fetch request using the LogItem entity
        reloadTableFar()
        
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

    }


    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView!, numberOfRowsInSection section: Int) -> Int
    {
        return tableData.count
    }
      func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell : Cell2! = tableView.dequeueReusableCellWithIdentifier("Cell2") as! Cell2
        if(cell == nil)
        {
            cell = NSBundle.mainBundle().loadNibNamed("Cell2", owner: self, options: nil)[0] as! Cell2;
        }
        let stringTitle = tableData[indexPath.row]._tinhdau as String //NOT NSString
        //let ngay = list[indexPath.row]._ngay as String //NOT NSString
        cell.lbtinh.text=stringTitle
        cell.actione_del.tag=indexPath.row
            cell.actione_del .addTarget(self, action: "yourButtonClicked:", forControlEvents: UIControlEvents.TouchUpInside)
        return cell as Cell2
    }
    
    func yourButtonClicked(button: UIButton!)
    {
        let buttonRow = button.tag
        print("click \(buttonRow)")
        let tinhid=tableData[buttonRow]._tinhdau as String
        print("tinhid " + tinhid)
        del(tinhid)
       reloadTableFar()
    }
    
    func del(tinhid:String)
    {
        var request=NSFetchRequest(entityName: "LogItem")
                request.returnsObjectsAsFaults=false
        
                request.predicate=NSPredicate(format:"title=%@",""+tinhid)
        
               if let results = (try? managedObjectContext!.executeFetchRequest(request)) as? [LogItem] {
                if results.count>0{
                    //for res in results{
                    //    println(res)
                    var res=results[0] as NSManagedObject
                               managedObjectContext!.deleteObject(res)
        
                    //}
        
                }else{
                    print("0 results or potential error")
                }
                
                    print("deleted:"+tinhid)
                }

    }
    func reloadTableFar()
    {
        let fetchRequest = NSFetchRequest(entityName: "LogItem")
        
        // Execute the fetch request, and cast the results to an array of LogItem objects
        if let fetchResults = (try? managedObjectContext!.executeFetchRequest(fetchRequest)) as? [LogItem] {
            
            //            // Create an Alert, and set it's message to whatever the itemText is
            //            let alert = UIAlertController(title: fetchResults[0].title,
            //                message: fetchResults[0].itemText,
            //                preferredStyle: .Alert)
            //            alert.addAction(UIAlertAction(title: "No", style: UIAlertActionStyle.Cancel, handler: nil));
            //            //event handler with closure
            //            alert.addAction(UIAlertAction(title: "Yes", style: UIAlertActionStyle.Default, handler: {(action:UIAlertAction) in
            //                //let fields = alert.textFields!;
            //                //print("Yes we can: "+fields[0].text!);
            //            }));
            //            // Display the alert
            //
            ////            self.presentViewController(alert,
            ////            animated: true,
            ////            completion: nil)
            //
            print("size \(fetchResults.count)")
            tableData.removeAll()
            for tinh in fetchResults
            {
                print(tinh.title)
                let tinh:TinhObj=TinhObj(id: tinh.itemText,tinh: tinh.title,ngay: "")
                tableData.append(tinh)
            }
            self.tableFar .reloadData()
        }

    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?)
    {
        if segue.identifier == "Far2web"
        {
            let detailViewController = ((segue.destinationViewController) as! WebviewController)
            
            let indexPath = self.tableFar!.indexPathForSelectedRow!
            let tinhobj = tableData[indexPath.row]
            detailViewController.tinhobj=tinhobj
        }
    }

}
