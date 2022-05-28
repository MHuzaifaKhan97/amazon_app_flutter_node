// Import from packages
const express = require('express');
const mongoose = require('mongoose');

// Constants init
const PORT = 3000
const app = express();
const DB = "your database url";

// Import from file
const authRouter = require('./routes/auth');
const productRoute = require('./routes/product');
const adminRoute = require('./routes/admin');
const userRoute = require('./routes/user');


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
app.use(productRoute);
app.use(userRoute);

app.listen( PORT || 3000, () => {
    console.log(`Server is runnning at port ${PORT}`)
    // localhost => 127.0.0.1
});