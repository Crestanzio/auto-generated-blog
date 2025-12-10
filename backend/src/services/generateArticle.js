export async function generateArticle() {
  const url = "https://router.huggingface.co/v1/chat/completions";
  
  const body = {
    model: "deepseek-ai/DeepSeek-V3.2:novita",
    messages: [{
        role: "user",
        content: "Give me a detailed article about technology for my blog, return the response in JSON format with title and content fields.",
      }],
  };

  const options = {
    headers: {
      Authorization: `Bearer ${process.env.HF_TOKEN}`,
      "Content-Type": "application/json",
    },
    method: "POST",
    body: JSON.stringify(body),
  };

  try {
    const response = await fetch(url, options);
    if (!response.ok) throw new Error(`HTTP error! status: ${response.status}`);

    const { id, created: created_at, choices } = await response.json();
    const content = choices[0].message.content.replace(/^```json\s*/, '').replace(/\s*```$/, '');
    const article = JSON.parse(content);

    return { article, id, created_at };
  } catch (error) {
    console.error("Error generate article:", error);
  }
}