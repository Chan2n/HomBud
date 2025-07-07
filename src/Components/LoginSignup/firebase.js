import { initializeApp } from "firebase/app";
import { getFirestore } from "firebase/firestore";
import { getAuth } from "firebase/auth"; // Import Firebase Auth

const firebaseConfig = {
  apiKey: "AIzaSyCCA3tYA-FxNhYqt1Tbx-70ge9sBW3g-G4",
  authDomain: "sysarch-f1381.firebaseapp.com",
  projectId: "sysarch-f1381",
  storageBucket: "sysarch-f1381.appspot.com",
  messagingSenderId: "1046876389278",
  appId: "1:1046876389278:web:048e5c31ce81fbb171608f"
};

const app = initializeApp(firebaseConfig);
const firestore = getFirestore(app);
const auth = getAuth(app); // Initialize Firebase Auth

export { firestore, auth }; // Export Firestore and Auth
