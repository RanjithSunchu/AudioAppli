//
//  SampleTableViewCell.swift
//  MusicApp
//
//  Created by HungDo on 7/26/16.
//  Copyright © 2016 HungDo. All rights reserved.
//

import UIKit

class SampleTableViewCell: UITableViewCell {

    @IBOutlet weak var cellLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
