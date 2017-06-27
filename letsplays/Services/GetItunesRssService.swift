//
//  GetItunesRssService.swift
//  letsplays
//
//  Created by nktn on 2017/06/25.
//  Copyright © 2017年 nakatani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import SwiftyJSON
import Alamofire

class GetItunesRssService {
    let url = "https://itunes.apple.com/jp/rss/topfreeapplications/limit=100/genre=6014/json"
    
    func search(query: String = "") -> Observable<[Home]> {
        return Observable.create{ observer in
            Alamofire.request(self.url, parameters: nil).responseJSON{ [weak self] response in
                guard let strongSelf = self, let data = response.result.value else { return }
                let json = JSON(data)
                let items = strongSelf.parse(venuesJSON: json["feed"]["entry"])
                observer.on(.next(items))
                observer.on(.completed)
            }
            return Disposables.create {}
        }
    }
    
    fileprivate func parse(venuesJSON: JSON) -> [Home] {
        var items = [Home]()
        for (key: _, venueJSON: JSON) in venuesJSON {
            items.append(Home(json: JSON))
        }
        return items
    }
}
