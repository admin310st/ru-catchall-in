<?xml version="1.0" encoding="UTF-8"?>
<!--
  Человеческий вид карты сайта (образец spintax.net/static/sitemap.xsl): браузер
  применяет это преобразование к sitemap.xml и показывает таблицу вместо простыни
  тегов. Поисковику всё равно — он читает исходный XML.

  Стили здесь свои и полные: документ не наш HTML, подключить собранный CSS с хешем в
  имени неоткуда, а токены темы в него не приезжают. Поэтому палитра продублирована
  значениями и следует системной теме через prefers-color-scheme — как и сам сайт.
  Дубль осознанный и маленький; правится вместе с theme.css.

  Файл лежит в ui/static, поэтому Vite копирует его в public/, а генератор — в
  русскую сборку (STATIC_FILES в site/page-langs.ts).
-->
<xsl:stylesheet version="1.0"
  xmlns:xsl="http://www.w3.org/1999/XSL/Transform"
  xmlns:sitemap="http://www.sitemaps.org/schemas/sitemap/0.9"
  xmlns:xhtml="http://www.w3.org/1999/xhtml">
<xsl:output method="html" encoding="UTF-8" indent="yes"/>
<xsl:template match="/">
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1"/>
  <meta name="robots" content="noindex"/>
  <title>Sitemap — Catchall</title>
  <style>
    :root {
      color-scheme: dark;
      --bg: #0B0D12; --panel: #12151C; --soft: #181C25;
      --text: #E8EAF0; --muted: #A2A8B6; --subtle: #8A9099;
      --line: rgba(255,255,255,.07); --accent: #5E8BFF;
    }
    @media (prefers-color-scheme: light) {
      :root {
        color-scheme: light;
        --bg: #FFFFFF; --panel: #F7F8FA; --soft: #EEF1F6;
        --text: #14171D; --muted: #525966; --subtle: #626975;
        --line: rgba(15,23,42,.08); --accent: #0055DC;
      }
    }
    * { margin: 0; padding: 0; box-sizing: border-box }
    body {
      font-family: system-ui, -apple-system, "Segoe UI", sans-serif;
      background: var(--bg); color: var(--text); line-height: 1.6; padding: 2rem 1rem;
    }
    .wrap { max-width: 1100px; margin: 0 auto }
    h1 { font-size: 1.5rem; font-weight: 700; margin-bottom: .25rem }
    .meta { color: var(--subtle); font-size: .875rem; margin-bottom: 1.5rem }
    .meta a { color: var(--accent) }
    table { width: 100%; border-collapse: collapse; font-size: .875rem }
    thead th {
      text-align: left; padding: .6rem .75rem; color: var(--subtle); font-weight: 500;
      border-bottom: 1px solid var(--line); font-size: .75rem;
      text-transform: uppercase; letter-spacing: .05em;
    }
    tbody tr { border-bottom: 1px solid var(--line) }
    tbody tr:hover { background: var(--panel) }
    td { padding: .5rem .75rem; vertical-align: top }
    a { color: var(--accent); text-decoration: none; word-break: break-all }
    a:hover { text-decoration: underline }
    .num { color: var(--subtle); font-variant-numeric: tabular-nums; text-align: right; width: 2.5rem }
    .langs { display: flex; flex-wrap: wrap; gap: .25rem .4rem }
    .lang {
      background: var(--soft); color: var(--muted); padding: .1rem .4rem;
      border-radius: 4px; font-size: .75rem; font-family: ui-monospace, monospace;
    }
    .lang.current { background: color-mix(in srgb, var(--accent) 18%, transparent); color: var(--accent); font-weight: 700 }
    .prio { color: var(--muted); font-variant-numeric: tabular-nums; text-align: right }
    @media (max-width: 700px) {
      table, thead, tbody, tr, td, th { display: block }
      thead { display: none }
      tr { margin-bottom: .75rem; border: 1px solid var(--line); border-radius: 6px; padding: .5rem }
      td { padding: .2rem 0; border: none; text-align: left }
      .num { display: none }
    }
  </style>
</head>
<body>
  <div class="wrap">
    <h1>Sitemap</h1>
    <p class="meta">
      <xsl:value-of select="count(sitemap:urlset/sitemap:url)"/>
      <xsl:text> pages on this host. Machine-readable XML is what a crawler reads; this table is for people.</xsl:text>
    </p>
    <table>
      <thead>
        <tr>
          <th class="num">#</th>
          <th>URL</th>
          <th>Languages</th>
          <th class="prio">Priority</th>
        </tr>
      </thead>
      <tbody>
        <xsl:for-each select="sitemap:urlset/sitemap:url">
          <tr>
            <td class="num"><xsl:value-of select="position()"/></td>
            <td><a href="{sitemap:loc}"><xsl:value-of select="sitemap:loc"/></a></td>
            <td>
              <div class="langs">
                <xsl:variable name="here" select="sitemap:loc"/>
                <xsl:for-each select="xhtml:link[@rel='alternate' and @hreflang != 'x-default']">
                  <xsl:choose>
                    <xsl:when test="@href = $here">
                      <span class="lang current"><xsl:value-of select="@hreflang"/></span>
                    </xsl:when>
                    <xsl:otherwise>
                      <a class="lang" href="{@href}"><xsl:value-of select="@hreflang"/></a>
                    </xsl:otherwise>
                  </xsl:choose>
                </xsl:for-each>
              </div>
            </td>
            <td class="prio"><xsl:value-of select="sitemap:priority"/></td>
          </tr>
        </xsl:for-each>
      </tbody>
    </table>
  </div>
</body>
</html>
</xsl:template>
</xsl:stylesheet>
