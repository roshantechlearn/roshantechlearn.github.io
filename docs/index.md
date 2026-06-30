---
layout: default
title: Home
---

<!-- Detailed Professional Biography Profile Section -->
<section class="bio-container">
  <h1 class="hero-greeting">Hey, I am {{ site.title }}</h1>
  <div class="bio-text">
    <p>
      I am a Senior Backend Engineer specializing in distributed infrastructure, high-throughput systems, and data platform architecture. My day-to-day work focuses on designing resilient software, low-latency streaming layers, and scaling data engine bottlenecks.
    </p>
    <p>
      I spend a significant amount of time deep-diving into JVM compilation internals, designing reactive cluster topographies, and engineering distributed execution trees to manage data efficiently at scale.
    </p>
    <div class="tech-stack-tags">
      // Core Stack: JDK • Scala • Akka • Apache Spark • Hive • Impala
    </div>
  </div>
</section>

<!-- Content Collections Section Layers -->
<section id="blogs">
  <h2>Blogs</h2>
  <ul class="item-list">
    {% for post in site.posts %}
    <li class="item-row">
      <div class="item-meta">{{ post.date | date: "%Y-%m-%d" }}</div>
      <div class="item-content"><a href="{{ post.url | relative_url }}">{{ post.title }}</a></div>
    </li>
    {% endfor %}
  </ul>
</section>

<section id="papershelf">
  <h2>Papershelf</h2>
  <ul class="item-list">
    {% for paper in site.papers %}
    <li class="item-row">
      <div class="item-meta">CS Paper</div>
      <div class="item-content">
        <a href="{{ paper.url | relative_url }}">{{ paper.title }}</a>
        {% if paper.conference %}<span class="item-extra">({{ paper.conference }})</span>{% endif %}
      </div>
    </li>
    {% endfor %}
  </ul>
</section>

<section id="bookshelf">
  <h2>Bookshelf</h2>
  <ul class="item-list">
    {% for book in site.books %}
    <li class="item-row">
      <div class="item-meta">
        {% if book.status == "reading" %}<span style="color: #d97706;">[Reading]</span>
        {% else %}<span style="color: #059669;">[Finished]</span>{% endif %}
      </div>
      <div class="item-content">
        <a href="{{ book.url | relative_url }}">{{ book.title }}</a>
        <span class="item-extra">by {{ book.author }}</span>
      </div>
    </li>
    {% endfor %}
  </ul>
</section>
