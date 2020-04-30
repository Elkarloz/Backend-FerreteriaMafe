const mysql = require('mysql');

const mysqlConnection = mysql.createConnection({
    host:'localhost',
    user: 'root',
    password:'',
    database:'fereteria_mafe'   
});

mysqlConnection.connect(function (err){
    if (err) {
        console.log(err);
    }else{
        console.log('Db conected');
    }
})

module.exports = mysqlConnection;
            
