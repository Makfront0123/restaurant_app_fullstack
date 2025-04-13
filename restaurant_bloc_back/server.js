import express from 'express';
import dotenv from 'dotenv';
import cookieParser from 'cookie-parser';
import connectDB from './db/connect.js';
import fs from 'fs';
dotenv.config();

const app = express();

app.use(express.json());
app.use(express.urlencoded({ extended: true }));
app.use(cookieParser())

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