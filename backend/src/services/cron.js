import { generateArticle } from './generateArticle.js';
import { insertArticle } from '../models/articles.js';

export async function articleJob() {
  console.log(`Cron job started`);

  try {
    const article = await generateArticle();
    
    if (!article) {
      console.error('Failed to generate article');
      return;
    }

    const { article: { title, content }, id, created_at } = article;
    
    insertArticle(id, created_at, title, content);
    console.log(`Article generated: ${id}`);
  } catch (error) {
    console.error(`Cron job error: ${error.message}`);
  }

  console.log(`Cron job finished`);
}