//
//  ViewController.swift
//  SwiftPrayTimes
//
//  Created by Basem Emara on 06/12/2015.
//  Copyright (c) 06/12/2015 Basem Emara. All rights reserved.
//

import UIKit
import SwiftPrayTimes

class ViewController: UITableViewController {
    
    var prayTimesData: [PrayTimes.PrayerResult]?
    
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create instance
        var prayTimes = PrayTimes(
            method: "ISNA",
            juristic: PrayTimes.AdjustmentMethod(rawValue: "Standard")
        )
        
        activityIndicator.startAnimating()
        
        // Retrieve prayer times
        prayTimes.getTimes([37.323, -122.0527], timezone: -8, dst: true, completion: {
            (times: [PrayTimes.TimeName: PrayTimes.PrayerResult]) in
            
            // Pluck only times array and sort by time
            self.prayTimesData = times.values.array.sorted {
                $0.time < $1.time
            }
            
            // Populate table again
            self.tableView.reloadData()
            
            self.activityIndicator.stopAnimating()
        })
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return prayTimesData != nil ? prayTimesData!.count : 0
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: .Value1, reuseIdentifier: "Cell")
        let time = prayTimesData?[indexPath.row]
        
        cell.textLabel?.text = time!.name
        cell.detailTextLabel?.text = time!.formattedTime
        
        return cell
    }
    
}

