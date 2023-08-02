//
//  ProductOptionSelectViewController.swift
//  Silver Explorer
//
//  Created by Jinyoung Yoo on 2023/07/28.
//

import UIKit

class ProductOptionSelectViewController: UIViewController {
    
    
    @IBOutlet private weak var productImageView: UIImageView!
    @IBOutlet private weak var numberOfProductLabel: UILabel!
    @IBOutlet private weak var productPriceLabel: UILabel!
    
    @IBOutlet weak var hotButton: UIButton!
    @IBOutlet weak var iceButton: UIButton!
    
    @IBOutlet private weak var regularSizeBtnView: UIView!
    @IBOutlet private weak var grandeSizeBtnView: UIView!
    @IBOutlet private weak var ventiSizeBtnView: UIView!
    
    @IBOutlet weak var iceQuantitySelectView: UIView!
    @IBOutlet private weak var lessIceBtnView: UIView!
    @IBOutlet private weak var regularIceBtnView: UIView!
    @IBOutlet private weak var extraIceBtnView: UIView!
    
    private let resource: ProductOptionResource = ProductOptionResource()
    private var selectedSizeBtnView: UIView!
    private var selectedIceBtnView: UIView!
    
    private var numberOfProduct: Int = 1 {
        didSet {
            numberOfProductLabel.text = "\(numberOfProduct)"
        }
    }

    private var price: Int = 4800 {
        didSet {
            finalPrice = price * numberOfProduct
        }
    }
    private var sizeOptionPrice: Int = 0 {
        didSet {
            price -= oldValue
            price += sizeOptionPrice
        }
    }
    private var iceOptionPrice: Int = 0 {
        didSet {
            price -= oldValue
            price += iceOptionPrice
        }
    }
    var finalPrice: Int = 0 {
        didSet {
            let numberFormatter = NumberFormatter()
            numberFormatter.numberStyle = .decimal
            let formattedPrice = numberFormatter.string(from: NSNumber(value: finalPrice))
            productPriceLabel.text = "₩ \(formattedPrice!)"
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        renderDefaultSelectButtons()
    }
    
    // MARK: - IBAction Methods
    
    @IBAction func minusButtonPressed(_ sender: UIButton) {
        if (numberOfProduct > 1) {
            numberOfProduct -= 1
            finalPrice = price * numberOfProduct
        }
    }
    
    @IBAction func plusButtonPressed(_ sender: UIButton) {
        if (numberOfProduct < 5) {
            numberOfProduct += 1
            finalPrice = price * numberOfProduct
        }
    }
    
    @IBAction func hotButtonPressed(_ sender: UIButton) {
        renderSelectedTempButton(temp: .hot)
        renderNotSelectedTempButton(temp: .ice)
        iceQuantitySelectView.isHidden = true
        iceOptionPrice = 0
    }
    
    @IBAction func iceButtonPressed(_ sender: UIButton) {
        renderDefaultIceQuantitySelectButton(isFirst: false)
        renderSelectedTempButton(temp: .ice)
        renderNotSelectedTempButton(temp: .hot)
        iceQuantitySelectView.isHidden = false
        iceOptionPrice = 500
    }

    @IBAction func regularSizeBtnPressed(_ sender: UIButton) {
        renderSelectedSizeButton(size: .regular)
        sizeOptionPrice = 0
    }
    
    @IBAction func grandeSizeBtnPressed(_ sender: UIButton) {
        renderSelectedSizeButton(size: .grande)
        sizeOptionPrice = 500
    }
    
    @IBAction func ventiSizeBtnPressed(_ sender: UIButton) {
        renderSelectedSizeButton(size: .venti)
        sizeOptionPrice = 1000
    }
    
    
    @IBAction func lessIceBtnPressed(_ sender: UIButton) {
        renderSelectedIceQuantityButton(quantity: .less)
    }
    
    @IBAction func regularIceBtnPressed(_ sender: UIButton) {
        renderSelectedIceQuantityButton(quantity: .regular)
    }
    
    @IBAction func extraIceBtnPressed(_ sender: UIButton) {
        renderSelectedIceQuantityButton(quantity: .extra)
    }
}


extension ProductOptionSelectViewController {
    // MARK: - Feature Methods
    
    func renderDefaultSelectButtons() {
        renderDefaultTempSelectButton()
        renderDefaultSizeSelectButton()
        renderDefaultIceQuantitySelectButton(isFirst: true)
    }
    
    // MARK: - Product Temperature Feature Methods
    
    func renderDefaultTempSelectButton() {
        renderSelectedTempButton(temp: .hot)
        renderNotSelectedTempButton(temp: .ice)
        iceQuantitySelectView.isHidden = true
    }
    
    func renderSelectedTempButton(temp: ProductTemperature) {
        var tempButton: UIButton!
        
        switch temp {
        case .hot:
            tempButton = hotButton
            tempButton.layer.backgroundColor = UIColor(hex: "#FF0000").cgColor
        case .ice:
            tempButton = iceButton
            tempButton.layer.backgroundColor = UIColor(hex: "#0047FF").cgColor
        }
        
        tempButton.tintColor = .white
        tempButton.layer.cornerRadius = 10
    }
    
    func renderNotSelectedTempButton(temp: ProductTemperature) {
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
    
    // MARK: - Product Size Feature Methods
    
    func renderDefaultSizeSelectButton() {
        regularSizeBtnView.backgroundColor = .clear
        regularSizeBtnView.layer.borderWidth = 3.0
        regularSizeBtnView.layer.borderColor = UIColor(hex: "#699FFE").cgColor
        selectedSizeBtnView = regularSizeBtnView
    }
    
    func renderSelectedSizeButton(size: ProductSize) {
        
        // 이전에 선택되었던 selectedSizeBtnView를 선택 안된 모습으로 변경
        selectedSizeBtnView.backgroundColor = UIColor(hex: "#D9D9D9")
        selectedSizeBtnView.layer.borderWidth = 0.0
        selectedSizeBtnView.layer.borderColor = UIColor.clear.cgColor


        // 선택된 sizeBtnView를 선택된 모습으로 변경
        var sizeButtonView: UIView!
        switch size {
        case .regular:
            sizeButtonView = regularSizeBtnView
        case .grande:
            sizeButtonView = grandeSizeBtnView
        case .venti:
            sizeButtonView = ventiSizeBtnView
        }
        
        sizeButtonView.backgroundColor = .clear
        sizeButtonView.layer.borderWidth = 3.0
        sizeButtonView.layer.borderColor = UIColor(hex: "#699FFE").cgColor
        
        selectedSizeBtnView = sizeButtonView
    }
    
    // MARK: - Product Ice Quantity Feature Methods
    
    func renderDefaultIceQuantitySelectButton(isFirst: Bool) {
        
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
    
    func renderSelectedIceQuantityButton(quantity: IceQuantity) {
        
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
