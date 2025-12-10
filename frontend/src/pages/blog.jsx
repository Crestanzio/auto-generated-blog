import React from "react";
import styled from "@emotion/styled";
import Article from "../components/article.jsx";
import { useQuery } from "@tanstack/react-query";
import { getArticles } from "../api/articles.js";

const BlogContainer = styled.div({
  display: "flex",
  flexDirection: "column",
  alignItems: "center",
});

const Title = styled.h1({
  textAlign: "center",
  fontSize: "clamp(1.8rem, 4vw, 3rem)",
  color: "#222",
  margin: "2rem auto",
});

const ArticleContainer = styled.div({
  display: "flex",
  flexDirection: "column",
  gap: "1.5rem",
  width: "clamp(300px, 90vw, 800px)"
});

function Blog() {
  const { data: articles = [], isLoading, error } = useQuery({ queryKey: ["articles"], queryFn: getArticles });

  return (
    <BlogContainer>
      <Title>Welcome to the new AI auto-generated blog!</Title>
      <ArticleContainer>
        {articles.map(article => {
          return <Article key={article.id} article={article} />
        })}
      </ArticleContainer>
    </BlogContainer>
  );
}

export default Blog;
