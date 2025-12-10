import { css, Global } from "@emotion/react";

export default function GlobalCSS() {
  return (
    <Global
      styles={css`
        *,
        *::before,
        *::after {
          box-sizing: border-box;
          margin: 0;
          padding: 0;
        }

        body {
          font-family: "Inter", system-ui, sans-serif;
          background-color: #f5f5f5;
          color: #1a1a1a;
          line-height: 1.6;
          min-height: 100vh;
        }

        h1,
        h2,
        h3,
        h4,
        h5,
        h6 {
          font-weight: 600;
          line-height: 1.25;
          color: #111;
          margin: 1em 0 0.75em;
        }

        p {
          margin: 0.75em 0;
        }

        ul,
        ol {
          margin: 0.5em 0;
          padding-left: 1.5em;
        }
      `}
    />
  );
}
