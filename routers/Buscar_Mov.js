const express = require('express');
const router = express.Router();
const conexion = require('../modelo/dbconexion.js'); // importando el modelo

//consulta x fecha
router.get('/entrada/:fecha/:estado', async function(req, res){
    conexion.query('SELECT MovFecha,MovTotal,MovCantidad,ProdNombre,ProdDescripcion,ProdMarca FROM tblmovimiento INNER JOIN tblproducto ON tblmovimiento.MovProducto = tblproducto.ProdId WHERE MovFecha = ? AND MovTipo = ?',
    [req.params.fecha,req.params.estado],(err,result) =>{
        try {
            res.json(result);
        } catch (error) {
            res.status(500).json({
                message: 'Ocurrio un error'
            })
        }
    }) 
});

router.get('/r/:fecha1/:fecha2/:estado', async function(req, res){
    conexion.query("SELECT MovFecha,MovTotal,MovCantidad,ProdNombre,ProdDescripcion,ProdMarca FROM tblmovimiento INNER JOIN tblproducto ON tblmovimiento.MovProducto = tblproducto.ProdId WHERE MovTipo = ? AND MovFecha BETWEEN '"+req.params.fecha1+"' AND '"+req.params.fecha2+"';",[req.params.estado],(err,result) =>{
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