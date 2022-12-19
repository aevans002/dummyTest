//
//  DummyManager.swift
//  DummyExample
//
//  Created by Allan Evans on 12/17/22.
//

import Foundation

protocol DummyManagerDelegate {
    func didUpdateDummy(_ dummyManager:DummyManager, dummy: DummyModel)
    func didFailWithError(error:Error)
}

struct DummyManager {
    let dummyURL = "https://dummyjson.com/products/1#"
    
    var delegate: DummyManagerDelegate?
    
    func fetchDummy() {
        performRequest(with: dummyURL)
    }

    func performRequest(with urlString:String) {
        //1 Create url
        if let url = URL(string: urlString) {
            //2 url session
            let session = URLSession(configuration: .default)
            
            //3 give a task
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                
                if let safeData = data {
                    if let dummyParsed = self.parseJSON(safeData) {
                        self.delegate?.didUpdateDummy(self, dummy: dummyParsed)
                    }
                }
            } //handler using optionals
            
            //4 start task
            task.resume()
        }
    }
    
    func parseJSON(_ dummyData:Data) -> DummyModel? {
        let decoder = JSONDecoder()
        do {
           let decodedData = try decoder.decode(DummyData.self, from: dummyData)
            let id = decodedData.id
            let title = decodedData.title
            let description = decodedData.description
            
            let dummyParsed = DummyModel(dummyId: id, dummyTitle: title, dummyDescription: description)
            //print(weather.conditionName)  //Computed Proptery!!!
            //print(weather.temperatureString)
            return dummyParsed
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

}
