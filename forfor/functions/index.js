const functions = require("firebase-functions");
const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://forforw2m-default-rtdb.asia-southeast1.firebasedatabase.app"
});



exports.sendFCM = functions.region("asia-southeast1").https.onCall((data, context) => {
  // const payload = {
  //   data: {
  //     title: data["title"],
  //     body: data["body"]
  //   }
  // };
  // const result =  admin.messaging().sendToDevice(data["token"], payload);
  // return result;
  var count = parseInt(data["count"], 10);
  return ++count;
});