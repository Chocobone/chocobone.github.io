---
layout: page
title: Home
permalink: /
---

<section style="margin-top: 4rem;">
  <h2>Latest</h2>
  <ul class="note-list">
    {% assign recent_notes = site.notes | sort: "created" | reverse %}
    {% for note in recent_notes limit: 1 %}
      <li>
        <span class="note-date">{{ note.created | date: "%B %d, %Y" }}</span>
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
    <button class="nes-btn tag-button is-primary" onclick="filterTags('all', this)">
      All
    </button>
    {% for tag in unique_tags %}
      <button class="nes-btn tag-button" onclick="filterTags('{{ tag | slugify }}', this)">
        {{ tag | capitalize }}
      </button>
    {% endfor %}
  </div>

  <div id="topic-notes">
    <!-- All Notes Group -->
    <div class="tag-group" id="group-all" style="margin-bottom: 2rem;">
      <ul class="note-list" style="margin-top: 1rem;">
        {% assign all_notes = site.notes | sort: "created" | reverse %}
        {% for note in all_notes %}
          <li>
            <span class="note-date">{{ note.created | date: "%B %d, %Y" }}</span>
            <a class="internal-link" href="{{ site.baseurl }}{{ note.url }}">{{ note.title }}</a>
          </li>
        {% endfor %}
      </ul>
    </div>

    {% for tag in unique_tags %}
      <div class="tag-group" id="group-{{ tag | slugify }}" style="margin-bottom: 2rem; display: none;">
        <ul class="note-list" style="margin-top: 1rem;">
          {% assign tag_notes = site.notes | sort: "created" | reverse %}
          {% for note in tag_notes %}
            {% if note.tags contains tag %}
              <li>
                <span class="note-date">{{ note.created | date: "%B %d, %Y" }}</span>
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
      btn.classList.remove('is-primary');
    });
    button.classList.add('is-primary');

    // Filter groups
    const groups = document.querySelectorAll('.tag-group');
    groups.forEach(group => {
      if (group.id === 'group-' + tagSlug) {
        group.style.display = 'block';
      } else {
        group.style.display = 'none';
      }
    });
  }
</script>
