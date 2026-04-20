---
layout: page
title: Home
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
<section style="margin-top: 4rem;">
  <h2>Topics</h2>
  {% assign all_tags = "" | split: "" %}
  {% for note in site.notes %}
    {% if note.tags %}
      {% assign all_tags = all_tags | concat: note.tags %}
    {% endif %}
  {% endfor %}
  {% assign unique_tags = all_tags | uniq | sort %}

  <div class="tag-container" style="display: flex; flex-wrap: wrap; gap: 0.5rem; margin-bottom: 2rem;">
    <button class="tag-button active" onclick="filterTags('all', this)" style="padding: 0.3rem 0.8rem; border: 2px solid var(--header-border); background: transparent; cursor: pointer; font-family: inherit; font-size: 0.8rem;">
      All
    </button>
    {% for tag in unique_tags %}
      <button class="tag-button" onclick="filterTags('{{ tag | slugify }}', this)" style="padding: 0.3rem 0.8rem; border: 2px solid var(--header-border); background: transparent; cursor: pointer; font-family: inherit; font-size: 0.8rem;">
        {{ tag | capitalize }}
      </button>
    {% endfor %}
  </div>

  <div id="topic-notes">
    {% for tag in unique_tags %}
      <div class="tag-group" id="group-{{ tag | slugify }}" style="margin-bottom: 2rem;">
        <ul class="note-list" style="margin-top: 1rem;">
          {% assign tag_notes = site.notes | sort: "last_modified_at" | reverse %}
          {% for note in tag_notes %}
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
  </div>
</section>

<script>
  function filterTags(tagSlug, button) {
    // Update button styles
    document.querySelectorAll('.tag-button').forEach(btn => {
      btn.classList.remove('active');
      btn.style.backgroundColor = 'transparent';
      btn.style.color = 'var(--text-color)';
    });
    button.classList.add('active');
    button.style.backgroundColor = 'var(--header-border)';
    button.style.color = 'var(--bg-color)';

    // Filter groups
    const groups = document.querySelectorAll('.tag-group');
    groups.forEach(group => {
      if (tagSlug === 'all') {
        group.style.display = 'block';
      } else if (group.id === 'group-' + tagSlug) {
        group.style.display = 'block';
      } else {
        group.style.display = 'none';
      }
    });
  }

  // Initial state for 'All' button
  document.addEventListener('DOMContentLoaded', () => {
    const allBtn = document.querySelector('.tag-button.active');
    if (allBtn) {
      allBtn.style.backgroundColor = 'var(--header-border)';
      allBtn.style.color = 'var(--bg-color)';
    }
  });
</script>
