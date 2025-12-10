import { run, all, get, queries } from "../config/database.js";

export function getAllArticles() {
  return all(queries.allArticles);
}

export function getArticleById(id) {
  return get(queries.articleById, id);
}

export function insertArticle(id, created_at, title, content) {
  run(queries.insertArticle, id, created_at, title, content);
  const result = get(queries.articleById, id);

  if (!result) throw new Error("Article failed to inserted");

  return result;
}