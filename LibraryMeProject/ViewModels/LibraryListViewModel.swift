//
//  LibraryListViewModel.swift
//  LibraryMeProject
//
//  Created by 박소현 on 2023/10/18.
//

import Foundation

class LibraryListViewModel: NSObject {
    
    var apiService: ApiService?
    
    private(set) var libraryList: [LibraryItem]? {
        didSet {
            bindToController()
        }
    }
    
    var bindToController : (() -> ()) = {}
    
    override init() {
        super.init()
        
        apiService = ApiService()
        getLibraryListData()
    }
    
    func getLibraryListData() {
        
        apiService?.getLibraryList() { library in
            
            if let libraryItemList = library?.data.list, let apiService = self.apiService {
                
                if self.apiService?.isPaging == true {
                    self.libraryList?.append(contentsOf: libraryItemList)
                    apiService.isPaging = !apiService.isPaging
                }
                else {
                    self.libraryList = libraryItemList
                }
                
            }
            
        }
    }
    
}
