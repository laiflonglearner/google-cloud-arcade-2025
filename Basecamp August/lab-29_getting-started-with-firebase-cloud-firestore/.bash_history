gcloud config set project qwiklabs-gcp-03-e7df4161d764
mkdir firebase-project && cd $_
cat << EOF > firebase.json
{
  "firestore": {
    "rules": "firestore.rules",
    "indexes": "firestore.indexes.json"
  }
}
EOF

cat << EOF > firestore.rules
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /{document=**} {
      allow read, write: if true;
    }
  }
}
EOF

cat << EOF > firestore.indexes.json
{
  "indexes": [],
  "fieldOverrides": []
}
EOF

firebase deploy --only firestore:rules --project qwiklabs-gcp-03-e7df4161d764
npm init -y
npm i firebase
mkdir src
cd src
ls
cat << EOF > index.js 

import { initializeApp } from 'firebase/app'

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

console.log('Hello, Firestore!')
EOF

cat << EOF > index.html

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Getting Started with Firebase Cloud Firestore</title>
    <script src="https://cdn.tailwindcss.com"></script>
</head>
<body class="bg-gray-100 flex flex-col items-center justify-center min-h-screen p-4">
    <div class="bg-white p-8 rounded-lg shadow-md max-w-md w-full">
        <h1 class="text-3xl font-bold text-gray-800 mb-4 text-center">Getting started with Firebase Cloud Firestore</h1>
        <p class="text-gray-600 mb-6 text-center">
            I probably won't even put anything in here! So check out the JavaScript console using DevTools.
        </p>
        <p id="dbTitle" class="text-lg font-semibold text-blue-600 mb-2"></p>
        <p id="dbDescription" class="text-gray-700"></p>
    </div>

    <script src="main.js"></script>
</body>
</html>

EOF

cd ..
cat << EOF > webpack.config.js

const path = require('path');
const HtmlWebpackPlugin = require('html-webpack-plugin')

module.exports = {
  mode: 'development',
  devtool: 'eval-source-map',
  entry: path.resolve(__dirname, '/src/index.js'),
  output: {
    path: path.resolve(__dirname, 'dist'),
    filename: '[name].js',
    assetModuleFilename: '[name][ext]',
  },
  watch: false,
  plugins: [
    new HtmlWebpackPlugin({
      template: 'src/index.html',
      filename: 'index.html',
      inject: false
    })
  ],
}

EOF

npm install webpack webpack-cli --save-dev
npm install --save-dev html-webpack-plugin
nano package.json
npm run build
cat package.json
python3 -m http.server 8080 --directory dist
ls
cd src
cat << EOF > index.js

import { initializeApp } from 'firebase/app'
import { getFirestore, doc, setDoc } from 'firebase/firestore'

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

function writeFirestoreDemo() {
 const docData = {
   title: 'Firebase Fundamentals Demo',
   description: 'Getting started with Cloud Firestore',
 }
 setDoc(firestoreIntroDb, docData)
}
writeFirestoreDemo()

console.log('Hello, Firestore!')

EOF

npm run build
python3 -m http.server 8080 --directory dist
cd ..
python3 -m http.server 8080 --directory dist
cat src/index.js
python3 -m http.server 8080 --directory dist
cd src
cat << EOF > index.js

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

EOF

cat << EOF > index.js

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

EOF

ls
nano index.js
cat index.js
npm run build
python3 -m http.server 8080 --directory dist
cd ..
