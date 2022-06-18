//
//  HomeView.swift
//  Peter005_1
//
//  Created by DONG SHENG on 2022/6/18.
//

// #5 Auto Layout 練習(SwiftUI版)
import SwiftUI

struct HomeView: View {
    
    var width = UIScreen.main.bounds.width
    var height = UIScreen.main.bounds.height
    
    @State private var number: Int = 1
 
    var body: some View {
        ZStack{
            Color.brown
        
            Ex1View
                .opacity(number == 1 ? 1 : 0)
            Ex2View
                .opacity(number == 2 ? 1 : 0)
            Ex3View
                .opacity(number == 3 ? 1 : 0)
            Ex4View
                .opacity(number == 4 ? 1 : 0)
            Ex5View
                .opacity(number == 5 ? 1 : 0)
            
            VStack{
                Text("第 \(number) 題")
                    .font(.title)
                    .foregroundColor(.red)
                    .background(Color.white)
                    .cornerRadius(8)
                
                Spacer()
                
                Button {
                    // 到最後一題 時 按下會回到第一題
                    guard number == 5 else { self.number += 1; return }
                    self.number = 1
                } label: {
                    Text("下一題")
                        .font(.title)
                        .background(Color.white)
                        .cornerRadius(8)
                }
            }
            .padding(.vertical ,50)
        }
        .ignoresSafeArea()
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        HomeView()
    }
}

extension HomeView{

    private var Ex1View: some View{
        /*  題目 1:
                3個ImageView
                水平排列、彼此間距 10、距離左右邊界間距 20，
                等寬，
                寬高比例 1 : 2 垂直置中
        */
        HStack(spacing: 10){
            
            // 為了達成題目要求 不加上 .scaledToFit() -> 會超出範圍
            // 所以造成圖片變形
            Image("Movie1")
                .resizable() // 讓圖片可以縮放
            
            Image("Movie2")
                .resizable()
            
            Image("Movie3")
                .resizable()
        }
        // 用來檢查 HStack範圍
        .background(Color.yellow)
        // 取得螢幕寬度
        // 減去頭尾 各 20 單位 (-40)
        // 再扣掉 3張圖片中的間隔 10 * 2 (-20)
        // 這邊得到 3張圖片的寬度總和 之後除以3 就是一張圖片的寬度 ( / 3 )
        // 寬高比 1 : 2 ( * 2 )
        .frame(height: (width - 60) / 3 * 2)
        .padding(.horizontal ,20) // 水平 左右 各20間距
        .overlay(
            VStack{
                // 數字去掉小數點
                Text("螢幕寬度 : " + String(format: "%.0f", width))
                Text("3 張圖片寬度總和(扣掉間距) : " + String(format: "%.0f", width - 60))
                Text("單張圖片寬度 : " + String(format: "%.0f", (width - 60) / 3 ))
                Text("圖片高度 : " + String(format: "%.0f", (width - 60) / 3 * 2))
            }
            .font(.title3.bold())
            .offset(y: -230)
        )
    }
    
    private var Ex2View: some View{
        /*  題目 2:
                2個 Button 水平置中
                Button 彼此間距 10
                垂直置中
                中心點 大約落在 王
        */
        HStack(spacing: 10){
            Button("永遠的小王子"){
                
            }
            
            Button("彼得潘"){
                
            }
        }
        .foregroundColor(Color.white)
    }
    
    private var Ex3View: some View{
        /*
            題目 3:
                3個 Button 水平排列、垂直置中
                彼此的間距 和 邊界的間距 都一樣大
                Button的長度 = 內容文字長度
                不同iPhone尺寸 間距大小不一樣
        */
        HStack{
            Spacer()
            
            Button("愛瘋一切的蘋果"){ }
            
            Spacer()
            
            Button("彼得潘"){ }
            
            Spacer()
            
            Button("小王子"){ }
            
            Spacer()
        }
        .foregroundColor(Color.white)
    }
    
    private var Ex4View: some View{
        /*
            題目 4:
                將 彼得潘圖片 顯示在 (x,y)座標 iPhone螢幕寬度的 1/3 、 高度 2/5 的位置
                圖片寬高指定為 200 * 200
         */
        ZStack{
            // 以左上角為 基準的  寬度的 1/3 、 高度 2/5
            Image("PeterPan")
                .resizable()
                .frame(width: 200, height: 200)
                .position(x: width / 3, y: height * 0.4)
                .overlay(
                    VStack {
                        Text("螢幕寬度(左上) : " + String(format: "%.0f", width) + ",  螢幕高度 : " + String(format: "%.0f", height))
                        
                        Text("X: " + String(format: "%.1f", width / 3) + ", Y: " + String(format: "%.0f", height * 0.4))
                    }
                    .offset(y: -250)
                )
            
            // 以右下角 為基準的 寬度的 1/3 、 高度 2/5
            Image("PeterPan")
                .resizable()
                .frame(width: 200, height: 200)
                .position(x: width / 3 * 2, y: height * 0.6)
                .overlay(
                    VStack {
                        Text("螢幕寬度(右下) : " + String(format: "%.0f", width) + ",  螢幕高度 : " + String(format: "%.0f", height))
                        
                        Text("X: " + String(format: "%.1f", width / 3 * 2) + ", Y: " + String(format: "%.1f", height * 0.6))
                    }
                    .offset(y: 250)
                )
        }
        .background(
            // 方便查看相對位置
            // 每個色塊高度都為螢幕高度的 1/5
            VStack(spacing: 0){
                Color.gray
                    .frame(height: height * 0.2)
                Color.cyan
                    .frame(height: height * 0.2)
                Color.orange
                    .frame(height: height * 0.2)
                Color.yellow
                    .frame(height: height * 0.2)
                Color.brown
                    .frame(height: height * 0.2)
            }
        )
    }
    
    private var Ex5View: some View{
        /*
            題目 5:
                2個 Label 水平排列
                彼此的間距和邊界的間距 都是 10
                當文字內容不夠塞滿畫面時，讓紅色Label拉長
                當文字太多，畫面無法完整呈現時，讓藍色多的字呈現... 紅色維持文字內容長度
         */
        
        // 第一版(未完成) 固定Text框架大小、向左對齊、限制行數:1
        // 無法彈性變換 右邊長度
        HStack(spacing: 10){

            Text("不可能不愛你 你還是離去")
                .lineLimit(1)
                .background(Color.cyan)
                .frame(maxWidth: (width - 30) / 2 ,alignment: .leading)

            Text("抬頭看幾顆星")
                .lineLimit(1)
                .frame(maxWidth: (width - 30) / 2 ,alignment: .leading)
                .background(Color.red)
        }
        .padding(.horizontal ,10)
        
        // 第二版 待改
//        HStack(spacing: 0){
//
//            Text("不可能不愛你 你還是離去")
//                .lineLimit(1)
//
//                .background(Color.cyan)
//
//            HStack {
//                Text("抬頭看幾顆星")
//                    .lineLimit(1)
//                    .fixedSize()
//
//                Spacer()
//            }
//            .background(Color.red)
//            .padding(.leading ,10)
//        }
////        .font(.title)
//        .padding(.horizontal ,10)
    }
}
