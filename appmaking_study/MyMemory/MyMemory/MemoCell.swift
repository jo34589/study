//
//  MemoCell.swift
//  MyMemory
//
//  Created by 엔나루 on 2021/07/26.
//

import UIKit

class MemoCell: UITableViewCell {
    
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contents: UILabel!
    @IBOutlet weak var regdate: UILabel!
    @IBOutlet weak var img: UIImageView!
    
    /*
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    */
}
