//
//  HomeViewModel.swift
//  letsplays
//
//  Created by nktn on 2017/06/25.
//  Copyright © 2017年 nakatani. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

class HomeViewModel {
    
    fileprivate(set) var items = Variable<[Home]>([])
    
    let client = GetItunesRssService()
    let disposeBag = DisposeBag()
    
    init() {
    // NOOP
    }
    
    // MARK: - Public
    public func fetch(query: String = "") {
        client.search(query: query)
            .subscribe { [weak self] result in
                switch result {
                case .next(let value):
                    self?.items.value = value
                case .error(let error):
                    print(error)
                case .completed:
                    ()
                }
            }
            .addDisposableTo(disposeBag)
    }
}
