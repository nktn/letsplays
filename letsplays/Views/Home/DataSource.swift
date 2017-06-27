//
//  DataSource.swift
//  letsplays
//
//  Created by nktn on 2017/06/25.
//  Copyright © 2017年 nakatani. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import AlamofireImage

public final class DataSource: NSObject, RxTableViewDataSourceType, UITableViewDataSource {
    
    // MARK: - Alias
    
    public typealias Element = [Home]
    
    // MARK: - Property
    
    fileprivate var items = [Home]()
    
    // MARK: - RxTableView DataSourceType
    public func tableView(_ tableView: UITableView, observedEvent: Event<Element>) {
        switch observedEvent {
        case .next(let value):
            self.items = value
            tableView.reloadData()
        case .error(_):
            ()
        case .completed:
            ()
        }
    }
    
    // MARK: - UITableView DataSource
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count
    }
    
    public func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return false
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeTableViewCell", for: indexPath) as! HomeTableViewCell
         
        cell.numLabel.text = String(indexPath.row+1)
        cell.titleLabel?.text = self.items[(indexPath as NSIndexPath).row].title
        cell.publisherLabel?.text = self.items[(indexPath as NSIndexPath).row].publisher
        if (self.items[(indexPath as NSIndexPath).row].imgURL != nil){
            cell.appImgView.af_setImage(withURL: self.items[(indexPath as NSIndexPath).row].imgURL!)
        }else{
            cell.appImgView.image = UIImage.init(named: "iOS")
        }
        return cell
    }
    
}
