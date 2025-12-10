import { useState } from "react";
import styled from "@emotion/styled";
import Markdown from "react-markdown";

const Card = styled.div({
  backgroundColor: "#fff",
  borderRadius: "0.75rem",
  boxShadow: "0 4px 12px rgba(0,0,0,0.08)",
  padding: "1.5rem",
  transition: "transform 0.2s ease, box-shadow 0.2s ease",
  cursor: "pointer",
  "&:hover": {
    transform: "translateY(-4px)",
    boxShadow: "0 8px 24px rgba(0, 0, 0, 0.12)",
  }
});

const Title = styled.h2({
  fontSize: "1.125rem",
  marginBottom: "0.5rem",
  userSelect: "none",
});

const Content = styled.div(({ open }) => ({
  maxHeight: open ? "400px" : "0",
  overflowY: open ? "auto" : "hidden",
  overflowX: "hidden",
  transition: "max-height 0.5s ease",
  scrollbarWidth: "none",
}));

function Article({ article }) {
  const [open, setOpen] = useState(false);
  const toggle = () => setOpen((prev) => !prev);
  
  return (
    <Card onClick={toggle}>
      <Title>{article.title}</Title>
      <Content open={open}><Markdown>{article.content}</Markdown></Content>
    </Card>
  );
}

export default Article;
