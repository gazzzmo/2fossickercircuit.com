# 2 Fossicker Circuit — Property Website

Single-page marketing website for the sale of 2 Fossicker Circuit, Springfield QLD 4300,
live at https://2fossickercircuit.com (GitHub Pages, served from `main`).

- `index.html` — the entire site (no build step, no dependencies)
- Content sourced from the realestate.com.au listing (Property ID 152030564),
  marketed by Clare May Real Estate, Camira.

## Custom domain
GitHub Pages is configured with CNAME `2fossickercircuit.com`. DNS must point at Pages:

| Type  | Host | Value |
|-------|------|-------|
| A     | @    | 185.199.108.153 |
| A     | @    | 185.199.109.153 |
| A     | @    | 185.199.110.153 |
| A     | @    | 185.199.111.153 |
| AAAA  | @    | 2606:50c0:8000::153 |
| AAAA  | @    | 2606:50c0:8001::153 |
| AAAA  | @    | 2606:50c0:8002::153 |
| AAAA  | @    | 2606:50c0:8003::153 |
| CNAME | www  | gazzzmo.github.io |
