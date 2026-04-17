---
layout: page
title: Home
id: home
permalink: /
---

<section style="margin-top: 4rem;">
  <h2>Latest</h2>
  <ul class="note-list">
    {% assign recent_notes = site.notes | sort: "last_modified_at" | reverse %}
    {% for note in recent_notes limit: 1 %}
      <li>
        <span class="note-date">{{ note.last_modified_at | date: "%B %d, %Y" }}</span>
        <a class="internal-link" href="{{ site.baseurl }}{{ note.url }}">{{ note.title }}</a>
        <h5 style="margin-top: 0.5rem; font-weight: normal; opacity: 0.8;">
          {{ note.content | strip_html | truncate: 50 }}
        </h5>
      </li>
    {% endfor %}
  </ul>
</section>

<section style="margin-top: 4rem;">
  <h2>Topics</h2>
  {% assign all_notes = site.notes | sort: "last_modified_at" | reverse %}
  {% assign all_tags = "" | split: "" %}
  {% for note in site.notes %}
    {% if note.tags %}
      {% assign all_tags = all_tags | concat: note.tags %}
    {% endif %}
  {% endfor %}
  {% assign unique_tags = all_tags | uniq | sort %}

  {% for tag in unique_tags %}
    <div style="margin-bottom: 2rem;">
      <h3 id="{{ tag | slugify }}">{{ tag | capitalize }}</h3>
      <ul class="note-list">
        {% for note in all_notes %}
          {% if note.tags contains tag %}
            <li>
              <span class="note-date">{{ note.last_modified_at | date: "%B %d, %Y" }}</span>
              <a class="internal-link" href="{{ site.baseurl }}{{ note.url }}">{{ note.title }}</a>
            </li>
          {% endif %}
        {% endfor %}
      </ul>
    </div>
  {% endfor %}
</section>

<section style="margin-top: 4rem;">
  <h2>Writing</h2>
  <ul class="note-list">
    <li>
    <span class="note-date">{{ note.last_modified_at | date: "%B %d, %Y" }}</span>
    <a class="internal-link" href="{{ site.baseurl }}{{ note.url }}">{{ note.title }}</a>
    </li>
  </ul>
</section>
