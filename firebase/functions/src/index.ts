import * as functions from "firebase-functions";
import * as admin from "firebase-admin";
import express from "express";
import cors from "cors";

admin.initializeApp();

const app = express();
app.use(cors({ origin: true }));
app.use(express.json());

// Helper to validate request and extract data
async function validateRequest(req: express.Request, res: express.Response) {
    const { idToken, data } = req.body;

    if (!idToken) {
        res.status(401).send("Unauthorized: No token provided");
        return null;
    }

    try {
        const decodedToken = await admin.auth().verifyIdToken(idToken);

        let parsedData: any = {};
        if (data && data.insData) {
            try {
                parsedData = JSON.parse(data.insData);
            } catch (e) {
                console.warn("Could not parse insData, using raw data if available", e);
                parsedData = data;
            }
        } else if (data) {
            parsedData = data;
        }

        return { uid: decodedToken.uid, data: parsedData, decodedToken };
    } catch (error) {
        console.error("Error verifying token:", error);
        res.status(401).send("Unauthorized: Invalid token");
        return null;
    }
}

// --- Critical Endpoints ---

// Create User
app.post("/createUser", async (req: express.Request, res: express.Response) => {
    const context = await validateRequest(req, res);
    if (!context) return;

    try {
        await admin.firestore().collection("users").doc(context.uid).set(context.data, { merge: true });
        res.status(200).json({ message: "Profile created successfully" });
    } catch (error) {
        console.error("Error creating user:", error);
        res.status(500).send("Internal Server Error");
    }
});

// Search User
app.post("/searchUser", async (req: express.Request, res: express.Response) => {
    const context = await validateRequest(req, res);
    if (!context) return;

    try {
        const { email, phone } = context.data;
        let query: admin.firestore.Query = admin.firestore().collection("users");

        if (email) {
            query = query.where("email", "==", email);
        } else if (phone) {
            query = query.where("phone", "==", phone);
        } else {
            res.status(400).send("Bad Request: Email or Phone required for search");
            return;
        }

        const snapshot = await query.get();
        if (snapshot.empty) {
            res.status(404).json({ message: "User not found" });
            return;
        }

        const userData = snapshot.docs[0].data();
        res.status(200).json(userData);
    } catch (error) {
        console.error("Error searching user:", error);
        res.status(500).send("Internal Server Error");
    }
});

// Generate PIN and Ticket
app.post("/generatePINandticket", async (req: express.Request, res: express.Response) => {
    const context = await validateRequest(req, res);
    if (!context) return;

    try {
        const pin = Math.floor(100000 + Math.random() * 900000).toString(); // 6 digit PIN
        const ticketId = admin.firestore().collection("tickets").doc().id;

        const ticketData = {
            id: ticketId,
            userId: context.uid,
            pin: pin,
            status: "Arrival",
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            ...context.data
        };

        await admin.firestore().collection("tickets").doc(ticketId).set(ticketData);

        res.status(200).json({ pin: pin, ticketId: ticketId });
    } catch (error) {
        console.error("Error generating PIN and ticket:", error);
        res.status(500).send("Internal Server Error");
    }
});

// Generic Search
app.post("/search", async (req: express.Request, res: express.Response) => {
    const context = await validateRequest(req, res);
    if (!context) return;

    try {
        const { collection, field, value } = context.data;

        // Whitelist allowed collections for safety
        const allowedCollections = ["users", "tickets", "companies", "locations"];
        if (!allowedCollections.includes(collection)) {
            res.status(400).send("Bad Request: Invalid collection");
            return;
        }

        const snapshot = await admin.firestore().collection(collection).where(field, "==", value).get();
        const results = snapshot.docs.map(doc => ({ id: doc.id, ...doc.data() }));

        res.status(200).json(results);
    } catch (error) {
        console.error("Error in generic search:", error);
        res.status(500).send("Internal Server Error");
    }
});

// Create Ticket
app.post("/createTicket", async (req: express.Request, res: express.Response) => {
    const context = await validateRequest(req, res);
    if (!context) return;

    try {
        const ticketId = admin.firestore().collection("tickets").doc().id;
        const ticketData = {
            id: ticketId,
            userId: context.uid,
            status: "Parked",
            createdAt: admin.firestore.FieldValue.serverTimestamp(),
            ...context.data
        };

        await admin.firestore().collection("tickets").doc(ticketId).set(ticketData);
        res.status(200).json({ message: "Ticket created", ticketId: ticketId });
    } catch (error) {
        console.error("Error creating ticket:", error);
        res.status(500).send("Internal Server Error");
    }
});

