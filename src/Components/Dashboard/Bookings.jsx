import React, { useState, useEffect, useContext } from "react";
import { UserContext } from "../LoginSignup/UserContext";
import { collection, query, where, getDocs } from "firebase/firestore";
import { useNavigate } from "react-router-dom";
import { firestore } from "../LoginSignup/firebase";
import "./Bookings.css";

const Bookings = () => {
  const navigate = useNavigate(); // Navigation hook
  const { user } = useContext(UserContext); // Access user details from context
  const [activeBookings, setActiveBookings] = useState([]);
  const [ongoingBookings, setOngoingBookings] = useState([]);
  const [finishedBookings, setFinishedBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");

  useEffect(() => {
    const fetchBookings = async () => {
      if (!user?.uid) {
        setError("User not logged in or missing details.");
        setLoading(false);
        return;
      }

      try {
        setLoading(true);
        const bookingsRef = collection(firestore, "Booking");
        const bookingsQuery = query(bookingsRef, where("userId", "==", user.uid));
        const querySnapshot = await getDocs(bookingsQuery);

        const active = [];
        const ongoing = [];
        const finished = [];

        querySnapshot.forEach((doc) => {
          const data = { id: doc.id, ...doc.data() };
          if (data.status === "Active") active.push(data);
          if (data.status === "Ongoing") ongoing.push(data);
          if (data.status === "Finished") finished.push(data);
        });

        setActiveBookings(active);
        setOngoingBookings(ongoing);
        setFinishedBookings(finished);
        setError("");
      } catch (error) {
        console.error("Error fetching bookings:", error);
        setError("Failed to fetch bookings. Please try again.");
      } finally {
        setLoading(false);
      }
    };

    fetchBookings();
  }, [user?.uid]);

  const BookingCard = ({ booking }) => {
    const [isExpanded, setIsExpanded] = useState(false);

    return (
      <div className="booking-card">
        <div className="card-header" onClick={() => setIsExpanded(!isExpanded)}>
          <h3 className="booking-title">
            {booking.date || "No Date"} - {booking.time || "No Time"}
          </h3>
          <span className={`status-badge ${booking.status?.toLowerCase() || "unknown"}`}>
            {booking.status || "Unknown"}
          </span>
          <button className="expand-button">
            {isExpanded ? "Hide Details" : "View Details"}
          </button>
        </div>
        {isExpanded && (
          <div className="card-details">
            <p><strong>Address:</strong> {booking.address || "No Address Provided"}</p>
            <p><strong>Phone:</strong> {booking.phone || "No Phone Provided"}</p>
            <p><strong>Comments:</strong> {booking.comments || "No Comments"}</p>
            <p><strong>Timestamp:</strong> {booking.timestamp ? new Date(booking.timestamp).toLocaleString() : "No Timestamp"}</p>
            {booking.expertName && <p><strong>Expert Name:</strong> {booking.expertName}</p>}
            {booking.expertPhoneNumber && <p><strong>Expert Phone:</strong> {booking.expertPhoneNumber}</p>}
          </div>
        )}
      </div>
    );
  };

  return (
    <div className="bookings-container">
      {/* Back to Dashboard Button */}
      <button className="back-button" onClick={() => navigate("/dashboard")}>
        ← Back to Dashboard
      </button>

      <h1>My Bookings</h1>
      {error && <div className="error-message">{error}</div>}
      {loading ? (
        <div className="loading-spinner">Loading bookings...</div>
      ) : (
        <div>
          <section>
            <h2>Active Bookings</h2>
            {activeBookings.length > 0 ? (
              activeBookings.map((booking) => (
                <BookingCard key={booking.id} booking={booking} />
              ))
            ) : (
              <p className="no-bookings">No active bookings.</p>
            )}
          </section>

          <section>
            <h2>Ongoing Bookings</h2>
            {ongoingBookings.length > 0 ? (
              ongoingBookings.map((booking) => (
                <BookingCard key={booking.id} booking={booking} />
              ))
            ) : (
              <p className="no-bookings">No ongoing bookings.</p>
            )}
          </section>

          <section>
            <h2>Finished Bookings</h2>
            {finishedBookings.length > 0 ? (
              finishedBookings.map((booking) => (
                <BookingCard key={booking.id} booking={booking} />
              ))
            ) : (
              <p className="no-bookings">No finished bookings.</p>
            )}
          </section>
        </div>
      )}
    </div>
  );
};

export default Bookings;
