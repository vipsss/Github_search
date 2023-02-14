//
//  ListItemCell.swift
//  Github_search
//
//  Created by Mac User on 14.02.2023.
//

import UIKit

class ListItemCell: UITableViewCell {

    @IBOutlet weak var cellSubtitleLabel: UILabel!
    @IBOutlet weak var cellTitleLabel: UILabel!
    @IBOutlet weak var cellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
