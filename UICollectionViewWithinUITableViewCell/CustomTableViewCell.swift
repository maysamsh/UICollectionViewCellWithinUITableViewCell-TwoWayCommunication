//
//  CustomTableViewCell.swift
//  UICollectionViewWithinUITableViewCell
//
//  Created by Maysam Shahsavari on 2020-11-21.
//

import UIKit

class CustomTableViewCell: UITableViewCell, NameDescribable {
    
    // MARK: Injected Values
    
    private var collectionCellDelegate: CustomCollectionViewCellDelegate?
    private var section: Int!
    private var customCellsData = [CellDataModel]() {
        didSet {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
                self.collectionView.layoutIfNeeded()
            }
        }
    }
    
    
    var collectionViewOffset: CGFloat {
        set {
            collectionView.contentOffset.x = newValue
        }
        get {
            return collectionView.contentOffset.x
        }
    }
    
        
    // MARK: - Outlets
    
    @IBOutlet weak private var collectionView: UICollectionView!
    
    // MARK: - View lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        configure()
    }

    override func prepareForReuse() {
        super.prepareForReuse()
    }
    // MARK: Private Functions
    
    private func configure() {
        self.translatesAutoresizingMaskIntoConstraints = false
        self.selectionStyle = .none
        collectionView.register(UINib(nibName: CustomCollectionViewCell.typeName, bundle: nil), forCellWithReuseIdentifier: CustomCollectionViewCell.typeName)
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
     // MARK: - Public API
    func set(cellsData: [CellDataModel], section: Int, collectionCellDelegate: CustomCollectionViewCellDelegate) {
        self.customCellsData = cellsData

        self.section = section
        self.collectionCellDelegate = collectionCellDelegate
    }
    
    func updateModel(_ data: [CellDataModel]) {
        self.customCellsData = data
    }
}

// MARK: - UICollectionView Delegate, UICollectionView Data Source, UICollectionView Delegate FlowL ayout
extension CustomTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return customCellsData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CustomCollectionViewCell.typeName, for: indexPath) as? CustomCollectionViewCell  else {
            return UICollectionViewCell()
        }
        
        // Constructing the index path which will be returned by the collection view cell's delegate
        let _indexPath = IndexPath(row: indexPath.row, section: self.section)
        cell.set(data: self.customCellsData[indexPath.row], indexPath: _indexPath)
        cell.delegate = self.collectionCellDelegate
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // I'd prefer to get this size from the parent
        return CGSize(width: 100, height: 100)
    }
}
