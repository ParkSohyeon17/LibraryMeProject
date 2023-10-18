//
//  LibraryListViewController.swift
//  LibraryMeProject
//
//  Created by 박소현 on 2023/10/15.
//

import UIKit

class LibraryListViewController: UIViewController {
    
    @IBOutlet weak var libraryListTableView: UITableView!
    
    var libraryListViewModel: LibraryListViewModel?
    
    var isBottom = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        libraryListTableView.delegate = self
        libraryListTableView.dataSource = self
        
        libraryListTableView.separatorStyle = .none
        
        libraryListViewModel = LibraryListViewModel()
        libraryListViewModel?.bindToController = {
            self.libraryListTableView.reloadData()
        }
    }
}

extension LibraryListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return libraryListViewModel?.libraryList?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: "LibraryListTableViewCell") as? LibraryListTableViewCell, let libraryItem = libraryListViewModel?.libraryList?[indexPath.row] {
            
            cell.createCell(item: libraryItem)
            return cell
        }
        return UITableViewCell()
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if isBottom, libraryListViewModel?.apiService?.isLastLibraryItem == false {
            
            if let userListCnt = libraryListViewModel?.libraryList?.count {
                
                let lastIndex = userListCnt - 1
                
                if indexPath.row == lastIndex {
                    
                    libraryListViewModel?.apiService?.isPaging = true
                    
                    print("isBottom :: 추가 데이터 요청")
                    libraryListViewModel?.apiService?.libraryItemReqCnt += 20
                    libraryListViewModel?.getLibraryListData()
                }
            }
        }
    }
    
}

extension LibraryListViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let yVelocity = scrollView.panGestureRecognizer.velocity(in: scrollView).y
        
        if yVelocity < 0 {
            isBottom = true
        }
        else if yVelocity > 0 {
            isBottom = false
        }
    }
    
}
