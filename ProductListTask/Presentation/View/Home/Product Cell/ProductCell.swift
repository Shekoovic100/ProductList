//
//  ProductCell.swift
//  ProductListTask
//
//  Created by sherif on 10/05/2025.
//

import UIKit

class ProductCell: UICollectionViewCell {
    
    static let identifier = "ProductCell"
    //MARK: Outlets
    @IBOutlet weak var productPrice: UILabel!
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var backGroundView: UIView!
     
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupUI()
    }
    
    //MARK:  Helper function
    
    private func setupUI() {
        backGroundView.layer.borderWidth = 0.8
        backGroundView.layer.borderColor = UIColor.label.cgColor
        backGroundView.layer.masksToBounds = true
        backGroundView.layer.cornerRadius = 8
    }
    
    func configureCell(with product: Product , isGrid: Bool) {
        productName.text =  product.title
        productPrice.text = String(format: "$%.2f", product.price)
        if let url = URL(string: product.image) {
            productImage.loadImage(from: url)
        }
    }

}
