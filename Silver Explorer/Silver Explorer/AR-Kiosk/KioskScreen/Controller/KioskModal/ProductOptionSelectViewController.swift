//
//  ProductOptionSelectViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/28.
//

import UIKit

class ProductOptionSelectViewController: UIViewController {
    
    // MARK: - IBOutlet Properties

    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var numberOfProductLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    
    @IBOutlet private weak var hotButton: UIButton!
    @IBOutlet private weak var iceButton: UIButton!
    
    @IBOutlet private weak var regularSizeBtnView: UIView!
    @IBOutlet private weak var grandeSizeBtnView: UIView!
    @IBOutlet private weak var ventiSizeBtnView: UIView!
    
    @IBOutlet private weak var iceQuantitySelectView: UIView!
    @IBOutlet private weak var lessIceBtnView: UIView!
    @IBOutlet private weak var regularIceBtnView: UIView!
    @IBOutlet private weak var extraIceBtnView: UIView!
    
    // MARK: Stored Properties
    
    private let resource: ProductOptionResource = ProductOptionResource()
    weak var kioskMenuBoardDelegate: KioskMainBoardDelegate?
    private var selectedSizeBtnView: UIView!
    private var selectedIceBtnView: UIView!

    // MARK: - Computed Properties
    private var productName: String {
        guard let name = kioskMenuBoardDelegate?.productForSelectingOption().productName else {
            self.dismiss(animated: false)
            return ""
        }
        return name
    }
    private var productType: ProductType {
        guard let type = kioskMenuBoardDelegate?.productForSelectingOption().productType else {
            self.dismiss(animated: false)
            return .none
        }
        return type
    }
    private var productImage : String {
        guard let name = kioskMenuBoardDelegate?.productForSelectingOption().productImage else {
            self.dismiss(animated: false)
            return ""
        }
        return name
    }
    
    // MARK: - Property Observers
    
    private var numberOfProduct: Int = 1 {
        didSet {
            numberOfProductLabel.text = "\(numberOfProduct)"
        }
    }
    private var singlePrice: Int = 0 {
        didSet {
            finalPrice = singlePrice * numberOfProduct
        }
    }
    private var sizeOptionPrice: Int = 0 {
        didSet {
            singlePrice -= oldValue
            singlePrice += sizeOptionPrice
        }
    }
    private var iceOptionPrice: Int = 0 {
        didSet {
            singlePrice -= oldValue
            singlePrice += iceOptionPrice
        }
    }
    private var finalPrice: Int = 0 {
        didSet {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedPrice = numberFormatter.string(from: NSNumber(value: finalPrice))
            productPriceLabel.text = "₩ \(formattedPrice!)"
        }
    }
    
    // MARK: - Instance Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        initialSettingForSelectingOption()
    }
    
    func appear(sender: UIViewController) {
        self.modalPresentationStyle = .overFullScreen
        sender.present(self, animated: false)
    }
    
    // MARK: - IBAction Methods
    
    @IBAction private func minusButtonPressed(_ sender: UIButton) {
        if (numberOfProduct > 1) {
            numberOfProduct -= 1
            finalPrice = singlePrice * numberOfProduct
        }
    }
    
    @IBAction private func plusButtonPressed(_ sender: UIButton) {
        if (numberOfProduct < 5) {
            numberOfProduct += 1
            finalPrice = singlePrice * numberOfProduct
        }
    }
    
    @IBAction private func hotButtonPressed(_ sender: UIButton) {
        if (productType == .new) {
            return // 신메뉴는 무조건 ice이다.
        }
        renderSelectedTempButton(temp: .hot)
        renderNotSelectedTempButton(temp: .ice)
        iceOptionPrice = 0
    }
    
    @IBAction private func iceButtonPressed(_ sender: UIButton) {
        if (productType == .new) {
            return // 신메뉴는 무조건 ice이다.
        }
        renderDefaultIceQuantitySelectButton(isFirst: false)
        renderSelectedTempButton(temp: .ice)
        renderNotSelectedTempButton(temp: .hot)
        iceOptionPrice = 500
    }

    @IBAction private func regularSizeBtnPressed(_ sender: UIButton) {
        renderSelectedSizeButton(size: .regular)
    }
    
    @IBAction private func grandeSizeBtnPressed(_ sender: UIButton) {
        renderSelectedSizeButton(size: .grande)
    }
    
    @IBAction private func ventiSizeBtnPressed(_ sender: UIButton) {
        renderSelectedSizeButton(size: .venti)
    }
    
    
    @IBAction private func lessIceBtnPressed(_ sender: UIButton) {
        renderSelectedIceQuantityButton(quantity: .less)
    }
    
    @IBAction private func regularIceBtnPressed(_ sender: UIButton) {
        renderSelectedIceQuantityButton(quantity: .regular)
    }
    
    @IBAction private func extraIceBtnPressed(_ sender: UIButton) {
        renderSelectedIceQuantityButton(quantity: .extra)
    }
    
    @IBAction private func cancelBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: false)
    }
    
    @IBAction private func addCartBtnPressed(_ sender: UIButton) {
        let product = Product(productName: productName, numberOfProduct: numberOfProduct, singleProductPrice: singlePrice, totalProductPrice: finalPrice)
        kioskMenuBoardDelegate?.productForCart(product: product)
        
        self.dismiss(animated: false)
    }
}


extension ProductOptionSelectViewController {
    // MARK: - Initial Setting Method
    
