importScripts('https://www.gstatic.com/firebasejs/9.0.2/firebase-app.js');
importScripts('https://www.gstatic.com/firebasejs/9.0.2/firebase-messaging.js');


const firebaseConfig = {
    apiKey: "AIzaSyCDQ4KZE0tvMCzWVp02PN4NsbE5MVVGA_M",
    authDomain: "postfix-ce6e0.firebaseapp.com",
    databaseURL: "https://postfix-ce6e0-default-rtdb.firebaseio.com",
    projectId: "postfix-ce6e0",
    storageBucket: "postfix-ce6e0.appspot.com",
    messagingSenderId: "148035665678",
    appId: "1:148035665678:web:726a4721052cb8161c615f",
    measurementId: "G-9S053Q5662"
  };
  // Initialize Firebase
  firebase.initializeApp(firebaseConfig);
  
  const messaging = firebase.messaging();

messaging.setBackgroundMessageHandler(function(payload) {
  console.log('Received background message ', payload);
  const notificationTitle = 'Background Message Title';
  const notificationOptions = {
    body: 'Background Message body.',
    icon: '/firebase-logo.png'
  };

  return self.registration.showNotification(notificationTitle, notificationOptions);
});
  

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);

