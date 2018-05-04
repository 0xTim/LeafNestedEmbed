import Routing
import Vapor
import Leaf

/// Register your application's routes here.
///
/// [Learn More →](https://docs.vapor.codes/3.0/getting-started/structure/#routesswift)
public func routes(_ router: Router) throws {
    // Basic "Hello, world!" example
    router.get("hello") { req in
        return "Hello, world!"
    }

    // Example of configuring a controller
    let todoController = TodoController()
    router.get("todos", use: todoController.index)
    router.post("todos", use: todoController.create)
    router.delete("todos", Todo.parameter, use: todoController.delete)

    router.get { req -> Future<View> in
      let user1 = User(name: "Alice")
      let user2 = User(name: "Bob")

      let users = [user1, user2]

      let context = PageContent(users: users)

      return try req.view().render("page1", context)
    }
}

struct User: Codable {
  let name: String
}

struct PageContent: Encodable {
  let users: [User]
}
