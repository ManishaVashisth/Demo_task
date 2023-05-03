//
//  ViewModel.swift
//  DemoProject
//
//  Created by Manisha Vashisth on 01/05/23.
//

import Foundation

class ViewModel: NSObject {
    
    var bindTbldetailsViewModelToController : ((Int,String) -> ()) = {_,_  in }
    
    func viewModelServices() {
    
        guard let url = URL(string: "https://picsum.photos/v2/list?page=2&limit=20") else{
            return
        }
        
        let task = URLSession.shared.dataTask(with: url){
            data, response, error in
            
            if let data = data, let string = String(data: data, encoding: .utf8){
                print(string)
                
                let jsonDecoder = JSONDecoder()
                do {
                    TableDataManger.shared.tableData = try! jsonDecoder.decode([TableData].self, from: data)
                    self.bindTbldetailsViewModelToController(1,"success")
                    
                    
                } catch {
                    print(error.localizedDescription)
                    self.bindTbldetailsViewModelToController(0,"fail")
                }
            }
        }
        task.resume()
                
    }
    
}
