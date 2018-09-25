//
//  TrailerTableViewCell.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 25/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit

class TrailerTableViewCell: UITableViewCell {
    @IBOutlet weak var webView: UIWebView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
