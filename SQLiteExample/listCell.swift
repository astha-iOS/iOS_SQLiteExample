//
//  listCell.swift
//  coreDataExample
//
//  Created by WDP on 12/07/20.
//  Copyright © 2020 WDP. All rights reserved.
//

import UIKit

class listCell: UITableViewCell {
    
    @IBOutlet weak var lblName: UILabel!
    
    @IBOutlet weak var lblAge: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
