//
//  ProductViewController.swift
//  Moosa Mir
//
//  Created by Moosa Mir on 12/19/17.
//  Copyright © 2017 Noxel. All rights reserved.
//

import UIKit
import BEMCheckBox
import Toaster
import MMAlert

protocol ProductDelegate {
    func dismissProductController(fromController:ProductViewController?)
    func showDialogColor(fromController:ProductViewController?, elements:[MMAlert])
    func dismissDialogColor(fromController:MMAlertSheetViewController?)
}

class ProductViewController: MasterViewController, BEMCheckBoxDelegate, UITextViewDelegate, AlertSheetDelegate {

    var delegate:ProductDelegate?
    var product:Product?
    
    var colors:[Color]?
    
    @IBOutlet var scrollView: UIScrollView!
    @IBOutlet var doneButton: UIButton!
    @IBOutlet var deleteButton: UIButton!
    @IBOutlet var imageViewProduct: UIImageView!
    @IBOutlet var productNameLabel: UILabel!
    @IBOutlet var contentView: UIView!
    
    @IBOutlet var checkBoxExist: BEMCheckBox!
    @IBOutlet var checkBoxExistLabel: UILabel!
    @IBOutlet var priceWithGaraunteeTitleLabel: UILabel!
    @IBOutlet var priceWithGaraunteeValueTextField: UITextField!
    @IBOutlet var priceWithOutGaraunteeTitleLabel: UILabel!
    @IBOutlet var priceWithOutGaraunteeValueTextField: UITextField!
    @IBOutlet var garaunteeTextField: UITextField!
    @IBOutlet var garaunteeTitleLabel: UILabel!
    
    @IBOutlet var checkBoxYesGaruantee: BEMCheckBox!
    @IBOutlet var checkBoxNoGaruantee: BEMCheckBox!
    @IBOutlet var checkBoxBothGaruantee: BEMCheckBox!
    
    @IBOutlet var checkBoxYesGaruanteeLabel: UILabel!
    @IBOutlet var checkBoxNoGaruanteeLabel: UILabel!
    @IBOutlet var checkBoxBothGaruanteeLabel: UILabel!
    @IBOutlet var garaunteeCheckBoxTitle: UILabel!
    
    @IBOutlet var expireTimePriceTitleLabel: UILabel!
    @IBOutlet var expireTimePriceValueLabel: UILabel!
    
    @IBOutlet var colorTitleLabel: UILabel!
    @IBOutlet var colorValueLabel: UILabel!
    @IBOutlet var descriptionTitleLabel: UILabel!
    @IBOutlet var descriptionTextView: UITextView!
    @IBOutlet var contentViewConstraintHeight: NSLayoutConstraint!
    
    var lineToOnExist:UIView!
    var lineToColor:UIView!
    var lineTopGarauntee:UIView!
    var lineTopPrice:UIView!
    var lineTopDescription:UIView!
    var informationTitleLabel:UILabel!
    
