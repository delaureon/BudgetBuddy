//
//  FilteredDetailView.swift
//  budgetApp
//
//  Created by csuftitan on 12/15/22.
//

import SwiftUI

struct FilteredDetailView: View {
    @EnvironmentObject var expenseViewModel: ExpenseViewModel
    @Environment(\.self) var env
    @Namespace var animation
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            VStack(spacing: 15) {
                HStack(spacing: 15) {
                    Button {
                        env.dismiss()
                    } label: {
                        Image(systemName: "arrow.backward")
                            .foregroundColor(.gray)
                            .frame(width: 40, height: 40)
                            .background(Color.white, in: RoundedRectangle(cornerRadius: 10, style: .continuous))
                            .shadow(color: .black.opacity(0.1), radius: 5, x: 5, y: 5)
                    }
                    
                    Text("Transactions")
                        .font(.title.bold())
                        .opacity(0.7)
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                }
                CustomSegmentControl()
                    .padding(.top)
                
                VStack(spacing: 15) {
                    Text(expenseViewModel.convertDateToString())
                        .opacity(0.7)
                    Text(expenseViewModel.convertExpensesToCurrency(expenses: expenseViewModel.expenses, type: expenseViewModel.tabName))
                        .font(.title.bold())
                        .opacity(0.9)
                        .animation(.none, value: expenseViewModel.tabName)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background{
                    RoundedRectangle(cornerRadius: 15, style: .continuous)
                        .fill(.white)
                }
                .padding(.vertical,20)
                
                ForEach(expenseViewModel.expenses.filter{
                    return $0.type == expenseViewModel.tabName
                }){expense in
                    TransactionCardView(expense: expense)
                        .environmentObject(expenseViewModel)
                }
            }
            .padding()
        }
        .navigationBarHidden(true)
        .background{
            Color("background")
                .ignoresSafeArea()
        }
        .overlay {
            FilterView()
        }
    }
    
    @ViewBuilder
    func FilterView() -> some View {
        ZStack{
            Color.black
                .opacity(expenseViewModel.showFilterView ? 0.25 : 0)
                .ignoresSafeArea()
            
            if expenseViewModel.showFilterView{
                VStack(alignment: .leading, spacing: 10) {
                    Text("Start Date")
                        .font(.caption)
                        .opacity(0.7)
                    DatePicker("", selection:
                                $expenseViewModel.startDate,in:Date.distantPast...Date(), displayedComponents: [.date])
                    Text("End Date")
                        .font(.caption)
                        .opacity(0.7)
                        .padding(.top, 10)
                    DatePicker("", selection:
                                $expenseViewModel.startDate,in:Date.distantPast...Date(), displayedComponents: [.date])
                    
                }
                .padding(20)
                background{
                    RoundedRectangle(cornerRadius: 10, style: .continuous)
                        .fill(.white)
                }
                .overlay(alignment: .trailing, content: {
                    Button {
                        expenseViewModel.showFilterView = false
                    } label: {
                        Image(systemName: "xmark.circle.fill")
                            .font(.title)
                            .foregroundColor(.black)
                            .padding(5)
                    }
                })
                .padding()
            }
        }
        .animation(.easeInOut, value: expenseViewModel.showFilterView)
    }
    
    @ViewBuilder
    func CustomSegmentControl()->some View {
        HStack(spacing: 0) {
            ForEach([ExpenseType.income, ExpenseType.expense], id: \.rawValue) {tab in
                Text(tab.rawValue)
                    .fontWeight(.semibold)
                    .foregroundColor(expenseViewModel.tabName == tab ? .white : .black)
                    .opacity(expenseViewModel.tabName == tab ? 1 : 0.7)
                    .padding(.vertical, 12)
                    .frame(maxWidth: .infinity)
                    .background{
                        if expenseViewModel.tabName == tab {
                            RoundedRectangle(cornerRadius: 10, style: .continuous)
                                .fill(
                                    LinearGradient(colors: [
                                    Color("GradiOrange"),
                                    Color("GradiTurq")
                                    ], startPoint: .topLeading, endPoint: .bottomTrailing)
                                )
                                .matchedGeometryEffect(id: "TAB", in: animation)
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        withAnimation{expenseViewModel.tabName = tab}
                    }
            }
        }
        .padding(5)
        .background {
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(.white)
        }
    }
}

struct FilteredDetailView_Previews: PreviewProvider {
    static var previews: some View {
        FilteredDetailView()
            .environmentObject(ExpenseViewModel())
    }
}
