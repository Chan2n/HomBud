import React, { useState, useEffect, useContext } from "react";
import { UserContext } from "../LoginSignup/UserContext";
import { collection, query, where, getDocs, updateDoc, doc, getDoc } from "firebase/firestore";
import { firestore } from "../LoginSignup/firebase";
import "./ExpertDashboard.css";

const ExpertDashboard = () => {
  const { user } = useContext(UserContext);
  const [activeBookings, setActiveBookings] = useState([]);
  const [ongoingBookings, setOngoingBookings] = useState([]);
  const [finishedBookings, setFinishedBookings] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [showHistory, setShowHistory] = useState(false);
  const [notification, setNotification] = useState("");

  useEffect(() => {
    const fetchBookings = async () => {
      if (!user?.uid || user?.role !== "Expert") {
        setError("Unauthorized access.");
        setLoading(false);
        return;
      }

      try {
        const bookingsRef = collection(firestore, "Booking");

        // Fetch Active, Ongoing, and Finished bookings
        const activeQuery = query(bookingsRef, where("status", "==", "Active"));
        const ongoingQuery = query(
          bookingsRef,
          where("status", "==", "Ongoing"),
          where("expertId", "==", user.uid)
        );
        const finishedQuery = query(
          bookingsRef,
          where("status", "==", "Finished"),
          where("expertId", "==", user.uid)
        );

        const [activeSnapshot, ongoingSnapshot, finishedSnapshot] = await Promise.all([
          getDocs(activeQuery),
          getDocs(ongoingQuery),
          getDocs(finishedQuery),
        ]);

        setActiveBookings(activeSnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() })));
        setOngoingBookings(ongoingSnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() })));
        setFinishedBookings(finishedSnapshot.docs.map((doc) => ({ id: doc.id, ...doc.data() })));
        setError("");
      } catch (error) {
        console.error("Error fetching bookings:", error);
        setError("Failed to fetch bookings. Please try again.");
      } finally {
        setLoading(false);
      }
    };

    fetchBookings();
  }, [user?.uid, user?.role]);

  const handleTakeJob = async (bookingId) => {
    try {
      const bookingDocRef = doc(firestore, "Booking", bookingId);
      const bookingSnapshot = await getDoc(bookingDocRef);

      if (!bookingSnapshot.exists()) {
        setError("Booking not found.");
        return;
      }

      await updateDoc(bookingDocRef, {
        status: "Ongoing",
        expertId: user.uid,
        expertName: user.name,
        expertPhoneNumber: user.phone,
      });

      setActiveBookings((prev) => prev.filter((booking) => booking.id !== bookingId));
      setOngoingBookings((prev) => [
        ...prev,
        { id: bookingId, ...bookingSnapshot.data(), status: "Ongoing", expertId: user.uid, expertName: user.name, expertPhoneNumber: user.phone },
      ]);
    } catch (error) {
      console.error("Error taking job:", error);
      setError("Failed to take the job. Please try again.");
    }
  };

  const handleFinishJob = async (bookingId) => {
    try {
      const bookingDocRef = doc(firestore, "Booking", bookingId);

      await updateDoc(bookingDocRef, { status: "Finished" });

      setOngoingBookings((prev) => prev.filter((booking) => booking.id !== bookingId));
      setFinishedBookings((prev) => [
        ...prev,
        { ...ongoingBookings.find((b) => b.id === bookingId), status: "Finished" },
      ]);

      setNotification("Notification: Received Customer's payment and finished the job.");
      setTimeout(() => setNotification(""), 5000); // Clear notification after 5 seconds
    } catch (error) {
      console.error("Error finishing job:", error);
      setError("Failed to finish the job. Please try again.");
    }
  };

  return (
    <div className="expert-dashboard-container">
      <h1>Welcome, {user?.name || "Expert"}!</h1>
      {error && <div className="error-message">{error}</div>}
      {notification && <div className="notification">{notification}</div>}

      <section>
        <h2>Active Bookings</h2>
        {loading ? (
          <p>Loading...</p>
        ) : activeBookings.length > 0 ? (
          activeBookings.map((booking) => (
            <div key={booking.id} className="booking-card">
              <p><strong>Address:</strong> {booking.address}</p>
              <p><strong>Time:</strong> {booking.date} at {booking.time}</p>
              <button onClick={() => handleTakeJob(booking.id)}>Take Job</button>
            </div>
          ))
        ) : (
          <p>No active bookings available.</p>
        )}
      </section>

      <section>
        <h2>Ongoing Bookings</h2>
        {ongoingBookings.length > 0 ? (
          ongoingBookings.map((booking) => (
            <div
              key={booking.id}
              className="booking-card"
              onMouseEnter={(e) => e.currentTarget.classList.add("hover")}
              onMouseLeave={(e) => e.currentTarget.classList.remove("hover")}
            >
              <p><strong>Address:</strong> {booking.address}</p>
              <p><strong>Time:</strong> {booking.date} at {booking.time}</p>
              <p><strong>Customer:</strong> {booking.userName}</p>
              <p><strong>Phone:</strong> {booking.phone}</p>
              <button className="finish-job-button" onClick={() => handleFinishJob(booking.id)}>Job Finished</button>
            </div>
          ))
        ) : (
          <p>No ongoing bookings available.</p>
        )}
      </section>

      <button className="history-button" onClick={() => setShowHistory(!showHistory)}>
        {showHistory ? "Hide History" : "Show Finished Jobs"}
      </button>

      {showHistory && (
        <section>
          <h2>Finished Jobs</h2>
          {finishedBookings.length > 0 ? (
            finishedBookings.map((booking) => (
              <div key={booking.id} className="booking-card">
                <p><strong>Address:</strong> {booking.address}</p>
                <p><strong>Time:</strong> {booking.date} at {booking.time}</p>
                <p><strong>Customer:</strong> {booking.userName}</p>
              </div>
            ))
          ) : (
            <p>No finished jobs available.</p>
          )}
        </section>
      )}
    </div>
  );
};

export default ExpertDashboard;
