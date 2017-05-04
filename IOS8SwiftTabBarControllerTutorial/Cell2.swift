//
//  SampleTableViewCell.swift
//  Sample1
//
//  Created by TheAppGuruz-New-6 on 04/02/15.
//  Copyright (c) 2015 TheAppGuruz-New-6. All rights reserved.
//

import UIKit
import CoreData
class Cell2: UITableViewCell
{
     let managedObjectContext = (UIApplication.sharedApplication().delegate as! AppDelegate).managedObjectContext
    
//    @IBAction func act_del(sender: AnyObject) {
//        let newItem = NSEntityDescription.insertNewObjectForEntityForName("LogItem", inManagedObjectContext: self.managedObjectContext!) as! LogItem
//        
//        
//       
//        
//        var request=NSFetchRequest(entityName: "Users")
//        request.returnsObjectsAsFaults=false
//        
//        request.predicate=NSPredicate(format:"tinhid=%@",""+"angiang")
//        
//       if let results = (try? managedObjectContext!.executeFetchRequest(request)) as? [LogItem] {
//        if results.count>0{
//            //for res in results{
//            //    println(res)
//            var res=results[0] as NSManagedObject
//                       managedObjectContext!.deleteObject(res)
//            
//            //}
//            
//        }else{
//            print("0 results or potential error")
//        }
//        
//            print("deleted")
//        }
//
//    }
    @IBOutlet weak var lbtinh: UILabel!
    @IBOutlet weak var actione_del: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
   

}
