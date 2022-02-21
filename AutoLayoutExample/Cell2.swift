//
//  Cell2.swift
//  AutoLayoutExample
//
//  Created by Franklin Samboni on 14/02/22.
//

import UIKit

class Cell2: UICollectionViewCell {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var trailing: NSLayoutConstraint!
    @IBOutlet weak var leading: NSLayoutConstraint!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
