//
//  LibraryListTableViewCell.swift
//  LibraryMeProject
//
//  Created by 박소현 on 2023/10/18.
//

import UIKit
import Kingfisher

class LibraryListTableViewCell: UITableViewCell {
    
    @IBOutlet weak var libraryImageView: UIImageView!
    @IBOutlet weak var lbTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        selectionStyle = .none
    }
    
    func createCell(item: LibraryItem) {
        
        if let urlString = item.thumbnailURL, let url = URL(string: urlString) {
            
            KingfisherManager.shared.retrieveImage(with: url) { result in
                switch result {
                case .success(let imageResult):
                    print("썸네일 로드 성공!! :: \(urlString)")
                    self.libraryImageView.image = imageResult.image
                    
                case .failure(let error):
                    print("썸네일 로드 실패ㅠㅠ :: \(urlString), 에러 \(error.localizedDescription)")
                }
            }
        }
        
        lbTitle.text = item.titleStatement
    }
}
