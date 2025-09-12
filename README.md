# Noviindus Machine Test – Appointment Management App

A Flutter application that demonstrates **appointment booking and management** with authentication, splash screen navigation, state management using Provider, and PDF receipt generation.  

---

## Features
- **Authentication**
  - Login & session handling with `AuthService`
- **Splash Screen**
  - Shows logo and background, waits 2 seconds before navigation
- **Appointments**
  - View all appointments
  - Create new appointment
  - Fetch appointments from API (via `AppointmentViewModel`)
- **State Management**
  - Uses `provider` for reactive updates
- **PDF Receipt**
  - Auto-generate a receipt when creating an appointment (template-based)



## Architecture: MVVM Flow
1. **Model (Repository Layer)**  
   - `AuthService` → handles authentication, token persistence via `SharedPreferences`.  
   - Future: API integration for appointments.  

2. **ViewModel (Business Logic Layer)**  
   - `Viewmodels` → fetches, manages, and exposes appointment data to the UI.  
   - Notifies views via `ChangeNotifier`.  

3. **View (UI Layer)**  
   - Widgets like `AppointmentList`, `CreateAppointmentScreen` consume `ViewModel` using `Provider`.  
   - Only responsible for rendering and user interactions.  
