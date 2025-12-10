import express from "express";
import { listArticles, getArticle } from "../controllers/articles.js";

const router = express.Router();

router.get("/",                   listArticles);
router.get("/articles/:id",       getArticle  );

export default router;