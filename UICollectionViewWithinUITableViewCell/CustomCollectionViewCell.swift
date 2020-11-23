//
//  CustomCollectionViewCell.swift
//  UICollectionViewWithinUITableViewCell
//
//  Created by Maysam Shahsavari on 2020-11-21.
//

import UIKit

/**
 Methods for handling the button tap.
 */
protocol CustomCollectionViewCellDelegate {
    /**
     Tells the delegate the button is tapped.
     */
    func customButtonDid(indexPath: IndexPath)
}

class CustomCollectionViewCell: UICollectionViewCell, NameDescribable {
    // MARK: - Delegate
    
    var delegate: CustomCollectionViewCellDelegate?

    // MARK: - Outlets
    
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var button: UIButton!
    @IBOutlet weak var wrapperView: UIView!
    
    // MARK: Variables
    
    /// To be returned via the delegate function
    private var indexPath: IndexPath!
    
    private var model: CellDataModel! {
        didSet {
            self.button.isSelected = model.isTapped
            self.wrapperView.backgroundColor = model.color
            if model.isTapped {
                self.label.text = "Tapped"
            } else {
                self.label.text = "Not Tapped"
            }
        }
    }
    
    // MARK: - View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
    }
    
    // MARK: - Private Functions
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        button.setTitle(nil, for: .normal)
        button.setImage(UIImage(systemName: "person.badge.plus"), for: .normal)
        button.setImage(UIImage(systemName: "person.badge.minus"), for: .selected)
        button.tintColor = .white
        
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .white
        label.text = nil
    }
    
    // MARk: - Public API
    func set(data: CellDataModel, indexPath: IndexPath) {
        self.model = data
        self.indexPath = indexPath
        self.wrapperView.backgroundColor = data.color
    }
    
    // MARK: - Outlet Actions
    
    @IBAction func buttonAction(_ sender: UIButton) {
        delegate?.customButtonDid(indexPath: self.indexPath)
    }
    
}


