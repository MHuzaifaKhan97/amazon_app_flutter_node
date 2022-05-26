const express = require('express');
const productRoute = express.Router();
const Product = require('../models/product');
const auth = require('../middlewares/auth')

// GET PRODUCTS
// api/products?category=Essentials
productRoute.get("/api/products", auth, async (req, res) => {
    try{
        // console.log(req.query.category);
        const products = await Product.find({category: req.query.category});
        res.json(products);
        // print(products);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

// GET SEARCH PRODUCTS 
productRoute.get("/api/products/search/:name", auth, async (req, res) => {
    try{
        // console.log(req.params.name);
        const products = await Product.find({
            name: {$regex: req.params.name, $options: "i" }
        });
        res.json(products);
        // print(products);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

module.exports = productRoute;