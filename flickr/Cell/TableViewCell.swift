//
//  TableViewCell.swift
//  flickr
//
//  Created by AZioT on 2021-07-14.
//

import Foundation
import UIKit

class TableViewCell: UITableViewCell {
    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var ownerIDLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        photoImage.layer.borderWidth = 1
        photoImage.layer.masksToBounds = false
        photoImage.layer.borderColor = UIColor.white.cgColor
        photoImage.layer.cornerRadius = photoImage.frame.height/2
        photoImage.clipsToBounds = true
            
    }
}
