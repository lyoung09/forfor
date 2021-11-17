const functions = require("firebase-functions");
const admin = require("firebase-admin");
const serviceAccount = require("/Users/ijeyeong/Desktop/togethertalk/forfor/forfor/functions/serviceAccountKey.json");

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
  databaseURL: "https://forforw2m-default-rtdb.asia-southeast1.firebasedatabase.app"
});



exports.sendFCM = functions.https.onCall((data, context) => {
  
  

  // const payload = {
  //   data: {
  //     title: data.title,
  //     body: data.body
  //   }
  // };

  // const result =  admin.messaging().sendToDevice(data["token"], payload);
  // return result;
});