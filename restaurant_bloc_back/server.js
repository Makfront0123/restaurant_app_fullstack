import express from 'express';
import dotenv from 'dotenv';
import cookieParser from 'cookie-parser';
import connectDB from './db/connect.js';
import fs from 'fs';
import cors from 'cors';
import path from 'path';
import { fileURLToPath } from 'url';


dotenv.config();

const app = express();

app.use(cors(
    {
        origin: 'http://10.0.2.2:3000',
        credentials: true
    },
));

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

app.use(express.static(path.join(__dirname, 'public')));
app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser())
app.use('/uploads', express.static(path.join(__dirname, 'uploads')));


const routeFiles = fs.readdirSync('./routes');

routeFiles.forEach((file) => {
  import(`./routes/${file}`).then((route) => {
       
      app.use("/api/v1/", route.default);
  }).catch((error) => {
    console.log(error);
  });
});


const server = async () => {
    try {
        await connectDB();
        const port = process.env.PORT || 8000;
        app.listen(port, () => {
            console.log(`Server is running on port ${process.env.PORT}`);
        });
    } catch (error) {
        console.log(error);
        process.exit(1);
    }
};

server();