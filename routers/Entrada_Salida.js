const express = require('express');
const router = express.Router();
const conexion = require('../modelo/dbconexion.js'); // importando el modelo

//consulta proveedores
router.get('/prov', async function(req, res){
    conexion.query('SELECT ProvId,ProvNEmpresa FROM tblprovedor ORDER BY ProvNEmpresa ASC',(err,result) =>{
        try {
            res.json(result);
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});
//consulta productos
router.get('/prod', async function(req, res){
    conexion.query('SELECT ProdId, ProdNombre FROM tblproducto ORDER BY ProdNombre ASC',(err,result) =>{
        try {
            res.json(result);
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});

router.get('/', async function(req, res){
    conexion.query('SELECT MovCantidad, MovTipo, MovFecha, MovTotal, ProvNEmpresa, ProdNombre, ProdDescripcion FROM tblmovimiento INNER JOIN tblproducto ON tblmovimiento.MovProducto = tblproducto.ProdId INNER JOIN tblprovedor ON tblmovimiento.MovProveedor = tblprovedor.ProvId',(err,result) =>{
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
    const {Estado,NProducto,NEmpresa,Descripcion,Cantidad,Total,Fecha}=req.body;
    console.log(req.body);
    conexion.query('CALL agregarEntrada(?,?,?,?,?,?,?)',
    [Estado,NProducto,NEmpresa,Descripcion,Cantidad,Total,Fecha],(err,result) =>{
        try {
            res.json(result)
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});


module.exports=router; // exportando las rutas 