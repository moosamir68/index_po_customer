//
//  ProductTableViewCell.swift
//  iOSShopBase
//
//  Created by Moosa Mir on 2/7/18.
//  Copyright © 2018 Noxel. All rights reserved.
//

@objc protocol ProductTableViewCellDelegate {
    func userDidTapOnBuyButton(on product:Product)
    func userDidTapOnFancy(on product:Product)
    func userDidTapOnMore(on product:Product)
    
    @objc optional func userDidTapOnImage(on product:Product)
    @objc optional func userDidTapOnVideo(on product:Product)
    @objc optional func userDidTapOnGif(on product:Product)
}

import UIKit

class ProductTableViewCellImage: UITableViewCell, ImagePlayerDelegate {

    @IBOutlet var boxView: UIView!
    @IBOutlet var mediaView: UIView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var productPriceLabel: UILabel!
    @IBOutlet var productDescriptionLabe: UILabel!
    @IBOutlet var lineUnderPrice: UIView!
    @IBOutlet var fancyButton: UIButton!
    @IBOutlet var buyButton: UIButton!
    @IBOutlet var moreButton: UIButton!
    @IBOutlet var lineSeperator: UIView!
    
    var delegate:ProductTableViewCellDelegate?
    var product:Product?
    
    let imageController = ImagePlayerViewController()
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
        self.mediaView.addSubview(self.imageController.view)
        self.imageController.view.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.top.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        self.boxView.setAutomaticDirection()
        self.fancyButton.setAutomaticDirection()
        self.buyButton.setAutomaticDirection()
        self.productNameLabel.setAutomaticAlignment()
        self.productPriceLabel.setAutomaticAlignment()
        self.productDescriptionLabe.setAutomaticAlignment()
        
        self.productNameLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.productPriceLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.productDescriptionLabe.font = UIUtility.normalFontAutoWithPlusSize()
        self.fancyButton.titleLabel?.font = UIUtility.normalFontAutoWithPlusSize()
        self.buyButton.titleLabel?.font = UIUtility.normalFontAutoWithPlusSize()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    //MARK:- fill data
    func fillData(product:Product){
        self.productPriceLabel.text = product.price.formattedWithSeparator.addTomanToPrice(title: "Toman".localized())
        self.productNameLabel.text = product.name
        self.productDescriptionLabe.text = product.nameEn
        self.imageController.fillData(product: product)
    }
    
    //MARK:- user did tap
    @IBAction func userDidTapOnMore(_ sender: Any) {
        self.delegate?.userDidTapOnMore(on: self.product!)
    }
    
    @IBAction func userDidTapOnBuy(_ sender: Any) {
        self.delegate?.userDidTapOnBuyButton(on: self.product!)
    }
    
    @IBAction func userDidTapOnFancy(_ sender: Any) {
        self.delegate?.userDidTapOnFancy(on: self.product!)
    }
    
    @IBAction func userDidTapOnImage(_ sender: Any) {
        self.delegate?.userDidTapOnImage!(on: self.product!)
    }
    
    //MARK:- image player delegate
    func userDidTapOnImage(on product: Product) {
        self.delegate?.userDidTapOnImage!(on: product)
    }
}
