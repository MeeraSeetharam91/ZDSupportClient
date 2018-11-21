//
//  ZDSupportPresenter.swift
//  ZendeskSupportDemo
//
//  Created by Meera on 19/11/18.
//

import Foundation
import UIKit

/**
 ZDSupportPresenter is used to congiure Login screen.
 */

class ZDSupportPresenter: NSObject {
    weak var zdSupportController: ZDSupportViewController!
    var zdSupportInteractor: ZDSupportInteractor!
    
    var ticketList = [Ticket]() {
        didSet {
            DispatchQueue.main.async {
                self.zdSupportController.supportCollectionView.reloadData()
            }
        }
    }
    init(zdSupportViewController: ZDSupportViewController) {
        self.zdSupportController = zdSupportViewController
        zdSupportInteractor = ZDSupportInteractor(viewId: "39551161")
    }
    
    /**
     Zendesk Support view configuration.
     */
    func configView() {
        self.zdSupportController.supportCollectionView.dataSource = self
        self.zdSupportController.supportCollectionView.delegate = self
        self.zdSupportController.supportCollectionView.register(UINib(nibName: "ZDSupportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "ZDSupportCollectionViewCell")
        self.zdSupportInteractor.tickets(completion: {list in
            self.ticketList = list
        })
    }
}

extension ZDSupportPresenter: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return ticketList.count
    }
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ZDSupportCollectionViewCell", for: indexPath) as? ZDSupportCollectionViewCell
        cell?.configureCell(model: ticketList[indexPath.row])
        return cell ?? UICollectionViewCell()
    }
}
extension ZDSupportPresenter: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGSize.init(width: (collectionView.frame.size.width / 2) - 15, height: 120)
        return size
    }
}
//extension ZDSupportPresenter: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//    }
//}
