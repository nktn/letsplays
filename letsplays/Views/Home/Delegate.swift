//
//  Delegate.swift
//  letsplays
//
//  Created by nktn on 2017/06/25.
//  Copyright © 2017年 nakatani. All rights reserved.
//

import UIKit

public final class Delegate: NSObject, UITableViewDelegate {
    
    // MARK: - UITableView Delegate
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 66
    }
    	
}
