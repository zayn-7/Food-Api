//
//  CoinsViewModel.swift
//  NetworkingApp
//
//  Created by zayn on 10/05/25.
//

import Foundation

class FoodViewModel: ObservableObject {
    @Published var foods: [Food] = []
    
    func fetchFood (searchText: String) {
        let urlString = "https://api.nal.usda.gov/fdc/v1/foods/search?query=\(searchText)&dataType=Branded&pageSize=10&pageNumber=0&sortBy=dataType.keyword&sortOrder=asc&api_key=bwYu9QZxI28qGR9Lbr3iOpbChp2aC2nd0T5Wq9UM"
        guard let url = URL(string: urlString) else { return  }
        
        print("Fetching Data")
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            do {
                let decoder = JSONDecoder()
                let food = try decoder.decode(Foods.self, from: data)
                
                DispatchQueue.main.async {
                    self.foods = food.foods
                }
            } catch {
                print("Error decoding JSON:", error)
            }
        }.resume()

        
        print("Did reach end of function")
    }
}
