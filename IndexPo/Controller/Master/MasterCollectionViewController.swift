//
//  MasterCollectionViewController.swift
//  iOSShopBase
//
//  Created by Moosa Mir on 2/6/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

let identifireErrorCollectionViewCell = "ErrorCollectionViewCell"

protocol MasterCollectionViewDelegate {
    func userDidTapOnCollectionViewItem(itemTouches:Any)
}

import UIKit

class MasterCollectionViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var boxView: UIView!
    @IBOutlet var collectionView: UICollectionView!
    
    var navigationTitle:String?
    var errorDescription = "Fetching Data...".localized()
    var items = [Any]()
    
    var masterCollectionDelegate:MasterTableViewDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK:- collectionview delegate
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if(self.checkIsEmptyDataSource()){
            return 0
        }
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if(self.checkIsEmptyDataSource()){
            return 0
        }
        return self.items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if(!self.checkIsEmptyDataSource()){
            let item = self.items[indexPath.row]
            self.userDidTapOnItem(select: item)
        }
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 0, height: 0)
    }
    
    //MARK:- internal method
    func userDidTapOnItem(select item:Any){
        
    }
    
    //MARK:- initUI
    func initUI(){
    }
    
    //MARK:- getdata
    func getData(){
    }
    
    //MARK:- check is empty data source
    func checkIsEmptyDataSource() -> Bool{
        if(self.items.count == 0){
            return true
        }
        return false
    }
    

}
