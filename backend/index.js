// Import from packages
const express = require('express');
const mongoose = require('mongoose');
const adminRoute = require('./routes/admin');

// Constants init
const PORT = 3000
const app = express();
const DB = "mongodb+srv://huzaifa:huzaifa1997@cluster0.nf0ic9r.mongodb.net/?retryWrites=true&w=majority";

// Import from file
const authRouter = require('./routes/auth');

// Connections
mongoose.connect(DB).then(() => {
    console.log("Connected with Database")
}).catch((e) => {
    console.log(`Error: ${e}`);
})

// Middlewares
// Client -> middleware -> Server
app.use(express.json());
app.use(authRouter);
app.use(adminRoute);

app.listen( PORT || 3000, () => {
    console.log(`Server is runnning at port ${PORT}`)
    // localhost => 127.0.0.1
});