const express = require('express');
const bcryptjs = require('bcryptjs');
const User = require('../models/user');
const authRouter = express.Router();
const jwt = require('jsonwebtoken');
const { verify } = require('jsonwebtoken');
const auth = require('../middlewares/auth');
// SIGNUP ROUTE
authRouter.post('/api/signup', async (req, res) => {
    try{
        const {name, email, password} = req.body;
    const existingUser = await User.findOne({email});
   if(existingUser){
       return res.status(400).json({
        msg: "User with same email already exists"
       })
   }
    // 8 is salt, 
    const hashPassword = await bcryptjs.hash(password, 8);

    let user = new User({
       email,
       password:hashPassword,
       name
   });

   user = await user.save();
   res.json(user);
    }catch(e){
       res.status(500).json({ error: e.message}) 
    }
});

// SIGNIN ROUTE
authRouter.post('/api/signin', async (req, res) => {
    try{
        const {email, password} = req.body;
        const user = await User.findOne({email});
        if(!user){
            return res.status(400).json({msg: "User with this email doesnot exist"});
        }
        const isMatch = await bcryptjs.compare(password, user.password);
        if(!isMatch){
            return res.status(400).json({msg: "Username or password is incorrect"});
        }
        //JWT
       const token = jwt.sign({id: user._id}, "passwordKey");
       res.json({
           token,
           ...user._doc
       })
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

// TOKEN VERIFY ROUTE
authRouter.post('/tokenIsValid', async (req, res) => {
    try{
       const token = req.header('x-auth-token');
       if(!token) return res.json(false);

       const isVerified  = jwt.verify(token, 'passwordKey');
       if(!isVerified) return res.json(false);

       const user = await User.findById(isVerified.id);
       if(!user) return res.json(false);

       res.json(true);

    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

// GET USER DATA
authRouter.get('/', auth, async (req, res) => {
    const user = await User.findById(req.user);
    res.json({...user._doc, token: req.token});
});

module.exports = authRouter;