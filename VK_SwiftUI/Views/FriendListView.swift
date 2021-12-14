//
//  FriendListView.swift
//  VK_SwiftUI
//
//  Created by Вадим Терехов on 04.12.2021.
//

import SwiftUI

struct FriendListView: View {

    private var friendList = [User]()

    var body: some View {

        TabView {
            GeometryReader { geometry in
                List {
                    ForEach(friendList) { friend in

                        HStack {

                            Image(friend.avatar!)
                                .resizable()
                                .avatarStyle()

                            VStack {

                                UsernameViewBuilder {
                                    Text(friend.fullName)
                                }

                                //                            .padding(.top)

                                //                  Не получается сделать нормальным поведение меток групп
                                //                  В ZStack реагируют на смещение, но не так: всё равно
                                //                  рандомный разброс

                                //                            GroupTextViewBuilder {
                                //                                Text(" \(friend.group!.rawValue) ")
                                //                            }



                            }

                        }

                    }
                }
                .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height, alignment: .topLeading)
            }
            .navigationBarHidden(false)
            .navigationTitle(Text("Товарищи"))
        }
    }
    
    
    

}



struct FriendListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            FriendListView()
        }
    }
}
