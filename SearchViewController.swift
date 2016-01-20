//
//  SearchViewController.swift
//  QFYxExpression
//
//  Created by qzp on 15/11/6.
//  Copyright © 2015年 qzp. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    
    private var tableView: UITableView!
    private var searchBar: UISearchBar!
    private var sDisplayController: UISearchDisplayController!
//    private var sDisplayController: UISearchController! ios 8.0 +
    
    private var clickBlock: ((index: Int) -> Void)?
    private var searchResultArray: NSMutableArray!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        initializeUseInterface()
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    class func show(vc: UIViewController, block:((index: Int)->Void)) {
        let searchVc = SearchViewController()
        searchVc.clickBlock = block
        let nav = UINavigationController(rootViewController: searchVc)
        vc .presentViewController(nav, animated: true, completion: nil)
    }
    
    
    func initializeUseInterface() {
        self.view.backgroundColor = UIColor.whiteColor()
        self.searchResultArray = NSMutableArray()
        searchBar = {
            let sb = UISearchBar()
            sb.delegate = self
            sb.sizeToFit()
            sb.placeholder = "请输入"
            return sb
            }()
        
        
        sDisplayController = {
            let sdVc = UISearchDisplayController(searchBar: self.searchBar, contentsController: self)
            sdVc.delegate = self
            sdVc.searchResultsDataSource = self
            sdVc.searchResultsDelegate = self
            return sdVc
            }()
        
        tableView = {
            let tableView = UITableView(frame: CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), CGRectGetHeight(self.view.bounds)), style: UITableViewStyle.Plain)
            tableView.tableFooterView = UIView()
            self.view.addSubview(tableView)
            tableView.dataSource = self
            tableView.delegate = self
            tableView.tableHeaderView = searchBar
            return tableView
            }()
        
  
    }
    
    
  

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("CEll")
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: "CEll")
            cell?.textLabel?.text = String(format: "%d", indexPath.row)
        }
        return cell!
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if clickBlock != nil {
            clickBlock!(index: indexPath.row)
        }
        self.dismissViewControllerAnimated(true, completion: nil)
    }

}

extension SearchViewController: UISearchBarDelegate {
    func searchBarShouldBeginEditing(searchBar: UISearchBar) -> Bool {
        searchBar.insertBgColor(UIColor.orangeColor())
        return true
    }
    func searchBarShouldEndEditing(searchBar: UISearchBar) -> Bool {
        searchBar.insertBgColor(UIColor.clearColor())
        return true
    }

}

extension SearchViewController: UISearchDisplayDelegate {

}
