//
//  ContentView.swift
//  NetworkingApp
//
//  Created by zayn on 10/05/25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var foodModel = FoodViewModel()
    
    @FocusState var searching
    @State private var searchText = ""
    
    var body: some View {
        VStack {
            
            if !searching {
                
                RectangleLoaderView()
                    .animation(.smooth)
                
                TextWithAnimation()
                    .animation(.smooth)
            }
            
            searchBar
                .padding(30)
                .animation(.snappy)
                .onChange(of: searchText) { searchText, error in
                    DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                        foodModel.fetchFood(searchText: searchText)
                    }
                }
            
            if searching {
                Spacer()
                
                ScrollView {
                    ForEach(foodModel.foods) { food in
                        infoCard(food: food)
                    }
                    .animation(.snappy)
                }
            }
        }
    }
    
    var searchBar: some View {
        HStack {
            Image(systemName: searching ? "chevron.backward.circle.fill" : "magnifyingglass")
                .font(.title2)
                .foregroundColor(.gray)
                .animation(.linear)
                .padding(.horizontal, 6)
                .onTapGesture {
                    searching.toggle()
                    searchText = ""
                    foodModel.foods = []
                }
            
            TextField("Search Places", text: $searchText)
            .padding(.vertical, 12)
            .focused($searching)
            
            if !searchText.isEmpty {
                Button(action: {
                    searchText = ""
                    foodModel.foods = []
                }) {
                    Image(systemName: "xmark.circle.fill")
                        .foregroundColor(.gray)
                }
                .padding(.trailing, 8)
            }
        }
        .padding(.horizontal, 12)
        .frame(height:35)
        .padding(.vertical, 8)
        .background(Capsule().fill(.regularMaterial))
        .shadow(color: Color.black.opacity(0.3), radius: 25)
        .padding(.top, 40)
    }

    func infoCard(food: Food) -> some View {
        VStack(alignment: .leading, spacing: 12) {
            // Header with food name
            Text(food.name)
                .font(.system(size: 18, weight: .bold))
                .foregroundColor(.primary)
                .lineLimit(2)
                .padding(.bottom, 4)
            
            // Divider between header and content
            Divider()
                .background(Color(.systemGray4))
            
            // Nutrients section header
            Text("Nutrition Facts")
                .font(.system(size: 14, weight: .semibold))
                .foregroundColor(.secondary)
                .padding(.top, 2)
            
            // Nutrient list
            ForEach(food.foodNutrients) { nutrient in
                HStack(alignment: .center) {
                    // Nutrient name
                    Text(nutrient.name)
                        .font(.system(size: 14))
                        .foregroundColor(.primary)
                        .lineLimit(1)
                    
                    Spacer()
                    
                    // Nutrient value with unit indication
                    Text(String(format: "%.1f", nutrient.amount))
                        .font(.system(size: 14, weight: .medium))
                        .foregroundColor(.primary)
                        + Text(" g") // Add appropriate unit here
                        .font(.system(size: 14))
                        .foregroundColor(.secondary)
                }
                .padding(.vertical, 4)
                
                // Subtle divider between nutrients
                if nutrient.id != food.foodNutrients.last?.id {
                    Divider()
                        .background(Color(.systemGray5))
                }
            }
        }
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color(.systemBackground))
                .shadow(color: Color.black.opacity(0.1), radius: 5, x: 0, y: 2)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color(.systemGray5), lineWidth: 0.5)
        )
        .padding(.horizontal, 16)
        .padding(.vertical, 8)
    }
}

#Preview {
    ContentView()
}
