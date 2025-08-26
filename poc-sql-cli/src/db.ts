import sql from 'mssql';
import * as dotenv from 'dotenv'

dotenv.config();

const dbConfig: sql.config = {
    user: process.env.DB_USER,
    password: process.env.DB_PASS,
    database: process.env.DB_NAME,
    server: process.env.DB_SERVER || "localhost",
    options: {
        // encrypt: true,
        trustServerCertificate: true
    }
};

export async function getConnection(){
    return sql.connect(dbConfig);
}