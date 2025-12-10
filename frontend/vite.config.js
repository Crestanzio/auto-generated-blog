import { defineConfig } from 'vite'
import react from '@vitejs/plugin-react'

// https://vite.dev/config/
export default defineConfig({
  plugins: [react()],
  build  : { outDir: "build" },
  preview: {
    port: 4173,
    host: '0.0.0.0'
  },
  server: {
    fs: {
      strict: false
    }
  }
})
