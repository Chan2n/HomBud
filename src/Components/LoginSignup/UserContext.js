import React, { createContext, useState, useEffect } from "react";
import { getAuth, onAuthStateChanged } from "firebase/auth";
import { doc, getDoc } from "firebase/firestore";
import { firestore } from "./firebase"; // Adjust the path to your firebase config

export const UserContext = createContext();

export const UserProvider = ({ children }) => {
  const [user, setUser] = useState(null); // Initial user state
  const [loading, setLoading] = useState(true); // Initial loading state

  useEffect(() => {
    const auth = getAuth();

    // Firebase authentication listener
    const unsubscribe = onAuthStateChanged(auth, async (currentUser) => {
      if (currentUser) {
        try {
          // Fetch user details from Firestore
          const userDocRef = doc(firestore, "Accounts", currentUser.uid);
          const userDoc = await getDoc(userDocRef);

          if (userDoc.exists()) {
            const userData = { uid: currentUser.uid, ...userDoc.data() };
            setUser(userData); // Update user state with Firestore data
            localStorage.setItem("user", JSON.stringify(userData)); // Cache user in local storage
          } else {
            console.error("User data not found in Firestore.");
            handleLogout(); // If user data not found, logout
          }
        } catch (error) {
          console.error("Error fetching user details:", error);
          handleLogout();
        }
      } else {
        handleLogout(); // If no authenticated user, clear state
      }
      setLoading(false); // Mark loading as complete
    });

    return () => unsubscribe(); // Clean up listener
  }, []);

  // Function to handle logout and clear local storage
  const handleLogout = () => {
    setUser(null);
    localStorage.removeItem("user");
  };

  return (
    <UserContext.Provider value={{ user, setUser, loading, handleLogout }}>
      {children}
    </UserContext.Provider>
  );
};
