//
//  ContentView.swift
//  pruebaapp
//
//  Created by sergio manuel pozos moran on 05/07/23.
//

import SwiftUI

struct ContentView: View {
    
    @State private var products: [Product] = []
    let fontSize: CGFloat = 12
    
    var body: some View {
        VStack {
            Text("Productos")
                .font(.system(size: 24, weight: .bold))
                .foregroundColor(Color(hex: "#0A4AA3"))
                .frame(maxWidth: .infinity)
                .padding(.vertical, 24)
            NavigationView {
                List(products, id: \.id) { product in
                    NavigationLink(destination: DetailView(product: product).navigationBarBackButtonHidden(true)) {
                        VStack(alignment: .leading) {
                            Text(product.title)
                                .font(.headline)
                                .padding(EdgeInsets(top: 16, leading: 16, bottom: 8, trailing: 16))
                            Text(product.description)
                                .foregroundColor(.gray)
                                .multilineTextAlignment(.center)
                                .padding(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                                .font(.system(size: fontSize))
                            Text("Precio: $\(product.price)")
                                .padding(EdgeInsets(top: 8, leading: 16, bottom: 16, trailing: 16))
                        } .padding(16)
                            .border(Color(hex: "#0A4AA3"), width: 1)
                            .frame(width: 300, height: 150)
                            .padding(EdgeInsets(top: 12, leading: 16, bottom: 8, trailing: 16))
                            .listStyle(DefaultListStyle())
                            .listRowInsets(EdgeInsets())
                    }
                }
                .onAppear {
                    fetchProducts()
                }
            }
        }
    }
    func fetchProducts() {
        guard let url = URL(string: "https://dummyjson.com/products/") else {
            print("URL Invalida")
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            if let data = data {
                do {
                    let decodedData = try JSONDecoder().decode(ProductResponse.self, from: data)
                    DispatchQueue.main.async {
                        self.products = decodedData.products
                    }
                } catch {
                    print("Error decoding JSON: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
