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
  const title = data["title"];
  const body = data["body"];
  const token =data["token"];

  const payload = {
    notification: {
      "title": title,
      "body": body,
      "sound": "default",
    },
  };

  const result = admin.messaging().sendToDevice(token, payload);
  return result;
});

exports.sendChattingFCM = functions.https.onCall((data, context) => {
  const payload = {
    notification: {
      title: data["title"],
      body: data["body"],
      myId: data["myId"],
      otherId: data["otherId"],
      chattingId: data["chattingId"],
      room: "chatting",
    },
  };
  const result = admin.messaging().sendToDevice(data["token"], payload);
  return result;
});
