const express = require('express');
const router = express.Router();
const conexion = require('../modelo/dbconexion.js'); // importando el modelo


router.get('/', async function(req, res){
    conexion.query('SELECT * FROM tblproducto',(err,result) =>{
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
    const {ProdNombre,ProdMarca,ProdCategoria,ProdPrecio,ProdIva}=req.body;
    console.log(req.body);
    conexion.query('CALL agregar_Prod(?,?,?,?,?)',
    [ProdNombre,ProdMarca,ProdCategoria,ProdPrecio,ProdIva],(err,result) =>{
        try {
            res.json(result)
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});

/* Productos agotados */
router.get('/agotado', async function(req, res){
    conexion.query('SELECT * FROM tblproducto WHERE ProdStock <=0',(err,result) =>{
        try {
            res.json(result);
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});

router.get('/param/:nombre', async function(req, res){
    conexion.query('SELECT * FROM tblproducto WHERE ProdNombre = ?',[req.params.nombre],(err,result) =>{
        try {
            res.json(result);
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});
module.exports=router; // exportando las rutas 