import { BrowserRouter as Router, Routes, Route, Navigate } from "react-router-dom";
import LoginSignup from "./Components/LoginSignup/LoginSignup";
import Dashboard from "./Components/Dashboard/Dashboard";
import Booking from "./Components/Booking/Booking";
import Bookings from "./Components/Dashboard/Bookings";
import ExpertDashboard from "./Components/Dashboard/ExpertDashboard"; // Import the ExpertDashboard
import { UserProvider } from "./Components/LoginSignup/UserContext";

const App = () => {
  return (
    <UserProvider>
      <Router>
        <Routes>
          {/* Public Routes */}
          <Route path="/" element={<LoginSignup />} />

          {/* Protected Routes */}
          <Route path="/dashboard" element={<Dashboard />} />
          <Route path="/booking" element={<Booking />} />
          <Route path="/bookings" element={<Bookings />} />
          <Route path="/expert-dashboard" element={<ExpertDashboard />} /> {/* Add this */}

          {/* Catch-all for unknown routes */}
          <Route path="*" element={<Navigate to="/" />} />
        </Routes>
      </Router>
    </UserProvider>
  );
};

export default App;
