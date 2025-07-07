import React, { useContext, useState } from "react";
import { useNavigate } from "react-router-dom";
import "./LoginSignup.css";
import {
  getAuth,
  createUserWithEmailAndPassword,
  signInWithEmailAndPassword,
} from "firebase/auth";
import { doc, getDoc, setDoc } from "firebase/firestore";
import { firestore } from "./firebase"; // Adjust the path based on your project structure
import { UserContext } from "./UserContext"; // Access the UserContext for global user state

import user_icon from "./Assets/person.png";
import email_icon from "./Assets/email.png";
import password_icon from "./Assets/password.png";
import phone_icon from "./Assets/phone.png";

const LoginSignup = () => {
  const { setUser } = useContext(UserContext); // Access the context for setting user data
  const [action, setAction] = useState("Sign Up");
  const [formData, setFormData] = useState({
    name: "",
    email: "",
    password: "",
    role: "User", // Default role is "User"
    phone: "",
  });
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  const navigate = useNavigate(); // Initialize navigation

  const handleInputChange = (e) => {
    const { name, value } = e.target;
    setFormData({ ...formData, [name]: value });
  };

  const handleAction = async () => {
    const auth = getAuth();
    setError("");
    setSuccess("");
    setLoading(true);

    if (action === "Sign Up") {
      // Validation for Sign Up
      if (!formData.name || !formData.email || !formData.password || !formData.phone) {
        setError("Please fill in all required fields.");
        setLoading(false);
        return;
      }
      try {
        // Create user with Firebase Authentication
        const userCredential = await createUserWithEmailAndPassword(
          auth,
          formData.email,
          formData.password
        );

        // Save user data in Firestore
        await setDoc(doc(firestore, "Accounts", userCredential.user.uid), {
          name: formData.name,
          email: formData.email,
          phone: formData.phone,
          role: formData.role,
        });

        // Update user context
        setUser({
          uid: userCredential.user.uid,
          name: formData.name,
          email: formData.email,
          phone: formData.phone,
          role: formData.role,
        });

        setSuccess("Account created successfully. You can now log in.");
        setAction("Login");
        setFormData({
          name: "",
          email: "",
          password: "",
          role: "User",
          phone: "",
        });
      } catch (error) {
        setError(`Error during registration: ${error.message}`);
      }
    } else if (action === "Login") {
      // Validation for Login
      if (!formData.email || !formData.password) {
        setError("Please provide both email and password.");
        setLoading(false);
        return;
      }
      try {
        // Log in user with Firebase Authentication
        const userCredential = await signInWithEmailAndPassword(
          auth,
          formData.email,
          formData.password
        );

        // Fetch user data from Firestore
        const userDoc = await getDoc(doc(firestore, "Accounts", userCredential.user.uid));
        if (userDoc.exists()) {
          const userData = userDoc.data();

          // Update user context
          setUser({
            uid: userCredential.user.uid,
            name: userData.name,
            email: userData.email,
            phone: userData.phone,
            role: userData.role,
          });

          // Navigate based on user role
          if (userData.role === "Expert") {
            navigate("/expert-dashboard");
          } else {
            navigate("/dashboard");
          }
        } else {
          setError("No user data found.");
        }
      } catch (error) {
        setError(`Error during login: ${error.message}`);
      }
    }

    setLoading(false);
  };

  return (
    <div className="container">
      <div className="header">
        <div className="text">{action}</div>
        <div className="underline"></div>
      </div>
      <div className="inputs">
        {action === "Login" ? null : (
          <>
            <div className="input">
              <img src={user_icon} alt="user-icon" />
              <input
                type="text"
                name="name"
                placeholder="Name"
                value={formData.name}
                onChange={handleInputChange}
              />
            </div>
            <div className="input">
              <img src={phone_icon} alt="phone-icon" />
              <input
                type="text"
                name="phone"
                placeholder="Phone Number"
                value={formData.phone}
                onChange={handleInputChange}
              />
            </div>
            <div className="input">
              <label htmlFor="role">Role:</label>
              <select
                name="role"
                id="role"
                value={formData.role}
                onChange={handleInputChange}
              >
                <option value="User">User</option>
                <option value="Expert">Expert</option>
              </select>
            </div>
          </>
        )}
        <div className="input">
          <img src={email_icon} alt="email-icon" />
          <input
            type="email"
            name="email"
            placeholder="Email ID"
            value={formData.email}
            onChange={handleInputChange}
          />
        </div>
        <div className="input">
          <img src={password_icon} alt="password-icon" />
          <input
            type="password"
            name="password"
            placeholder="Password"
            value={formData.password}
            onChange={handleInputChange}
          />
        </div>
      </div>
      {error && <div className="error-message">{error}</div>}
      {success && <div className="success-message">{success}</div>}
      <div className="switch-buttons">
        <div
          className={action === "Sign Up" ? "switch gray" : "switch"}
          onClick={() => setAction("Sign Up")}
        >
          Switch to Sign Up
        </div>
        <div
          className={action === "Login" ? "switch gray" : "switch"}
          onClick={() => setAction("Login")}
        >
          Switch to Login
        </div>
      </div>
      <div className="submit" onClick={handleAction} disabled={loading}>
        {loading ? "Processing..." : action}
      </div>
    </div>
  );
};

export default LoginSignup;