    var contentHeight:CGFloat = 0.0
    var colorElements = [MMAlert]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    //MARK:- initUI
    internal override func initUI(){

        self.contentHeight = 0.0
        self.contentHeight = self.contentHeight + 8 + (self.scrollView.frame.size.width - 16) * (8/15)
        self.contentHeight = self.contentHeight + 8 + 21
        self.contentHeight = self.contentHeight + 32 + 24
        self.contentHeight = self.contentHeight + 16 + 21
        self.contentHeight = self.contentHeight + 24 + 21
        self.contentHeight = self.contentHeight + 12 + 21
        self.contentHeight = self.contentHeight + 32 + 21
        self.contentHeight = self.contentHeight + 24 + 24
        self.contentHeight = self.contentHeight + 12 + 21
        self.contentHeight = self.contentHeight + 24 + 21
        self.contentHeight = self.contentHeight + 16 + 21
        self.contentHeight = self.contentHeight + 16 + 21
        self.contentHeight = self.contentHeight + 4 + 72
        self.contentHeight = self.contentHeight + 8 + 44
        self.contentHeight = self.contentHeight + 8
        
        self.scrollView.contentSize = CGSize(width: UIScreen.main.bounds.size.width, height: self.contentHeight)
        print("width init ui = ", self.view.frame.size.width)
        self.view.layoutIfNeeded()
        
        //Content view
        self.contentView = UIView(frame: .zero)
        self.scrollView.addSubview(self.contentView)
        self.contentView.snp.makeConstraints { (make) in
            make.top.equalTo(self.scrollView.snp.top)
            make.leading.equalTo(self.scrollView.snp.leading)
            make.height.equalTo(self.contentHeight)
            make.width.equalToSuperview()
            
        }
        
        //ImageVIew
        self.imageViewProduct = UIImageView(frame: .zero)
        self.imageViewProduct.image = #imageLiteral(resourceName: "loading")
        self.imageViewProduct.contentMode = .scaleAspectFit
        self.contentView.addSubview(self.imageViewProduct)
        self.imageViewProduct.snp.makeConstraints { (make) in
            make.top.equalTo(self.contentView.snp.top).offset(8)
            make.leading.equalTo(self.contentView.snp.leading).offset(8)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-8)
            make.height.equalTo(self.contentView.snp.width).multipliedBy(8.0/15.0)
        }
        
