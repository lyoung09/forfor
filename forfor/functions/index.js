const functions = require("firebase-functions");
const admin = require("firebase-admin");

const serviceAccount = require("./serviceAccount.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://forforw2m-default-rtdb.asia-southeast1.firebasedatabase.app",
});
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions

exports.addCount= functions.https.onCall((data, context) => {
  console.log(data["count"]);

  const count = parseInt(data["count"]);
  return count;
});

exports.helloWorld = functions.https.onRequest((request, response) => {
  response.send("Hello from Firebase!");
});

exports.sendFCM = functions.https.onCall((data, context) => {
  const payload = {
    data: {
      title: data["title"],
      body: data["body"],
    },
    android: {
      priority: "high",
    },
    apns: {
      payload: {
        aps: {
          contentAvailable: true,
        },
      },
      headers: {
        "apns-push-type": "background",
        "apns-priority": "5",
        "apns-topic": "io.flutter.plugins.firebase.messaging",
      },
    },
  };
  const result = admin.messaging().sendToDevice(data["token"], payload);
  return result;
});

exports.sendChattingFCM = functions.https.onCall((data, context) => {
  const payload = {
    data: {
      title: data["title"],
      body: data["body"],
    },
    android: {
      priority: "high",
    },
    apns: {
      payload: {
        aps: {
          contentAvailable: true,
        },
      },
      headers: {
        "apns-push-type": "background",
        "apns-priority": "5",
        "apns-topic": "io.flutter.plugins.firebase.messaging",
      },
    },
  };
  const result = admin.messaging().sendToDevice(data["token"], payload);
  return result;
});
