//
//  HomeViewController.swift
//  letsplays
//
//  Created by nktn on 2017/06/25.
//  Copyright © 2017年 nakatani. All rights reserved.
//

import UIKit
import SafariServices
import RxSwift
import RxCocoa


class HomeViewController: UIViewController {
    var disposeBag = DisposeBag()
    @IBOutlet weak var tableView: UITableView!
    var viewModel = HomeViewModel()
    var dataSource = DataSource()
    var delegate = Delegate()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        var refreshControl = UIRefreshControl()
        
        self.viewModel.fetch()
        self.tableView.delegate = self.delegate
        
        self.tableView.refreshControl = refreshControl
    
        self.viewModel.items
            .asDriver()
            .drive (
                self.tableView.rx.items(dataSource: self.dataSource)
            )
            .addDisposableTo(self.disposeBag)
        
        
        self.tableView.rx.itemSelected
            .bind { [weak self] indexPath in
                if (self?.viewModel.items.value[indexPath.row]) != nil {
                    let safariViewController = SFSafariViewController(url:  (self?.viewModel.items.value[(indexPath as NSIndexPath).row].linkURL)!)
                    self?.present(safariViewController, animated: true, completion: nil)

                }
            }
            .addDisposableTo(self.disposeBag)

        self.viewModel.items.asObservable().filter { x in
            return !x.isEmpty
            }.subscribe(onNext: { [unowned self] x in
                self.tableView.reloadData()
            }, onError: { error in
            }, onCompleted: { () in
                // 完了
            }) { () in
            }.addDisposableTo(disposeBag)

        
        refreshControl.rx.controlEvent(.valueChanged).map{ _ in refreshControl.isRefreshing}
            .filter{ $0 == true}
            .subscribe(onNext: { _ in
                Timer.scheduledTimer(withTimeInterval: 2, repeats: false, block: { (Timer) in
                    refreshControl.endRefreshing()
                })
            }).addDisposableTo(self.disposeBag)
        
        //PULL
        refreshControl.rx.controlEvent(.valueChanged).subscribe(onNext: {_ in
            self.viewModel.fetch()
        }).disposed(by: disposeBag)
        

        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