// Get Latest Ticket
app.post("/getLatestTicket", async (req: express.Request, res: express.Response) => {
    const context = await validateRequest(req, res);
    if (!context) return;

    try {
        const snapshot = await admin.firestore().collection("tickets")
            .where("userId", "==", context.uid)
            .orderBy("createdAt", "desc")
            .limit(1)
            .get();

        if (snapshot.empty) {
            res.status(404).json({ message: "No tickets found" });
            return;
        }

        res.status(200).json(snapshot.docs[0].data());
    } catch (error) {
        console.error("Error getting latest ticket:", error);
        res.status(500).send("Internal Server Error");
    }
});

// Set Ticket to Cancel
app.post("/setTicketToCancel", async (req: express.Request, res: express.Response) => {
    const context = await validateRequest(req, res);
    if (!context) return;

    try {
        const { ticketId } = context.data;
        if (!ticketId) {
            res.status(400).send("Missing ticketId");
            return;
        }

        await admin.firestore().collection("tickets").doc(ticketId).update({ status: "Cancelled" });
        res.status(200).json({ message: "Ticket cancelled" });
    } catch (error) {
        console.error("Error cancelling ticket:", error);
        res.status(500).send("Internal Server Error");
    }
});

// Set to Departure
app.post("/setToDeparture", async (req: express.Request, res: express.Response) => {
    const context = await validateRequest(req, res);
    if (!context) return;

    try {
        const { ticketId } = context.data;
        if (!ticketId) {
            res.status(400).send("Missing ticketId");
            return;
        }

        await admin.firestore().collection("tickets").doc(ticketId).update({ status: "Departure" });
        res.status(200).json({ message: "Ticket set to departure" });
    } catch (error) {
        console.error("Error setting departure:", error);
        res.status(500).send("Internal Server Error");
    }
});

// Set Ticket Tip
app.post("/setTicketTip", async (req: express.Request, res: express.Response) => {
    const context = await validateRequest(req, res);
    if (!context) return;

    try {
        const { ticketId, tipAmount } = context.data;
        if (!ticketId) {
            res.status(400).send("Missing ticketId");
            return;
        }

        await admin.firestore().collection("tickets").doc(ticketId).update({ tip: tipAmount });
        res.status(200).json({ message: "Tip updated" });
    } catch (error) {
        console.error("Error setting tip:", error);
        res.status(500).send("Internal Server Error");
    }
});

// Confirm Payment
app.post("/confirmPayment", async (req: express.Request, res: express.Response) => {
    const context = await validateRequest(req, res);
    if (!context) return;

    try {
        // Mock payment confirmation
        console.log("Payment confirmed for user:", context.uid, "Data:", context.data);
        res.status(200).json({ message: "Payment confirmed" });
    } catch (error) {
        console.error("Error confirming payment:", error);
        res.status(500).send("Internal Server Error");
    }
});

// --- Placeholder Endpoints (from openapi_new.json) ---
const placeholderRoutes = [
    "/createProvisionalTicket",
    "/cancelTicket",
    "/getTicketList",
    "/getTicketByPIN",
    "/ticketToDeparture",
    "/ticketToDepartureCasual",
    "/setTip",
    "/createCasualUser",
    "/linkUserClientToProvisionalTicket",
    "/generateReport",
    "/update",
    "/insert",
    "/backfillCompanyId",
    "/createAttendant",
    "/createCompanyAndUpdateProfile",
    "/createLocation",
    "/createTicketForAttendant",
    "/createUserClient",
    "/generate-car-details",
    "/get-enum",
    "/getAttendants",
    "/getAttendantsForAdmin",
    "/getAttendantsForCompany",
    "/getBusinessProfile",
    "/getCompany",
    "/getCompanyDetailsForAdmin",
    "/getLocationsForCompany",
    "/getLocationsForCompanyForAdmin",
    "/getSumTipsForAdmin",
    "/getSumTipsForAdminPerAttendant",
    "/getTicketListForAdmin",
    "/getTipsForAdmin",
    "/getUser",
    "/getUserByEmail",
    "/getUserProfileByEmail",
    "/getUsersForCompany",
    "/linkUserClientToTicketByProvisionalPIN",
    "/migrateData",
    "/registerAttendant",
    "/setCarLocation",
    "/setKeysLocation",
    "/setTicketStatus",
    "/setTicketToProcessing",
    "/setToCancelForClient",
    "/setToDepartureCasual",
    "/ticketToParked",
    "/updateAttendant",
    "/updateCompany",
    "/updateLocation",
    "/updateUser"
];

placeholderRoutes.forEach(route => {
    app.all(route, (req: express.Request, res: express.Response) => {
        console.log(`Placeholder endpoint hit: ${route}`);
        res.status(200).json({ message: "Success (Placeholder)" });
    });
});

export const api = functions.https.onRequest(app);
