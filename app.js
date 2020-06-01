import express from 'express';
import morgan from 'morgan';
import cors from 'cors';
import path from 'path';

const app = express();

// Middleware
app.use(morgan('tiny'));
app.use(cors());
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(express.static(path.join(__dirname, 'public')));

// Routes
/* app.get('/', (req, res) => {
  res.send('Hello World!');
}); */

app.use('/api/proveedor',require('./routers/Provedor.js'))
app.use('/api/producto',require('./routers/Productos.js'))
app.use('/api/salida_entrada',require('./routers/Entrada_Salida.js'))
app.use('/api/buscar_mov',require('./routers/Buscar_Mov.js'))


// Middleware para Vue.js router modo history
const history = require('connect-history-api-fallback');
app.use(history());
app.use(express.static(path.join(__dirname, 'public')));

app.set('Port', process.env.PORT || 4000);
app.listen(app.get('Port'), () => {
  console.log('Listening on Port '+ app.get('Port'));
});

