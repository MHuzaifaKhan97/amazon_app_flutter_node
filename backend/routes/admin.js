const express = require('express');
const admin = require('../middlewares/admin');
const Order = require('../models/order');
const {Product} = require('../models/product');
const adminRoute = express.Router();

// ADD PRODUCT
adminRoute.post("/admin/add-product", admin, async (req, res) => {

    try{
        const {name, description, images, quantity, price, category} =  req.body;
        let product = new Product({
            name, 
            description,
            images,
            quantity,
            price,
            category,
        });
        product = await product.save();
        res.json(product);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

// GET PRODUCTS
adminRoute.get("/admin/get-products", admin, async (req, res) => {
    try{
        const products = await Product.find({});
        res.json(products);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

// DELETE PRODUCT
adminRoute.post("/admin/delete-product", admin, async (req, res) => {
    try{
        const {id} = req.body;
        const product = await Product.findByIdAndDelete(id);
        res.json(product);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

// GET ORDERS
adminRoute.get("/admin/get-orders", admin, async (req, res) => {
    try{
        const orders = await Order.find({});
        res.json(orders);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

// CHANGE ORDER STATUS
adminRoute.post("/admin/change-order-status", admin, async (req, res) => {
    try{
        const {id,status} = req.body;
        let order = await Order.findById(id);
        order.status = status;
        order = await order.save();
        res.json(order);
    }
    catch(e){
        res.status(500).json({error: e.message});
    }
});

module.exports = adminRoute;