    private func initialSettingForSelectingOption() {
        guard let price = kioskMenuBoardDelegate?.productForSelectingOption().singleProductPrice else {
            self.dismiss(animated: false)
            return
        }
        singlePrice = price
        
        productNameLabel.text = productName
        productImageView.image = UIImage(named: productImage)
        
        renderDefaultTempSelectButton()
        renderDefaultSizeSelectButton()
        renderDefaultIceQuantitySelectButton(isFirst: true)
    }
    
    // MARK: - Product Temperature Option Feature Methods
    
    private func renderDefaultTempSelectButton() {
        if (productType == .new) {
            hotButton.isHidden = false
            renderSelectedTempButton(temp: .ice)
        } else {
            renderSelectedTempButton(temp: .hot)
            renderNotSelectedTempButton(temp: .ice)
        }
    }
    
    private func renderSelectedTempButton(temp: ProductTemperature) {
        var tempButton: UIButton!
        
        switch temp {
        case .hot:
            tempButton = hotButton
            tempButton.layer.backgroundColor = UIColor(hex: "#FF0000").cgColor
            iceQuantitySelectView.isHidden = true
        case .ice:
            tempButton = iceButton
            tempButton.layer.backgroundColor = UIColor(hex: "#0047FF").cgColor
            iceQuantitySelectView.isHidden = false
        }
        
        tempButton.tintColor = .white
        tempButton.layer.cornerRadius = 10
    }
    
    private func renderNotSelectedTempButton(temp: ProductTemperature) {
        var tempButton: UIButton!

        switch temp {
        case .hot:
            tempButton = hotButton
            tempButton.tintColor = UIColor(hex: "#FF0000")
            tempButton.layer.borderColor = UIColor(hex: "#FF0000").cgColor
        case .ice:
            tempButton = iceButton
            tempButton.tintColor = UIColor(hex: "#0047FF")
            tempButton.layer.borderColor = UIColor(hex: "#0047FF").cgColor
        }

        tempButton.layer.backgroundColor = UIColor.clear.cgColor
        tempButton.layer.borderWidth = 2.0
        tempButton.layer.cornerRadius = 10
    }
    
    // MARK: - Product Size Option Feature Methods
    
    private func renderDefaultSizeSelectButton() {
        regularSizeBtnView.backgroundColor = .clear
        regularSizeBtnView.layer.borderWidth = 3.0
        regularSizeBtnView.layer.borderColor = UIColor(hex: "#699FFE").cgColor
        selectedSizeBtnView = regularSizeBtnView
    }
    
    private func renderSelectedSizeButton(size: ProductSize) {
        
        // 이전에 선택되었던 selectedSizeBtnView를 선택 안된 모습으로 변경
        selectedSizeBtnView.backgroundColor = UIColor(hex: "#D9D9D9")
        selectedSizeBtnView.layer.borderWidth = 0.0
        selectedSizeBtnView.layer.borderColor = UIColor.clear.cgColor


        // 선택된 sizeBtnView를 선택된 모습으로 변경
        var sizeButtonView: UIView!
        switch size {
        case .regular:
            sizeButtonView = regularSizeBtnView
            sizeOptionPrice = 0
        case .grande:
            sizeButtonView = grandeSizeBtnView
            sizeOptionPrice = 500
        case .venti:
            sizeButtonView = ventiSizeBtnView
            sizeOptionPrice = 1000
        }
        
        sizeButtonView.backgroundColor = .clear
        sizeButtonView.layer.borderWidth = 3.0
        sizeButtonView.layer.borderColor = UIColor(hex: "#699FFE").cgColor
        
        selectedSizeBtnView = sizeButtonView
    }
    
    // MARK: - Product Ice Quantity Option Feature Methods
    
    private func renderDefaultIceQuantitySelectButton(isFirst: Bool) {
        
        if (isFirst == false) {
            selectedIceBtnView.backgroundColor = UIColor(hex: "#D9D9D9")
            selectedIceBtnView.layer.borderWidth = 0.0
            selectedIceBtnView.layer.borderColor = UIColor.clear.cgColor
        }

        regularIceBtnView.backgroundColor = .clear
        regularIceBtnView.layer.borderWidth = 3.0
        regularIceBtnView.layer.borderColor = UIColor(hex: "#699FFE").cgColor
        selectedIceBtnView = regularIceBtnView
    }
    
    private func renderSelectedIceQuantityButton(quantity: IceQuantity) {
        
        selectedIceBtnView.backgroundColor = UIColor(hex: "#D9D9D9")
        selectedIceBtnView.layer.borderWidth = 0.0
        selectedIceBtnView.layer.borderColor = UIColor.clear.cgColor
        
        // 이전에 선택되었던 selectedIceBtnView를 선택 안된 모습으로 변경
        selectedIceBtnView.backgroundColor = UIColor(hex: "#D9D9D9")
        selectedIceBtnView.layer.borderWidth = 0.0
        selectedIceBtnView.layer.borderColor = UIColor.clear.cgColor

        
        // 선택된 iceBtnView를 선택된 모습으로 변경
        var iceQuantityButtonView: UIView!
        switch quantity {
        case .less:
            iceQuantityButtonView = lessIceBtnView
        case .regular:
            iceQuantityButtonView = regularIceBtnView
        case .extra:
            iceQuantityButtonView = extraIceBtnView
        }
        
        iceQuantityButtonView.backgroundColor = .clear
        iceQuantityButtonView.layer.borderWidth = 3.0
        iceQuantityButtonView.layer.borderColor = UIColor(hex: "#699FFE").cgColor
        
        selectedIceBtnView = iceQuantityButtonView
    }
    
}
