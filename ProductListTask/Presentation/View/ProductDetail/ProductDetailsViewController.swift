//
//  ProductDetailsViewController.swift
//  ProductListTask
//
//  Created by sherif on 10/05/2025.
//

import UIKit

class ProductDetailsViewController: UIViewController {

    //MARK: Outlets
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    //MARK: proprties
    
     var product: Product?
    
    //MARK:  view controller lifCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Details"
        navigationController?.navigationBar.tintColor = .black
        configureData()
    }
    
    //MARK:  Helper Function
    
    private func configureData() {
        guard let productImageView = productImageView,
              let productName = productName,
              let priceLabel = priceLabel,
              let categoryLabel = categoryLabel,
              let descriptionLabel = descriptionLabel else {
            print("One or more outlets are not connected")
            return
        }
        productName.text = product?.title
        priceLabel.text = "Price: $\(product?.price ?? 0.0)"
        categoryLabel.text = "Category: \(product?.category ?? "")"
        descriptionLabel.text = "Description:\n\(product?.description ?? "")"
        if let url = URL(string: product?.image ?? "") {
            productImageView.loadImage(from: url)
        }
    }
    
}
