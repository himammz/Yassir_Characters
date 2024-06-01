//
//  CharacterDetails.swift
//  Yassir_Character
//
//  Created by Ibrahim Mostafa on 01/06/2024.
//

import SwiftUI
import Kingfisher

struct CharacterDetails: View {
    @Environment(\.presentationMode) var presentationMode
    var viewModel: CharacterViewModel
    var body: some View {
        VStack(alignment: .leading) {
            VStack(){
                KFImage(viewModel.imageURL)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                
                    .clipShape(RoundedRectangle(cornerRadius: 25))
                    .shadow(radius: 10)
            }
            
            
            VStack(alignment: .leading) {
                HStack {
                    Text (viewModel.name)
                        .fontWeight(.bold)
                    Spacer()
                    Text (viewModel.status)
                        .padding(10)
                        .background(Color.cyan)
                        .clipShape(RoundedRectangle(cornerRadius: 15))
                }
                
                HStack {
                    Text (viewModel.species)
                        .foregroundStyle(.gray)
                    
                    Text (".")
                        .fontWeight(.bold)
                        .foregroundStyle(.gray)
                    
                    Text (viewModel.gender)
                        .foregroundStyle(.gray)
                }
                
                HStack {
                    Text ("Location:")
                    Text (viewModel.locationName)
                        .foregroundStyle(.gray)
                    
                }
            }
            .padding(14)
            Spacer()
            
        }
        .ignoresSafeArea()
        
        .navigationBarBackButtonHidden()
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                
                Button {
                    presentationMode.wrappedValue.dismiss()
                } label: {
                    
                    Image(systemName: "arrow.backward.circle.fill")
                        .resizable()
                        .frame(width: 40.0, height: 40.0)
                        .foregroundStyle(.black, Color(.systemGray6))
                }
            }
        }
    }
}

#Preview {
    CharacterDetails(viewModel: CharacterViewModel(name: "Name", species: "species", status: "status", gender: "gender", locationName: "", imageString: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
}
