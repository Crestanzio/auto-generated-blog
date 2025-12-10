import 'dotenv/config';
import cors from 'cors';
import cron from 'node-cron';
import express from 'express';
import router from './routes/articles.js';
import { queries, run } from './config/database.js';
import { articleJob } from './services/cron.js';

const host = process.env.HOST
const port = process.env.PORT;

const article_job = process.env.ARTICLE_JOB;
const jobs = { article: article_job }

const app = express();

// middlewares
app.use(cors());
app.use(express.json());

// initialize database
run(queries.init);

// cron jobs
cron.schedule(jobs.article, articleJob);

// routes
app.use('/', router);

// start server
app.listen(port, host, (error) => console.log(error ? error : `Server listening on http://${host}:${port}`));