//
//  ZDSupportCollectionViewCell.swift
//  ZendeskSupportDemo
//
//  Created by Meera on 20/11/18.
//

import Foundation
import UIKit

class ZDSupportCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var idLabel: UILabel!
    
    func configureCell(model: Ticket) {
        self.subjectLabel.text = model.subject
        self.descriptionLabel.text = model.description
        self.statusLabel.text = model.status
        self.idLabel.text = "\(model.id)"

    }
}
