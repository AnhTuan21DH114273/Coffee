const express = require("express");
const router = express.Router();
const crypto = require("crypto");
const twilio = require("twilio");

module.exports = function (db) {
  // Initialize Twilio client
  const accountSid = process.env.TWILIO_ACCOUNT_SID;
  const authToken = process.env.TWILIO_AUTH_TOKEN;
  const serviceSid = process.env.TWILIO_SERVICE_SID;
  const client = twilio(accountSid, authToken);

  // Function to generate OTP
  function generateOtp() {
    return crypto.randomBytes(3).toString("hex"); // Example: generates a 6-character OTP
  }

  // Function to format phone number for Twilio
  function formatPhoneNumber(phoneNumber) {
    // Remove leading zeros and prepend country code
    return `+84${phoneNumber.replace(/^0+/, "")}`;
  }

  // Endpoint to send OTP using Twilio Verify
  router.post("/send-otp", async (req, res) => {
    const { phoneNumber } = req.body;

    try {
      const verification = await client.verify
        .services(serviceSid)
        .verifications.create({
          to: formatPhoneNumber(phoneNumber),
          channel: "sms",
        });

      console.log(
        `Verification sent to ${phoneNumber}. Status: ${verification.status}`
      );
      res.status(200).json({ message: "OTP sent successfully" });
    } catch (error) {
      console.error("Error sending OTP via Twilio: ", error.message);
      res.status(500).json({ error: "Failed to send OTP" });
    }
  });

  // Endpoint to verify OTP using Twilio Verify
  router.post("/verify-otp", async (req, res) => {
    const { phoneNumber, otp } = req.body;

    try {
      const verificationCheck = await client.verify
        .services(serviceSid)
        .verificationChecks.create({
          to: formatPhoneNumber(phoneNumber),
          code: otp,
        });

      if (verificationCheck.status === "approved") {
        console.log("OTP verified successfully:", verificationCheck.sid);
        res.status(200).json({ message: "OTP verified successfully" });
      } else {
        console.log("Invalid OTP");
        res.status(400).json({ error: "Invalid OTP" });
      }
    } catch (error) {
      console.error("Error verifying OTP via Twilio: ", error.message);
      res.status(500).json({ error: "Failed to verify OTP" });
    }
  });
  return router;
};
