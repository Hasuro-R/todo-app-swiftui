import Foundation
import ComposableArchitecture
import Models
import WorkspaceAPIClient

@Reducer
public struct HomeReducer {
    @ObservableState
    public struct State: Equatable {
        var showSheet = false
        var workspaces: [WorkspaceModel] = []
        var workspaceTitle = ""
        var isLoading = false
        var error = ""
    }
    public enum Action: BindableAction {
        case firstFetch
        case firstFetchResponse(Result<[WorkspaceModel], Error>)
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
            case .firstFetch:
                state.isLoading = true
                return .run { send in
                    do {
                        let workspaceData = try await fetchWorkspacesAPIClient.fetchData(responseType: WorkspaceListResponse.self)
                        await send(.firstFetchResponse(.success(workspaceData.workspaces)))
                    } catch {
                        await send(.firstFetchResponse(.failure(error)))
                    }
                }
            case let .firstFetchResponse(.success(workspaces)):
                state.workspaces = workspaces
                state.isLoading = false
                return .none
            case let .firstFetchResponse(.failure(error)):
                state.error = "\(error)"
                state.isLoading = false
                return .none
            case .toggleShowState:
                state.showSheet = !state.showSheet
                return .none
            case let .changeWorkspaceTitle(newText):
                state.workspaceTitle = newText
                return .none
            case .createWorkspace:
                let newWorkspace = WorkspaceModel(id: (state.workspaces.count + 1), title: state.workspaceTitle, emoji: "🤩", userId: 100, createdAt: "2024-07-10T12:00:00Z")
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
