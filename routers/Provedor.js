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
router.get('/:codigo', async function(req, res){
    conexion.query('SELECT * FROM tblprovedor WHERE ProvId = ?',[req.params.codigo],(err,result) =>{
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
    console.log(req.body);
    conexion.query('CALL Agregar_Prov(?,?,?,?,?,?,?)',
    [ProvNit,ProvTelefono,ProvEmail,ProvNEmpresa,ProvTipProducto,ProvCiudad,ProvDireccion],(err,result) =>{
        try {
            res.json(result[0][0].message)
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});

router.put('/', async function(req, res){
    const {ProvId,ProvNit,ProvTelefono,ProvEmail,ProvNEmpresa,ProvTipProducto,ProvCiudad,ProvDireccion}=req.body;
    console.log(req.body);
    conexion.query('Call Actualizar_Prov(?,?,?,?,?,?,?,?)',
    [ProvId,ProvNit,ProvTelefono,ProvEmail,ProvNEmpresa,ProvTipProducto,ProvCiudad,ProvDireccion],(err,result) =>{
        try {
            res.json({
               message: 'Actualizado correctamente'
            })
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});

router.post('/eliminar', async function(req, res){
    console.log(req.body);
    const {Codigo}=req.body;
    
    conexion.query('CALL EliminarProv(?)',
    [Codigo],(err,result) =>{
        try {
            res.json(result)
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});

router.get('/param/:nombre', async function(req, res){
    conexion.query('SELECT * FROM tblprovedor WHERE ProvNEmpresa = ?',[req.params.nombre],(err,result) =>{
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