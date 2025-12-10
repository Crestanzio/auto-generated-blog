import { getAllArticles, getArticleById } from '../models/articles.js';

export function listArticles(req, res) {
  try {
    const articles = getAllArticles();
    return res.json(articles);
  } catch (error) {
    return res.status(500).json({ message: `Error retrieving articles: ${error.message}` });
  }
}

export function getArticle(req, res) {
  const { id } = req.params;

  try {
    const article = getArticleById(id);
    if (!article) return res.status(404).json({ message: "Article not found" });
    return res.json(article);
  } catch (error) {
    return res.status(500).json({ message: `Error retrieving article: ${error.message}` });
  }
}