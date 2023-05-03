//
//  TableViewCell.swift
//  DemoProject
//
//  Created by Manisha Vashisth on 01/05/23.
//

import UIKit

class TableViewCell: UITableViewCell {

    // IBOutlet
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var lblDescription: UILabel!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var btnCheckbox: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imgView.layer.cornerRadius = 10
        btnCheckbox.setTitle("", for: .normal)
        btnCheckbox.layer.cornerRadius = 5
        if #available(iOS 13.0, *) {
            btnCheckbox.layer.borderColor = CGColor(red: 238.0/255, green: 133.0/255, blue: 50.0/255, alpha: 1)
        } else {
            // Fallback on earlier versions
        }
        btnCheckbox.layer.borderWidth = 2
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    @IBAction func btnCheckboxAction(_ sender: UIButton) {
        if btnCheckbox.tag == 1 {
            btnCheckbox.tag = 0
            btnCheckbox.tintColor = .white
        } else {
            btnCheckbox.tag = 1
            if #available(iOS 13.0, *) {
                btnCheckbox.setImage(UIImage(systemName: "checkmark"), for: .normal)
            } else {
                // Fallback on earlier versions
            }
            btnCheckbox.tintColor = .black
        }
    }
    
    func configure(tableData: TableData) {
        lblTitle.text = tableData.author
        lblDescription.text = "URL: " + tableData.url
        
        DispatchQueue.global(qos: .background).async {
            do {
                let url = tableData.downloadURL
                let data = try Data.init(contentsOf: URL.init(string: url)!)
                DispatchQueue.main.async {
                    let image: UIImage = UIImage(data: data) ?? UIImage()
                    self.imgView.image = image
                }
            } catch {
                print(error.localizedDescription)
            }
        }
    }

}
