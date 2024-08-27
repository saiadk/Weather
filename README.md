**Weather App**

XCode Version: 15.4  
SwiftUI, UIKit   
Deployment Target: iOS 17

  
Weather app is created with App template and SwiftUI type interface. 

**Screens:**  
ContentView is the temporary start up screen that checks for location service permissions and toggle between WeatherView or some info message view. 

**WeatherView:** 
Weather view is the homepage of the app that shows the current weather detials (i.e. current temperature, min and max temperatures with city name), hourly and daily weather forecast information.

This screen will first check if user has selected a location and load the data if location is already selected. If not, it will launch LocationSearchView where user can search for location and select one from the search results with similar names. 
  


  
  <img width="300" alt="Screenshot 2024-08-26 at 3 41 16 PM" src="https://github.com/user-attachments/assets/858157d1-6a7c-4d8a-a7cc-24c9912e7f59">

  <img width="300" alt="Screenshot 2024-08-26 at 3 41 27 PM" src="https://github.com/user-attachments/assets/d3e1ff90-1758-4131-8771-c55d6e1634ba">

  <img width="300" alt="Screenshot 2024-08-26 at 3 41 30 PM" src="https://github.com/user-attachments/assets/88d43c2c-2ef1-444e-92f7-6d8715be47a2">

  <img width="283" alt="Screenshot 2024-08-26 at 4 23 34 PM" src="https://github.com/user-attachments/assets/492e8d74-295a-41db-bbf9-568e651b4601">




**LocationSearchView:**

This screen will allow the user to search for location and choose from the results list.

<img width="300" alt="Screenshot 2024-08-26 at 4 29 58 PM" src="https://github.com/user-attachments/assets/a336305f-6787-46b7-b26f-95e432087f15">
<br/>
<img width="300" alt="Screenshot 2024-08-26 at 4 23 40 PM" src="https://github.com/user-attachments/assets/4f80572e-9cae-4ada-b2b3-3154ef19d4cb">




