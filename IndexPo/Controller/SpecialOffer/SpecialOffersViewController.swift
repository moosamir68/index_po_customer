//
//  SpecialOffersViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/3/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

let identifireFavortiesCell = "SpecialOffersCollectionViewCell"

import UIKit
import KTCenterFlowLayout

protocol SpecialOffersDelegate {
    func showSpecialOfferFrom(fromController:SpecialOffersViewController?, specialOffer:SpecialOffer?)
}

class SpecialOffersViewController: MasterCollectionViewController {
    
    @IBOutlet var buttonView: UIView!
    @IBOutlet var addButton: UIButton!
    @IBOutlet var seeArchaiveButton: UIButton!
    
    var delegate:SpecialOffersDelegate?
    var specialOffers = [SpecialOffer]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.initUI()
        self.getData()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- initUI
    internal override func initUI(){
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.addButton.layer.cornerRadius = 2.0
        self.addButton.backgroundColor = UIUtility.sormaeiColor()
        self.addButton.setTitle("Add to faverties".localized(), for: .normal)
        self.addButton.setTitleColor(.white, for: .normal)
        self.addButton.titleLabel?.font = UIUtility.boldFontAutoWithPlusSize()
        self.addButton.titleLabel?.adjustsFontSizeToFitWidth = true
        
        self.seeArchaiveButton.layer.cornerRadius = 2.0
        self.seeArchaiveButton.backgroundColor = UIUtility.sormaeiColor()
        self.seeArchaiveButton.setTitle("Archive".localized(), for: .normal)
        self.seeArchaiveButton.setTitleColor(.white, for: .normal)
        self.seeArchaiveButton.titleLabel?.font = UIUtility.boldFontAutoWithPlusSize()
        
    }
    
    //MARK:- get data
    internal override func getData(){
        Service.sharedInstanse.getSpecialOffers { (specialOffers, error) in
            if(error == nil){
                self.specialOffers = specialOffers!
                DispatchQueue.main.async {
                    self.initCollectionView()
                    self.collectionView.reloadData()
                }
            }
        }
    }
    
    //MARK:- collectionview initialize
    private func initCollectionView(){
        self.collectionView.register(UINib(nibName: identifireFavortiesCell, bundle: nil), forCellWithReuseIdentifier: identifireFavortiesCell)
        self.collectionView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let flowLayout = KTCenterFlowLayout()
        let cellWidth = (self.boxView.frame.size.width / 2) - 12
        let cellHeight = cellWidth + 8 + 21 + 8 + 21 + 8
        flowLayout.itemSize = CGSize(width: cellWidth ,
                                     height: cellHeight)
        flowLayout.minimumInteritemSpacing = 8.0
        flowLayout.minimumLineSpacing = 8.0
        self.collectionView.collectionViewLayout.invalidateLayout()
        self.collectionView.collectionViewLayout = flowLayout
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        
        self.collectionView.allowsMultipleSelection = false
        self.collectionView.allowsSelection = true
        self.collectionView.alwaysBounceVertical = true
    }
    
    //MARK:- collectionview delegate
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell:SpecialOffersCollectionViewCell? = collectionView.dequeueReusableCell(withReuseIdentifier: identifireFavortiesCell, for: indexPath) as? SpecialOffersCollectionViewCell
        
        let specialOffer = self.specialOffers[indexPath.row]
        cell?.fillData(specialOffer: specialOffer)
        return cell!
    }
}
