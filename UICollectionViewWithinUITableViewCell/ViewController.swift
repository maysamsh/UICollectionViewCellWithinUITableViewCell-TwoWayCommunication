//
//  ViewController.swift
//  UICollectionViewWithinUITableViewCell
//
//  Created by Maysam Shahsavari on 2020-11-21.
//

import UIKit
/**
 Struct to feed the cell.
 */
struct CellDataModel {
    let color: UIColor
    var isTapped: Bool
}

typealias RowData = [CellDataModel]

class ViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    private var rows = [RowData]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        initilizeRowsData()
        configure()
    }
    
    private func randomColor() -> UIColor{
        let red = CGFloat(drand48())
        let green = CGFloat(drand48())
        let blue = CGFloat(drand48())
        return UIColor(red: red, green: green, blue: blue, alpha: 1.0)
    }
    
    private func initilizeRowsData() {
        // Rows
        for _ in 0...15 {
            var cells = RowData()
            // Cells within rows
            for _ in 0...15 {
                let cell = CellDataModel(color: randomColor(), isTapped: false)
                cells.append(cell)
            }
            
            rows.append(cells)
        }
    }
    
    private func configure() {
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.register(UINib(nibName: CustomTableViewCell.typeName, bundle: nil), forCellReuseIdentifier: CustomTableViewCell.typeName)
    }
}

// MARK: - UITableView Delegate, UITableView Data Source
extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return rows.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: CustomTableViewCell.typeName, for: indexPath) as? CustomTableViewCell  else {
            return UITableViewCell()
        }
        cell.set(cellsData: self.rows[indexPath.section], section: indexPath.section, collectionCellDelegate: self)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

//
extension ViewController: CustomCollectionViewCellDelegate {
    func customButtonDid(indexPath: IndexPath) {
        let currentValue = self.rows[indexPath.section][indexPath.row].isTapped
        self.rows[indexPath.section][indexPath.row].isTapped = !currentValue
        
        // Each section has only one row
        let tableViewIndexPath = IndexPath(row: 0, section: indexPath.section)
        // Get hold of the parent row of selected colletion view
        let hostRowCell = tableView.cellForRow(at: tableViewIndexPath) as? CustomTableViewCell
        hostRowCell?.updateModel(self.rows[indexPath.section])
    }
}
