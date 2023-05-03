//
//  ViewController.swift
//  DemoProject
//
//  Created by Manisha Vashisth on 01/05/23.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //IBOutlet
    @IBOutlet weak var tblView: UITableView!
    
    // IBVariable
    var vm = ViewModel()
    let refreshControl = UIRefreshControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadTable()
        setupTableview()
        addRereshControl()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
            return .portrait
        }

}

// extension for table view
extension HomeViewController {
    func setupTableview() {
        tblView.dataSource = self
        tblView.delegate = self
        tblView.isScrollEnabled = true
        tblView.isPagingEnabled = true
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("numberOfRowsInSection count", TableDataManger.shared.tableData.count)
        return TableDataManger.shared.tableData.count
//        return 8
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:"TableViewCell", for: indexPath) as! TableViewCell
        let tblData = TableDataManger.shared.tableData
        cell.configure(tableData: tblData[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        123
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let indexPath = IndexPath(row: indexPath.row, section: 0)
        let cell = tblView.cellForRow(at: indexPath) as! TableViewCell
        
        if cell.btnCheckbox.tag == 1{
            
            let alert = UIAlertController(title: "Hello!!!", message: cell.lblDescription.text , preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            
        } else {
            let alert = UIAlertController(title: "Hello!!!", message: "Please enable checkbox.", preferredStyle: UIAlertController.Style.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

// extension for functions
extension HomeViewController {
    
    func loadTable() {
        vm.viewModelServices()
        
        self.vm.bindTbldetailsViewModelToController = { status, message in
            if message == "success" {
                DispatchQueue.main.async {
                    self.tblView.reloadData()
                }
            }
        }
    }
    
    func addRereshControl() {
        refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
        tblView.addSubview(refreshControl)
    }
    
    @objc func refresh(_ sender: AnyObject) {
        self.loadTable()
        refreshControl.endRefreshing()
    }
}


