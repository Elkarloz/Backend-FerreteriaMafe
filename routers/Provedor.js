const express = require('express');
const router = express.Router();
const conexion = require('../modelo/dbconexion.js'); // importando el modelo


router.get('/', async function(req, res){
    conexion.query('SELECT * FROM tblprovedor',(err,result) =>{
        try {
            res.json(result);
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});
router.post('/', async function(req, res){
    const {ProvNit,ProvTelefono,ProvEmail,ProvNEmpresa,ProvTipProducto,ProvCiudad,ProvDireccion}=req.body;
    conexion.query('INSERT INTO tblprovedor VALUES(null,?,?,?,?,?,?,?)',
    [ProvNit,ProvTelefono,ProvEmail,ProvNEmpresa,ProvTipProducto,ProvCiudad,ProvDireccion],(err,result) =>{
        try {
            res.json({
               message: 'Agregado correctamente'
            })
            console.log(req.body);
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});


module.exports=router; // exportando las rutas 