import Foundation
import ComposableArchitecture
import Models

@Reducer
public struct HomeReducer {
    @ObservableState
    public struct State: Equatable {
        var showSheet = false
        var workspaces: [WorkspaceModel] = [
            WorkspaceModel(id: 1, title: "Workspace 1", emoji: "😀", user_id: 100, created_at: "2024-07-10T12:00:00Z"),
            WorkspaceModel(id: 2, title: "Workspace 2", emoji: "😀", user_id: 100, created_at: "2024-07-10T12:00:00Z")
        ]
        var workspaceTitle = ""
    }
    public enum Action: BindableAction {
        case toggleShowState
        case changeWorkspaceTitle(String)
        case createWorkspace
        case binding(BindingAction<State>)
    }
    
    public var body: some Reducer<State, Action> {
        BindingReducer()
            .onChange(of: \.showSheet) { oldVal, newVal in
            }
        
        Reduce { state, action in
            switch action {
            case .toggleShowState:
                state.showSheet = !state.showSheet
                return .none
            case let .changeWorkspaceTitle(newText):
                state.workspaceTitle = newText
                return .none
            case .createWorkspace:
                let newWorkspace = WorkspaceModel(id: (state.workspaces.count + 1), title: state.workspaceTitle, emoji: "🤩", user_id: 100, created_at: "2024-07-10T12:00:00Z")
                state.workspaces.append(newWorkspace)
                state.workspaceTitle = ""
                state.showSheet = false
                return .none
            case .binding(\.showSheet):
                return .none
            case .binding(\.workspaceTitle):
                return .none
            case .binding(_):
                return .none
            }
        }
    }
}
