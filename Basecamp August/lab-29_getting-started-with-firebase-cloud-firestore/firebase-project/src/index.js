import { initializeApp } from 'firebase/app'
import { getFirestore, doc, setDoc, getDoc } from 'firebase/firestore'
const titleControl = document.querySelector('#dbTitle') 
const descriptionControl = document.querySelector('#dbDescription') 

// Initialize html elements
titleControl.textContent = ''
descriptionControl.textContent = ''

// Add your web app's Firebase configuration
const firebaseConfig = {
  apiKey: "AIzaSyA1PFIoghekcbz-5K_-SOPZFEGrbAwMH_k",
  authDomain: "qwiklabs-gcp-03-e7df4161d764.firebaseapp.com",
  projectId: "qwiklabs-gcp-03-e7df4161d764",
  storageBucket: "qwiklabs-gcp-03-e7df4161d764.firebasestorage.app",
  messagingSenderId: "41105103827",
  appId: "1:41105103827:web:45ffe6949939115e1aed26",
  measurementId: ""
};

// Initialize Firebase
const firebaseApp = initializeApp(firebaseConfig);
const firestore = getFirestore()
const firestoreIntroDb = doc(firestore, 'firestoreDemo/lab-demo-0001')

// Write to Firestore Database
function writeFirestoreDemo() {
 const docData = {
   title: 'Firebase Fundamentals Demo',
   description: 'Getting started with Cloud Firestore',
 }
 setDoc(firestoreIntroDb, docData)
}

// Read from Firestore Database
async function readASingleDocument() {
  const mySnapshot = await getDoc(firestoreIntroDb)
  if (mySnapshot.exists()) {
    const docData = mySnapshot.data()
    const dbJSON = await JSON.stringify(docData)
    console.log(`Data: ${dbJSON}`)
    const dbOBJ = await JSON.parse(dbJSON)
    console.log(`Title: ${dbOBJ.title}`)
    titleControl.textContent = "Title: " + dbOBJ.title 
    descriptionControl.textContent = "Description: " + dbOBJ.description
  }
}

// writeFirestoreDemo()
readASingleDocument()
console.log('Hello, Firestore!')
