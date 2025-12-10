const baseUrl = import.meta.env.VITE_API_URL;

export async function getArticles() {
  const response = await fetch(`${baseUrl}/`);
  if (!response.ok) throw new Error(`Failed to fetch articles: ${response.status}`);
  
  return response.json();
}

export async function getArticleById(id) {
  const response = await fetch(`${baseUrl}/articles/${id}`);
  if (!response.ok) throw new Error(`Failed to fetch article ${id}: ${response.status}`);

  return response.json();
}