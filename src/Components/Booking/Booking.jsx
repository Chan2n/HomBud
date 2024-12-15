import "./Booking.css";
import React, { useState, useContext } from "react";
import { useNavigate } from "react-router-dom";
import { collection, addDoc } from "firebase/firestore";
import { firestore } from "../LoginSignup/firebase";
import { UserContext } from "../LoginSignup/UserContext"; // Import UserContext for accessing user details

const Booking = () => {
  const navigate = useNavigate();
  const { user } = useContext(UserContext); // Access user details from context

  const [bookingData, setBookingData] = useState({
    date: "",
    time: "",
    address: "",
    phone: "",
    comments: "",
  });
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  // Handle input changes for the form
  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setBookingData({ ...bookingData, [name]: value });
  };

  // Handle booking submission
  const handleBooking = async () => {
    setError("");
    setSuccess("");

    // Validation for required fields
    if (!bookingData.date || !bookingData.time || !bookingData.address || !bookingData.phone) {
      setError("Please fill in all the required fields (date, time, address, and phone).");
      return;
    }

    try {
      const bookingCollectionRef = collection(firestore, "Booking");

      // Save booking to Firestore
      await addDoc(bookingCollectionRef, {
        userName: user?.name || "Unknown User", // Use `user.name` from context
        userId: user?.uid, // Add userId for tracking in Firestore
        date: bookingData.date,
        time: bookingData.time,
        address: bookingData.address,
        phone: bookingData.phone,
        comments: bookingData.comments || "No additional comments",
        status: "Active", // Initial status
        timestamp: new Date().toISOString(), // Timestamp for record-keeping
      });

      // Success handling
      setSuccess("Booking confirmed! We'll see you on your chosen date and time.");
      setTimeout(() => navigate("/dashboard"), 2000);
    } catch (error) {
      console.error("Error saving booking:", error);
      setError("An error occurred while saving your booking. Please try again.");
    }
  };

  return (
    <div className="booking-container">
      {/* Header Section */}
      <button className="back-button" onClick={() => navigate("/dashboard")}>
        ← Back to Dashboard
      </button>
      <h1>Book Our Plumbing Service</h1>
      <p>Please fill in the details below to confirm your booking.</p>

      {/* Booking Form */}
      <div className="form">
        {/* Date Input */}
        <div className="form-group">
          <label htmlFor="date">Select Date:</label>
          <input
            type="date"
            id="date"
            name="date"
            value={bookingData.date}
            onChange={handleInputChange}
          />
        </div>

        {/* Time Picker */}
        <div className="form-group">
          <label htmlFor="time">Select Time:</label>
          <select
            id="time"
            name="time"
            value={bookingData.time}
            onChange={handleInputChange}
            disabled={!bookingData.date} // Disable until date is selected
          >
            <option value="">-- Select Time --</option>
            {[...Array(24).keys()].flatMap((hour) =>
              [0, 30].map((minute) => {
                const formattedTime = `${String(hour).padStart(2, "0")}:${String(minute).padStart(
                  2,
                  "0"
                )}`;
                return (
                  <option key={formattedTime} value={formattedTime}>
                    {formattedTime}
                  </option>
                );
              })
            )}
          </select>
        </div>

        {/* Address Input */}
        <div className="form-group">
          <label htmlFor="address">Enter Address:</label>
          <textarea
            id="address"
            name="address"
            placeholder="Enter your address"
            value={bookingData.address}
            onChange={handleInputChange}
          />
        </div>

        {/* Phone Input */}
        <div className="form-group">
          <label htmlFor="phone">Phone:</label>
          <input
            type="tel"
            id="phone"
            name="phone"
            placeholder="Enter your phone number"
            value={bookingData.phone}
            onChange={handleInputChange}
          />
        </div>

        {/* Comments Input */}
        <div className="form-group">
          <label htmlFor="comments">Additional Comments (Optional):</label>
          <textarea
            id="comments"
            name="comments"
            placeholder="Any special requests or instructions..."
            value={bookingData.comments}
            onChange={handleInputChange}
          />
        </div>

        {/* Error and Success Messages */}
        {error && <div className="error-message">{error}</div>}
        {success && <div className="success-message">{success}</div>}

        {/* Submit Button */}
        <button className="booking-button" onClick={handleBooking}>
          Confirm Booking
        </button>
      </div>
    </div>
  );
};

export default Booking;
