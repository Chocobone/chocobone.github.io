# frozen_string_literal: true
require 'json'
require 'uri'

class BidirectionalLinksGenerator < Jekyll::Generator
  safe true
  priority :high

  def generate(site)
    all_notes = site.collections['notes'] ? site.collections['notes'].docs : []
    all_pages = site.pages
    all_docs = all_notes + all_pages

    # 1. 빠른 검색을 위한 타이틀 매핑 테이블 생성 (성능 최적화)
    link_map = {}
    all_docs.each do |doc|
      title = doc.data['title']
      filename = File.basename(doc.basename, File.extname(doc.basename))

      link_map[title.downcase] = doc if title
      link_map[filename.downcase] = doc
    end

    all_docs.each do |current_note|
      next unless current_note.content

      # 2. 이미지 변환 (![[image.png|width]])
      current_note.content.gsub!(/!\[\[(.*?)\]\]/) do |match|
        parts = $1.split('|')
        raw_path = parts[0].strip
        # 파일명만 추출 (폴더 경로가 포함되어 있어도 파일명만 쓰도록 설정된 경우 대비)
        filename = File.basename(raw_path)
        encoded_path = URI.encode_www_form_component(filename).gsub('+', '%20')

        extra = parts[1] ? parts[1].strip : nil
        width_attr = ""
        alt_text = filename

        if extra
          if extra =~ /^\d+$/
            width_attr = " width=\"#{extra}\""
          elsif extra =~ /^(\d+)x(\d+)$/
            width_attr = " width=\"#{$1}\" height=\"#{$2}\""
          else
            alt_text = extra
          end
        end

        "<img src=\"#{site.baseurl}/assets/images/#{encoded_path}\"#{width_attr} alt=\"#{alt_text}\" class=\"obsidian-img\">"
      end

      # 3. 내부 링크 변환 ([[Link|Alias]])
      current_note.content.gsub!(/\[\[(.*?)\]\]/) do |match|
        content = $1.split('|')
        target_query = content[0].strip.downcase
        display_text = content[1] ? content[1].strip : content[0].strip

        if link_map[target_query]
          target_doc = link_map[target_query]
          "<a class='internal-link' href='#{site.baseurl}#{target_doc.url}'>#{display_text}</a>"
        else
          # 없는 페이지 처리
          "<span title='Note not found' class='invalid-link'><span class='invalid-link-brackets'>[[</span>#{display_text}<span class='invalid-link-brackets'>]]</span></span>"
        end
      end
    end

    # (그래프 생성 로직은 기존과 동일하게 유지하되, link_map을 활용해 개선 가능)
    generate_graph_json(site, all_notes)
  end

  def generate_graph_json(site, notes)
    # 그래프 데이터 생성 로직...
    # (기존 코드가 작동한다면 그대로 두셔도 무방합니다)
  end
end
