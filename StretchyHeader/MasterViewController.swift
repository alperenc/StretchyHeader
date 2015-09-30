//
//  MasterViewController.swift
//  StretchyHeader
//
//  Created by Alp Eren Can on 29/09/15.
//  Copyright © 2015 Alp Eren Can. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController {

    var detailViewController: DetailViewController? = nil
    var news = [NewsItem]()

    @IBOutlet weak var currentDate: UILabel!
    @IBOutlet weak var headerView: UIView!
    
    let kTableHeaderHeight: CGFloat = 240

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableView.rowHeight = UITableViewAutomaticDimension
        
        tableView.tableHeaderView = nil
        
        tableView.addSubview(headerView)
        
        updateHeaderView()
        
        navigationController?.navigationBar.hidden = true
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "MMMM dd"
        
        self.currentDate.text = dateFormatter.stringFromDate(NSDate())
            
        news = [NewsItem(category: .World, headline: "Climate change protests, divestments meet fossil fuels realities"),
                NewsItem(category: .Europe, headline: "Scotland's 'Yes' leader says independence vote is 'once in a lifetime"),
                NewsItem(category: .MiddleEast, headline: "Airstrikes boost Islamic State, FBI director warns more hostages possible"),
                NewsItem(category: .Africa, headline: "Nigeria says 70 dead in building collapse; questions S. Africa victim claim"),
                NewsItem(category: .AsiaPasific, headline: "Despite UN ruling, Japan seeks backing for whale hunting"),
                NewsItem(category: .Americas, headline: "Officials: FBI is tracking 100 Americans who fought alongside IS in Syria"),
                NewsItem(category: .World, headline: "South Africa in $40 billion deal for Russian nuclear reactors"),
                NewsItem(category: .Europe, headline: "One million babies' created by EU student exchanges")]
        
    }

    override func viewWillAppear(animated: Bool) {
        self.clearsSelectionOnViewWillAppear = self.splitViewController!.collapsed
        super.viewWillAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func updateHeaderView() {
        tableView.contentInset = UIEdgeInsetsMake(kTableHeaderHeight-30, 0, 0, 0)
        headerView.frame = CGRect(x: 0, y: -kTableHeaderHeight+30, width: tableView.bounds.size.width, height: headerView.frame.size.height)
        
        if -kTableHeaderHeight+30 > tableView.contentOffset.y {
            let frame = CGRect(x: headerView.frame.origin.x, y: tableView.contentOffset.y, width: tableView.bounds.size.width, height: -tableView.contentOffset.y+30)
            headerView.frame = frame
        }
        
        addDiagonalMask()
    }
    
    func addDiagonalMask() {
        
        let maskLayer = CAShapeLayer();
        let trianglePath = UIBezierPath()
        trianglePath.moveToPoint(CGPoint(x: headerView.frame.origin.x, y: headerView.frame.origin.y))
        trianglePath.addLineToPoint(CGPoint(x: headerView.frame.origin.x, y: headerView.frame.size.height - 50))
        trianglePath.addLineToPoint(CGPoint(x: headerView.frame.size.width, y: headerView.frame.size.height))
        trianglePath.addLineToPoint(CGPoint(x: headerView.frame.size.width, y: headerView.frame.origin.y))
        trianglePath.closePath()
        
        maskLayer.fillColor = UIColor.whiteColor().CGColor
        maskLayer.backgroundColor = UIColor.clearColor().CGColor
        maskLayer.path = trianglePath.CGPath
        
        headerView.layer.mask = maskLayer
    }

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow {
                let newsItem = news[indexPath.row]
                let controller = (segue.destinationViewController as! UINavigationController).topViewController as! DetailViewController
                controller.detailItem = newsItem
                controller.navigationItem.title = newsItem.category.description()
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("NewsItemCell", forIndexPath: indexPath) as! NewsTableViewCell

        cell.newsItem = news[indexPath.row]
        
        return cell
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    // MARK: Scroll View
    override func scrollViewDidScroll(scrollView: UIScrollView) {
        updateHeaderView()
    }

}

