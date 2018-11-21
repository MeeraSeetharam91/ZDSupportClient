//
//  ZDSupportViewController.swift
//  ZendeskSupportDemo
//
//  Created by Meera on 19/11/18.
//

import UIKit

class ZDSupportViewController: UIViewController {
    @IBOutlet weak var supportCollectionView: UICollectionView!
    var zdSupportPresenter : ZDSupportPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initialiseUI()
        zdSupportPresenter = ZDSupportPresenter(zdSupportViewController: self)
        zdSupportPresenter.configView()
    }
    
    func initialiseUI() {
        //
    }
}
