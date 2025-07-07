import './Dashboard.css';
import React, { useState, useContext, useEffect } from "react";
import { useNavigate } from "react-router-dom";
import { UserContext } from "../LoginSignup/UserContext"; // Adjust the path to your UserContext file

const Dashboard = () => {
  const navigate = useNavigate();
  const { user } = useContext(UserContext); // Access user details from context
  const [isMenuOpen, setMenuOpen] = useState(false);

  useEffect(() => {
    if (!user) {
      console.error("User is not logged in. Redirecting to login.");
      navigate("/"); // Redirect to login if user is not logged in
    }
  }, [user, navigate]);

  const handleLogout = () => {
    localStorage.removeItem("authToken");
    navigate("/");
  };

  const handleBookingNavigate = () => {
    if (user?.name && user?.uid) {
      console.log("Navigating to Booking with user:", user); // Debugging log
      navigate("/booking", { state: { uid: user.uid, name: user.name } });
    } else {
      console.error("User data is missing. Cannot navigate to Booking.");
      alert("User data is missing. Please log in again.");
      navigate("/");
    }
  };

  return (
    <div className="dashboard-container">
      {/* Hamburger Menu */}
      <div className={`hamburger-menu ${isMenuOpen ? 'open' : ''}`}>
        <button onClick={() => setMenuOpen(true)} className="hamburger-button">
          ☰
        </button>
        <div className={`menu-overlay ${isMenuOpen ? 'slide-in' : 'slide-out'}`}>
          <button onClick={() => setMenuOpen(false)} className="close-button">✖</button>
          <ul className="menu-items">
            <li onClick={() => { setMenuOpen(false); navigate("/profile"); }}>Profile</li>
            <li onClick={() => { setMenuOpen(false); navigate("/settings"); }}>Settings</li>
            <li onClick={() => { setMenuOpen(false); navigate("/bookings"); }}>Bookings</li>
            <li onClick={() => { setMenuOpen(false); handleLogout(); }}>Logout</li>
          </ul>
        </div>
      </div>

      {/* Header Section */}
      <div className="dashboard-header">
        <h1>Welcome, <span className="username">{user?.name || "User"}</span>!</h1>
        <p>Your trusted partner for home services.</p>
      </div>

      {/* Services Section */}
      <div className="services-section">
        <h2>Our Services</h2>
        <div className="service-card">
          <img 
            src="https://cdn-icons-png.flaticon.com/512/3021/3021837.png" 
            alt="Plumbing" 
            className="service-icon"
          />
          <h3>Plumbing</h3>
          <p>
            Reliable plumbing services to fix leaks, unclog drains, and handle installations. 
            Our experienced professionals are just a call away!
          </p>
          <button
            className="service-button"
            onClick={handleBookingNavigate}
          >
            Book Now
          </button>
        </div>
      </div>

      {/* Advertisements Section */}
      <div className="advertisements-section">
        <h2>Advertisements</h2>
        <div className="ads-grid">
          <div className="ad-card">
            <img 
              src="https://s3.envato.com/files/237460716/preview/Plumbing_Services_Promotional_Flyer_Design%20Template.png" 
              alt="Ad 1"
            />
            <h3>Discounted Plumbing Services</h3>
            <p>Get 20% off on your first plumbing service booking!</p>
          </div>
          <div className="ad-card">
            <img 
              src="https://d1csarkz8obe9u.cloudfront.net/posterpreviews/plumbing-services-ads-design-template-b707140e39c8469924aa544ab2c74a92_screen.jpg?ts=1597959354" 
              alt="Ad 2"
            />
            <h3>Leak Detection Experts</h3>
            <p>Call now for a free consultation on leak detection services.</p>
          </div>
          <div className="ad-card">
            <img 
              src="https://dcassetcdn.com/design_img/3374213/597701/597701_18615665_3374213_b4a6c0da_image.jpg" 
              alt="Ad 3"
            />
            <h3>24/7 Emergency Services</h3>
            <p>We’re available anytime, anywhere, for all your plumbing emergencies.</p>
          </div>
        </div>
      </div>
    </div>
  );
};

export default Dashboard;
