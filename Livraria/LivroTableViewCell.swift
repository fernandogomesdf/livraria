//
//  LivroTableViewCell.swift
//  Livraria
//
//  Created by IOS on 31/05/16.
//  Copyright © 2016 Fernando Gomes. All rights reserved.
//

import UIKit

class LivroTableViewCell: UITableViewCell {

    @IBOutlet weak var capaImageView: UIImageView!
    @IBOutlet weak var tituloLabel: UILabel!
    @IBOutlet weak var autorLabel: UILabel!
    @IBOutlet weak var precoLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
