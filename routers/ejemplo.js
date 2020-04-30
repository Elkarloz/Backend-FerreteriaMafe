const express = require('express');
const router = express.Router();
const conexion = require('../modelo/dbconexion.js'); // importando el modelo


router.get('/', (req, res) => {
    conexion.query('SELECT * FROM producto', (err,result) =>{
        if(!err){
            res.send(result)
            console.log(result);
        }else{
            console.log(err);
        }
    }) 
});


module.exports=router; // exportando las rutas 