        //Product name title
        self.productNameLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.productNameLabel)
        self.productNameLabel.textAlignment = .center
        self.productNameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.imageViewProduct.snp.bottom).offset(8)
            make.leading.equalTo(self.contentView.snp.leading).offset(8)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-8)
            make.height.equalTo(21.0)
        }
        
        //Line top on exist
        self.lineToOnExist = UIView(frame: .zero)
        self.contentView.addSubview(self.lineToOnExist)
        self.lineToOnExist.backgroundColor = UIUtility.sormaeiColor()
        self.lineToOnExist.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(1.5)
            make.top.equalTo(self.productNameLabel.snp.bottom).offset(32)
        }
        
        //Information title label
        self.informationTitleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.informationTitleLabel)
        self.informationTitleLabel.text = "Information".localized()
        self.informationTitleLabel.textAlignment = .center
        self.informationTitleLabel.font = UIUtility.boldFontAutoWithPlusSize(increaseSize: 1)
        self.informationTitleLabel.textColor = UIUtility.sormaeiColor()
        self.informationTitleLabel.backgroundColor = .white
        self.informationTitleLabel.snp.makeConstraints { (make) in
            make.width.equalTo(self.informationTitleLabel.intrinsicContentSize.width + 16)
            make.height.equalTo(21)
            make.center.equalTo(self.lineToOnExist)
        }
        
        //Checkbox exist
        self.checkBoxExist = BEMCheckBox(frame: .zero)
        self.contentView.addSubview(checkBoxExist)
        self.checkBoxExist.snp.makeConstraints { (make) in
            make.leading.equalTo(self.contentView.snp.leading).offset(8)
            make.top.equalTo(self.lineToOnExist.snp.bottom).offset(8)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }

        //Exist title
        self.checkBoxExistLabel = UILabel(frame: .zero)
        self.contentView.addSubview(checkBoxExistLabel)
        self.checkBoxExistLabel.text = "Exist".localized()
        self.checkBoxExistLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.checkBoxExist.snp.trailing).offset(8)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-8)
            make.centerY.equalTo(self.checkBoxExist)
            make.height.equalTo(21)
        }

        //line top of color
        self.lineToColor = UIView(frame: .zero)
        self.contentView.addSubview(self.lineToColor)
        self.lineToColor.backgroundColor = UIUtility.sormaeiColor()
        self.lineToColor.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(self.checkBoxExist.snp.bottom).offset(8)
        }
        
        //color title
        self.colorTitleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(colorTitleLabel)
        self.colorTitleLabel.text = "Color:".localized()
        self.colorTitleLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.colorTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(self.lineToColor.snp.bottom).offset(8)
            make.width.equalTo(self.colorTitleLabel.intrinsicContentSize.width)
            make.height.equalTo(21)
        }

        //color value
        self.colorValueLabel = UILabel(frame: .zero)
        self.contentView.addSubview(colorValueLabel)
        self.colorValueLabel.textColor = UIUtility.defulatButtonColor()
        self.colorValueLabel.text = "Select".localized()
        self.colorValueLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.colorTitleLabel.snp.trailing).offset(8)
            make.centerY.equalTo(self.colorTitleLabel)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(21)
        }

        //Line top on Garanty
        self.lineTopGarauntee = UIView(frame: .zero)
        self.contentView.addSubview(self.lineTopGarauntee)
        self.lineTopGarauntee.backgroundColor = UIUtility.sormaeiColor()
        self.lineTopGarauntee.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(self.colorTitleLabel.snp.bottom).offset(8)
        }
        
        //Garanty checkbox title
        self.garaunteeCheckBoxTitle = UILabel(frame: .zero)
        self.contentView.addSubview(garaunteeCheckBoxTitle)
        self.garaunteeCheckBoxTitle.text = "Garauntee:".localized()
        self.garaunteeCheckBoxTitle.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(21)
            make.top.equalTo(lineTopGarauntee.snp.bottom).offset(16)
        }

        //Checkbox Yes
        self.checkBoxYesGaruantee = BEMCheckBox(frame: .zero)
        self.contentView.addSubview(checkBoxYesGaruantee)
        self.checkBoxYesGaruantee.snp.makeConstraints { (make) in
            make.leading.equalTo(self.garaunteeCheckBoxTitle.snp.trailing).offset(12)
            make.centerY.equalTo(self.garaunteeCheckBoxTitle)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        self.checkBoxYesGaruanteeLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.checkBoxYesGaruanteeLabel)
        self.checkBoxYesGaruanteeLabel.text = "Yes".localized()
        self.checkBoxYesGaruanteeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.checkBoxYesGaruantee.snp.trailing).offset(4)
            make.centerY.equalTo(self.checkBoxYesGaruantee)
        }
        
        //Checkbox No
        self.checkBoxNoGaruantee = BEMCheckBox(frame: .zero)
        self.contentView.addSubview(checkBoxNoGaruantee)
        self.checkBoxNoGaruantee.snp.makeConstraints { (make) in
            make.leading.equalTo(self.checkBoxYesGaruanteeLabel.snp.trailing).offset(12)
            make.centerY.equalTo(self.garaunteeCheckBoxTitle)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        self.checkBoxNoGaruanteeLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.checkBoxNoGaruanteeLabel)
        self.checkBoxNoGaruanteeLabel.text = "No".localized()
        self.checkBoxNoGaruanteeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.checkBoxNoGaruantee.snp.trailing).offset(4)
            make.centerY.equalTo(self.checkBoxNoGaruantee)
        }
        
        //Checkbox Both
        self.checkBoxBothGaruantee = BEMCheckBox(frame: .zero)
        self.contentView.addSubview(checkBoxBothGaruantee)
        self.checkBoxBothGaruantee.snp.makeConstraints { (make) in
            make.leading.equalTo(self.checkBoxNoGaruanteeLabel.snp.trailing).offset(8)
            make.centerY.equalTo(self.garaunteeCheckBoxTitle)
            make.height.equalTo(24)
            make.width.equalTo(24)
        }
        
        self.checkBoxBothGaruanteeLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.checkBoxBothGaruanteeLabel)
        self.checkBoxBothGaruanteeLabel.text = "Both".localized()
        self.checkBoxBothGaruanteeLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.checkBoxBothGaruantee.snp.trailing).offset(4)
            make.centerY.equalTo(self.checkBoxYesGaruantee)
        }
        
        //Garanty label
        self.garaunteeTitleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.garaunteeTitleLabel)
        self.garaunteeTitleLabel.text = "Garauntee Name:".localized()
        self.garaunteeTitleLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.garaunteeTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.garaunteeCheckBoxTitle.snp.bottom).offset(12)
            make.leading.equalToSuperview().offset(8)
            make.height.equalTo(21)
            make.width.equalTo(self.garaunteeTitleLabel.intrinsicContentSize.width)
        }
        
        //Garanty textField
        self.garaunteeTextField = UITextField(frame: .zero)
        self.contentView.addSubview(self.garaunteeTextField)
        self.garaunteeTextField.borderStyle = .roundedRect
        self.garaunteeTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.garaunteeTitleLabel)
            make.leading.equalTo(self.garaunteeTitleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(30)
        }
        
        //Line top on Price
        self.lineTopPrice = UIView(frame: .zero)
        self.contentView.addSubview(self.lineTopPrice)
        self.lineTopPrice.backgroundColor = UIUtility.sormaeiColor()
        self.lineTopPrice.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(self.garaunteeTitleLabel.snp.bottom).offset(16)
        }
        
        //Price with out garanty
        self.priceWithOutGaraunteeTitleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.priceWithOutGaraunteeTitleLabel)
        self.priceWithOutGaraunteeTitleLabel.text = "Price without garauntee:".localized()
        self.priceWithOutGaraunteeTitleLabel.font = UIUtility.normalFontAutoWithPlusSize()
        
        //Price with garanty
        self.priceWithGaraunteeTitleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.priceWithGaraunteeTitleLabel)
        self.priceWithGaraunteeTitleLabel.text = "Price with garauntee:".localized()
        self.priceWithGaraunteeTitleLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.priceWithGaraunteeTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(self.lineTopPrice.snp.bottom).offset(16)
            make.height.equalTo(21)
            make.width.equalTo(self.priceWithOutGaraunteeTitleLabel.intrinsicContentSize.width)
        }
        
        self.priceWithOutGaraunteeTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(self.priceWithGaraunteeTitleLabel.snp.bottom).offset(12)
            make.height.equalTo(21)
            make.width.equalTo(self.priceWithOutGaraunteeTitleLabel.intrinsicContentSize.width)
        }
        
        //price with garanty textField
        self.priceWithGaraunteeValueTextField = UITextField(frame: .zero)
        self.contentView.addSubview(self.priceWithGaraunteeValueTextField)
        self.priceWithGaraunteeValueTextField.borderStyle = .roundedRect
        self.priceWithGaraunteeValueTextField.keyboardType = .decimalPad
        self.priceWithGaraunteeValueTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.priceWithGaraunteeTitleLabel)
            make.leading.equalTo(self.priceWithGaraunteeTitleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(30)
        }
        
        //price with out garanty textField
        self.priceWithOutGaraunteeValueTextField = UITextField(frame: .zero)
        self.contentView.addSubview(self.priceWithOutGaraunteeValueTextField)
        self.priceWithOutGaraunteeValueTextField.borderStyle = .roundedRect
        self.priceWithOutGaraunteeValueTextField.keyboardType = .decimalPad
        self.priceWithOutGaraunteeValueTextField.snp.makeConstraints { (make) in
            make.centerY.equalTo(self.priceWithOutGaraunteeTitleLabel)
            make.leading.equalTo(self.priceWithOutGaraunteeTitleLabel.snp.trailing).offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(30)
        }
        
        //time out title
        self.expireTimePriceTitleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.expireTimePriceTitleLabel)
        self.expireTimePriceTitleLabel.text = "Expire Date Price:".localized()
        self.expireTimePriceTitleLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.expireTimePriceTitleLabel.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8)
            make.top.equalTo(self.priceWithOutGaraunteeTitleLabel.snp.bottom).offset(16)
            make.height.equalTo(21)
            make.width.equalTo(self.expireTimePriceTitleLabel.intrinsicContentSize.width)
        }
        
        //time out value
        self.expireTimePriceValueLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.expireTimePriceValueLabel)
        self.expireTimePriceValueLabel.textColor = UIUtility.defulatButtonColor()
        self.expireTimePriceValueLabel.text = "Select".localized()
        self.expireTimePriceValueLabel.snp.makeConstraints { (make) in
            make.leading.equalTo(self.expireTimePriceTitleLabel.snp.trailing).offset(8)
            make.centerY.equalTo(self.expireTimePriceTitleLabel)
            make.trailing.equalToSuperview().offset(-8)
            make.height.equalTo(21)
        }
        
        //Line top on Price
        self.lineTopDescription = UIView(frame: .zero)
        self.contentView.addSubview(self.lineTopDescription)
        self.lineTopDescription.backgroundColor = UIUtility.sormaeiColor()
        self.lineTopDescription.snp.makeConstraints { (make) in
            make.leading.equalToSuperview()
            make.trailing.equalToSuperview()
            make.height.equalTo(0.5)
            make.top.equalTo(self.expireTimePriceTitleLabel.snp.bottom).offset(16)
        }
        
        //Description title
        self.descriptionTitleLabel = UILabel(frame: .zero)
        self.contentView.addSubview(self.descriptionTitleLabel)
        self.descriptionTitleLabel.text = "Description:".localized()
        self.descriptionTitleLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.descriptionTitleLabel.snp.makeConstraints { (make) in
            make.top.equalTo(self.lineTopDescription.snp.bottom).offset(8)
            make.leading.equalToSuperview().offset(8)
            make.width.equalTo(self.descriptionTitleLabel.intrinsicContentSize.width)
            make.height.equalTo(21)
        }
        
        //Done dutton and delete button
        //done button
        self.doneButton = UIButton(frame: .zero)
        self.contentView.addSubview(self.doneButton)
        self.doneButton.addTarget(self, action: #selector(ProductViewController.userDidTapOnDone(_:)), for: .touchUpInside)
        self.doneButton.snp.makeConstraints { (make) in
            make.leading.equalTo(self.contentView.snp.leading).offset(8)
            make.trailing.equalTo(self.contentView.snp.trailing).offset(-8)
            make.height.equalTo(44.0)
            make.bottom.equalTo(self.contentView.snp.bottom).offset(-8)
        }
        
        self.doneButton.setTitle("Add".localized(), for: .normal)
        
        self.doneButton.backgroundColor = UIUtility.sormaeiColor()
        self.doneButton.layer.cornerRadius = 5.0
        self.doneButton.titleLabel?.font = UIUtility.boldFontAutoWithPlusSize()
        self.doneButton.setTitleColor(.white, for: .normal)
        
        
        //MARK:- description text view
        self.descriptionTextView = UITextView(frame: .zero)
        self.contentView.addSubview(self.descriptionTextView)
        self.descriptionTextView.delegate = self
        self.descriptionTextView.snp.makeConstraints { (make) in
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().offset(-8)
            make.bottom.equalTo(self.doneButton.snp.top).offset(-8)
            make.top.equalTo(self.descriptionTitleLabel.snp.bottom).offset(4)
        }
        
        self.checkBoxExistLabel.font = UIUtility.normalFontAutoWithPlusSize()

        self.productNameLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.productNameLabel.adjustsFontSizeToFitWidth = true

        self.priceWithGaraunteeValueTextField.font = UIUtility.normalFontAutoWithPlusSize()
        self.priceWithOutGaraunteeValueTextField.font = UIUtility.normalFontAutoWithPlusSize()

        self.checkBoxYesGaruanteeLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.checkBoxNoGaruanteeLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.checkBoxBothGaruanteeLabel.font = UIUtility.normalFontAutoWithPlusSize()

        self.colorValueLabel.font = UIUtility.normalFontAutoWithPlusSize()
        
        self.expireTimePriceValueLabel.font = UIUtility.normalFontAutoWithPlusSize()
        self.expireTimePriceTitleLabel.font = UIUtility.normalFontAutoWithPlusSize()

        self.garaunteeCheckBoxTitle.font = UIUtility.normalFontAutoWithPlusSize()
        
        self.descriptionTextView.font = UIUtility.normalFontAutoWithPlusSize()

        self.descriptionTextView.layer.borderColor = UIColor.lightGray.cgColor
        self.descriptionTextView.layer.borderWidth = 0.5
        self.descriptionTextView.layer.cornerRadius = 3.0
        self.descriptionTextView.layer.masksToBounds = true

        self.checkBoxExist?.delegate = self
        self.checkBoxExist?.onAnimationType = .fill
        self.checkBoxExist?.offAnimationType = .fill
        self.checkBoxExist?.onFillColor = UIUtility.sormaeiColor()
        self.checkBoxExist?.onTintColor = UIUtility.sormaeiColor()
        self.checkBoxExist?.tintColor = .lightGray
        self.checkBoxExist?.onCheckColor = .white

        self.checkBoxYesGaruantee?.delegate = self
        self.checkBoxYesGaruantee?.onAnimationType = .fill
        self.checkBoxYesGaruantee?.offAnimationType = .fill
        self.checkBoxYesGaruantee?.onFillColor = UIUtility.sormaeiColor()
        self.checkBoxYesGaruantee?.onTintColor = UIUtility.sormaeiColor()
        self.checkBoxYesGaruantee?.tintColor = .lightGray
        self.checkBoxYesGaruantee?.onCheckColor = .white

        self.checkBoxNoGaruantee?.delegate = self
        self.checkBoxNoGaruantee?.onAnimationType = .fill
        self.checkBoxNoGaruantee?.offAnimationType = .fill
        self.checkBoxNoGaruantee?.onFillColor = UIUtility.sormaeiColor()
        self.checkBoxNoGaruantee?.onTintColor = UIUtility.sormaeiColor()
        self.checkBoxNoGaruantee?.tintColor = .lightGray
        self.checkBoxNoGaruantee?.onCheckColor = .white

        self.checkBoxBothGaruantee?.delegate = self
        self.checkBoxBothGaruantee?.onAnimationType = .fill
        self.checkBoxBothGaruantee?.offAnimationType = .fill
        self.checkBoxBothGaruantee?.onFillColor = UIUtility.sormaeiColor()
        self.checkBoxBothGaruantee?.onTintColor = UIUtility.sormaeiColor()
        self.checkBoxBothGaruantee?.tintColor = .lightGray
        self.checkBoxBothGaruantee?.onCheckColor = .white

        NotificationCenter.default.addObserver(self, selector: #selector(ProductViewController.showKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)

        NotificationCenter.default.addObserver(self, selector: #selector(ProductViewController.hideKeyboard(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)

        let tapGestureOnView = UITapGestureRecognizer(target: self, action: #selector(ProductViewController.userDidTapOnView))
        let panGestureOnView = UIPanGestureRecognizer(target: self, action: #selector(ProductViewController.userDidTapOnView))
        let tapGestureOnImageView = UITapGestureRecognizer(target: self, action: #selector(ProductViewController.userDidTapOnImageView))
        let panGestureOnImageView = UIPanGestureRecognizer(target: self, action: #selector(ProductViewController.userDidTapOnImageView))

        let tapGestureOnSelectColor = UITapGestureRecognizer(target: self, action: #selector(ProductViewController.userDidTapOnColor))
        let tapGestureOnTitleSelectColor = UITapGestureRecognizer(target: self, action: #selector(ProductViewController.userDidTapOnColor))
        
        self.view.addGestureRecognizer(tapGestureOnView)
        self.view.addGestureRecognizer(panGestureOnView)

        self.imageViewProduct.addGestureRecognizer(tapGestureOnImageView)
        self.imageViewProduct.addGestureRecognizer(panGestureOnImageView)

        self.colorValueLabel.addGestureRecognizer(tapGestureOnSelectColor)
        self.colorValueLabel.isUserInteractionEnabled = true
        self.colorTitleLabel.addGestureRecognizer(tapGestureOnTitleSelectColor)
        self.colorTitleLabel.isUserInteractionEnabled = true

        self.checkBoxExistLabel.setAutomaticAlignment()
        self.priceWithGaraunteeValueTextField.setAutomaticAlignment()
        self.priceWithOutGaraunteeValueTextField.setAutomaticAlignment()
        self.garaunteeTextField.setAutomaticAlignment()
        self.descriptionTextView.setAutomaticAlignment()
        self.colorValueLabel.setAutomaticAlignment()
        self.expireTimePriceValueLabel.setAutomaticAlignment()
        self.expireTimePriceTitleLabel.setAutomaticAlignment()
        self.priceWithGaraunteeTitleLabel.setAutomaticAlignment()
        self.priceWithOutGaraunteeTitleLabel.setAutomaticAlignment()
        self.contentView.setAutomaticDirection()

        self.checkBoxExist.setOn(true, animated: false)
        self.checkBoxBothGaruantee.setOn(true, animated: false)
    
        self.garaunteeTextField.font = UIUtility.normalFontAutoWithPlusSize()
        
        self.view.layoutIfNeeded()

        Service.sharedInstanse.getColors(reloadData: false) { (colors, error) in
            self.colorElements = [MMAlert]()
            if(error == nil){
                self.colors = colors
                for colorId in (self.product?.colors)!{
                    for color in colors!{
                        if(colorId == color.colorId){
                            let alert = MMAlert()
                            alert.title = color.colorTitle
                            alert.idString = color.colorId
                            alert.color = color.colorHex?.hexStringToUIColor()
                            self.colorElements.append(alert)
                        }
                    }
                }
            }
        }
        
        super.initUI()
        self.fillData()
        
    }

    //MARK:- fillData
    private func fillData(){
        if(self.product?.photoURLs != nil && self.product?.photoURLs?.count != 0){
            let url = URL(string:(self.product?.photoURLs?.first)!)
            self.imageViewProduct.kf.setImage(with: url)
        }else if(self.product?.imageUrl != nil){
            let url = URL(string:(self.product?.imageUrl)!)
            self.imageViewProduct.kf.setImage(with: url)
        }
        
        self.productNameLabel.text = self.product?.name
        
        self.checkBoxBothGaruantee.setOn(false, animated: false)
        self.checkBoxNoGaruantee.setOn(false, animated: false)
        self.checkBoxYesGaruantee.setOn(false, animated: false)
        self.disablePartWithOutGarauntee()
        self.disablePartWithGarauntee()
        
    }
    
    //MARK:- checkBox delegate
    func didTap(_ checkBox: BEMCheckBox) {
        if(checkBox == self.checkBoxYesGaruantee){
            self.enablePartWithGarauntee()
            self.disablePartWithOutGarauntee()
            if(checkBox.on){
                self.setOfAllGaraunteeCheckBox()
                self.checkBoxYesGaruantee.setOn(true, animated: true)
            }else{
                self.checkBoxYesGaruantee.setOn(true, animated: false)
            }
        }else if(checkBox == self.checkBoxNoGaruantee){
            self.disablePartWithGarauntee()
            self.enablePartWithOutGarauntee()
            if(checkBox.on){
                self.setOfAllGaraunteeCheckBox()
                self.checkBoxNoGaruantee.setOn(true, animated: true)
            }else{
                self.checkBoxNoGaruantee.setOn(true, animated: false)
            }
        }else if(checkBox == self.checkBoxBothGaruantee){
            self.enablePartWithGarauntee()
            self.enablePartWithOutGarauntee()
            if(checkBox.on){
                self.setOfAllGaraunteeCheckBox()
                self.checkBoxBothGaruantee.setOn(true, animated: true)
            }else{
                self.checkBoxBothGaruantee.setOn(true, animated: false)
            }
        }else if(checkBox == self.checkBoxExist){
            if(checkBox.on){
                
            }else{
                
            }
        }
    }
    
    private func setOfAllGaraunteeCheckBox(){
        self.checkBoxYesGaruantee.setOn(false, animated: false)
        self.checkBoxNoGaruantee.setOn(false, animated: false)
        self.checkBoxBothGaruantee.setOn(false, animated: false)
    }
    
    //MARK:- disable part with garauntee
    private func disablePartWithGarauntee(){
        self.garaunteeTextField.isEnabled = false
        self.garaunteeTitleLabel.isEnabled = false
        self.priceWithGaraunteeValueTextField.isEnabled = false
        self.priceWithGaraunteeTitleLabel.isEnabled = false
    }
    
    //MARK:- enable part with garauntee
    private func enablePartWithGarauntee(){
        self.garaunteeTextField.isEnabled = true
        self.garaunteeTitleLabel.isEnabled = true
        self.priceWithGaraunteeValueTextField.isEnabled = true
        self.priceWithGaraunteeTitleLabel.isEnabled = true
    }
    
    //MARK:- disable part with out garauntee
    private func disablePartWithOutGarauntee(){
        self.priceWithOutGaraunteeValueTextField.isEnabled = false
        self.priceWithOutGaraunteeTitleLabel.isEnabled = false
    }
    
    //MARK:- enable part with out garauntee
    private func enablePartWithOutGarauntee(){
        self.priceWithOutGaraunteeValueTextField.isEnabled = true
        self.priceWithOutGaraunteeTitleLabel.isEnabled = true
    }
    
    //MARK:- user did tap
    @IBAction func userDidTapOnDone(_ sender: Any) {
        print("user did tap on done")
        self.dismissKeyboard()
        
        let (isValidateData, titleError) = self.checkValidataData()
        if(isValidateData){
            self.doneButton.startLoading()
            Service.sharedInstanse.addToCart(product: self.product!, callback: { (cartItem, error) in
                DispatchQueue.main.async {
                    self.doneButton.stopAnimation()
                    if(error == nil){
                        let toast = Toast(text: "Sucessfuly added".localized())
                        toast.show()
                        self.delegate?.dismissProductController(fromController: self)
                    }else{
                        let toast = Toast(text: error?.errorDescription)
                        toast.show()
                    }
                }
            })
        }else{
            let toast = Toast(text: titleError)
            toast.show()
        }
    }
    
    @objc private func userDidTapOnColor(){
        self.dismissKeyboard()
        self.delegate?.showDialogColor(fromController: self, elements: self.colorElements)
    }
    
    @objc private func userDidTapOnView(){
        self.dismissKeyboard()
    }
    
    @objc private func userDidTapOnImageView(){
        self.dismissKeyboard()
    }
    
    private func dismissKeyboard(){
        self.garaunteeTextField.resignFirstResponder()
        self.priceWithGaraunteeValueTextField.resignFirstResponder()
        self.priceWithOutGaraunteeValueTextField.resignFirstResponder()
        self.descriptionTextView.resignFirstResponder()
    }
    
    //MARK:- Notification keyboard
    @objc private func showKeyboard(notification: NSNotification){
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
            UIView.animate(withDuration: 0.3, animations: {
                self.view.layoutIfNeeded()
            })
        }
    }
    
    @objc private func hideKeyboard(notification: NSNotification){
        self.scrollView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded()
        })
    }
    //MARK:- check validata data
    private func checkValidataData() -> (Bool, String){
        if(self.descriptionTextView.text == "" || self.descriptionTextView.text == nil){
            return (false, "Please insert description".localized())
        }
        
        return (true, "")
    }

    //MARK:- textview delegate
    func textViewDidBeginEditing(_ textView: UITextView) {
        self.scrollView.scrollRectToVisible(self.descriptionTextView.frame, animated: true)
    }
    
    //MARK:- alert delegate
    func userDidTapOnElement(fromController: MMAlertSheetViewController, index: Int, withElements: [MMAlert]) {
        if(withElements == self.colorElements){
            let alert = self.colorElements[index]
            alert.isChecked = true
            for alertLocal in self.colorElements{
                if(alertLocal != alert){
                    alertLocal.isChecked = false
                }
            }
            self.colorValueLabel.text = alert.title
            self.delegate?.dismissDialogColor(fromController: fromController)
        }
    }
    
    func userDidTapOnDismissAlertController(fromController: MMAlertSheetViewController) {
        self.delegate?.dismissDialogColor(fromController: fromController)
    }
}
