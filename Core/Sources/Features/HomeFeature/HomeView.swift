import SwiftUI
import ComposableArchitecture
import Models
import Assets
import CustomView

public struct HomeView: View {
    public init(store: StoreOf<HomeReducer>) {
        self.store = store
    }
    
    @Perception.Bindable var store: StoreOf<HomeReducer>
    
    public var body: some View {
        ZStack() {
            VStack {
                Header()
                if (store.isLoading) {
                    Text(store.error)
                } else {
                    WorkspacesList(workspacesData: store.workspaces)
                }
                Spacer()
            }
            GeometryReader { geometry in
                AddWorkspaceButton(onTap: {
                    store.send(.toggleShowState)
                })
                    .position(
                        x: geometry.size.width - 30,
                        y: geometry.size.height - 30
                    )
            }
        }
        .padding()
        .sheet(isPresented: $store.showSheet) {
            CreateWorkspaceSheet(store: store)
        }
        .onAppear {
            store.send(.firstFetch)
        }
    }
}

struct Header: View {
    let customColors = CustomColors(theme: .light)
    
    var body: some View {
        HStack {
            HStack {
                ZStack {
                    Circle()
                        .frame(width: 40)
                        .foregroundColor(customColors.colorBlue2)
                    Image(systemName: "person.fill")
                        .resizable()
                        .frame(width: 15, height: 15)
                }
                Text("山本太郎")
                    .font(.system(size: 18, weight: .bold))
                    .foregroundColor(customColors.textColorMain)
            }
            Spacer()
            Button(action: {
            }) {
                Text("編集")
                    .font(.system(size: 16, weight: .bold))
                    .foregroundColor(customColors.textColorMain)
            }
            .padding([.top, .bottom], 6)
            .padding([.leading, .trailing], 12)
            .cornerRadius(.infinity)
            .overlay(
                RoundedRectangle(cornerRadius: .infinity)
                    .stroke(customColors.colorBlue4, lineWidth: 1.5)
            )
        }
    }
}

struct WorkspacesList: View {
    let workspacesData: [WorkspaceModel]
    
    let customColors = CustomColors(theme: .light)

    var body: some View {
        VStack(alignment: .leading) {
            Text("ワークスペース")
                .font(.system(size: 14))
                .foregroundColor(customColors.textColorSub)
            ScrollView {
                VStack(spacing: 10) {
                    ForEach(workspacesData, id: \.id) { workspaceData in
                        WorkspaceListBox(workspaceData: workspaceData)
                    }
                }
                .padding(5)
            }
        }
        .padding(.top, 10)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}


struct AddWorkspaceButton: View {
    let onTap: () -> Void
    
    let customColors = CustomColors(theme: .light)
    
    var body: some View {
        Button(action: {
            onTap()
        }) {
            Image(systemName: "plus")
        }
        .padding()
        .background(customColors.colorBlue6)
        .accentColor(customColors.white)
        .cornerRadius(.infinity)
    }
}

struct WorkspaceListBox: View {
    let workspaceData: WorkspaceModel
    let customColors = CustomColors(theme: .light)

    var body: some View {
        HStack {
            Text(workspaceData.emoji)
                .font(.system(size: 30))
                .padding(20)
                .background(customColors.colorBlue2)
                .cornerRadius(8)
            Text(workspaceData.title)
                .font(.system(size: 18, weight: .bold))
            Spacer()
        }
        .frame(width: .infinity)
        .overlay(
            RoundedRectangle(cornerRadius: 8)
                .stroke(customColors.colorBlue2, lineWidth: 1.5)
        )
    }
}

struct CreateWorkspaceSheet: View {
    @Perception.Bindable var store: StoreOf<HomeReducer>
    let customColors = CustomColors(theme: .light)

    var body: some View {
        VStack {
            SheetHeader(
                title: "ワークスペースを作成",
                leading: AnyView(Button(action: {
                    store.send(.toggleShowState)
                }) {
                    Text("閉じる")
                }),
                actions: AnyView(
                    Button(action: {
                        store.send(.createWorkspace)
                    }) {
                        Text("保存")
                    }
                        .disabled(store.workspaceTitle == "")
                )
            )
            VStack {
                TextField(
                    "ワークスペース名",
                    text: $store.workspaceTitle
                )
                .padding([.top, .bottom], 10)
                .padding([.leading, .trailing], 14)
                .overlay(
                    RoundedRectangle(cornerRadius: 4)
                        .stroke(customColors.textColorPale, lineWidth: 1.5)
                )
            }
            .padding()
            Spacer()
        }
    }
}

#Preview {
    HomeView(
        store: Store(initialState: HomeReducer.State()) {
            HomeReducer()
        }
    )
}
