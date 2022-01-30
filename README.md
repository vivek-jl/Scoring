# Scoring

Sample App to demonstrate iOS architecture using Combine.

### Architecture 

Application is built upon Clean Architecture concepts. There are 3 layers that perform different aspects of the code.


- Domain Layer: Contains Entities + Use Cases + Repositories Interfaces 
- Data Layer: Contains Repositories Implementations + DTO. Talks to network module to retrieve DTO and converts to domain objects.
- Presentation Layer (MVVM): ViewModels + Views


### Dependency Injection

Dependency Injection is achieved using a library called Resolver. Different containers are set for test and app environments. 


### Networking 

Networking layer is a wrapper around URLSession. URLProtocol is used to mock the network calls in unit tests.

### UI

UIKit is used instead of SwiftUI for Views. MVVM-Coordinator pattern (using Combine) is used as presentation architecture.