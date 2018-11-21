# ZDSupportClient
Zendesk Support client app fetches the tickets in specific and displays them.

Design Pattern followed: VIPER (View, Interactor, Presenter, Entity and Router.) 
- Viper is a design pattern that implements ‘separation of concern’ paradigm. 
- It follows mudular approach

1. View: Class that has all the code to show the app interface to the user and get their response. Upon receiving the response View alerts the Presenter.
2. Presenter: Nucleus of a module. It gets user response from the View and work accordingly. Only class to communicate with all other components. Calls the router for wire-framing, Interactor to fetch data (network calls or local data calls), view to update the UI.
3. Interactor: Have business logics of an app. Primarily make API calls to fetch data from a source. Responsible for making data calls but not necessarily from itself.
4. Router: Does the wire-framing. Listen from the presenter about which screen to present and executes it.
5. Entity: Contains plain model classes used by interactor.

Network layer is split into following:
1. Build the Request: configures the necessary parameters of an HTTP 
2. Execute the Request request is dispatched using URLSession
3. Parse or Handle the Response: read the raw output and provide an initial representation of the data (or get the error received)
