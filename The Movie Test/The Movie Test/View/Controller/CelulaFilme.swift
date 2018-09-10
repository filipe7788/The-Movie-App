//
//  CelulaFilme.swift
//  The Movie Test
//
//  Created by Filipe Cruz on 02/09/18.
//  Copyright © 2018 Filipe Cruz. All rights reserved.
//

import UIKit

class CelulaFilme: UITableViewCell {

    @IBOutlet weak var nome: UILabel!
    @IBOutlet weak var descricao: UILabel!
    @IBOutlet weak var nota: UILabel!
    @IBOutlet weak var dataLancamento: UILabel!
    @IBOutlet weak var fotoFilme: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
