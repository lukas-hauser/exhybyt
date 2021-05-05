# frozen_string_literal: true

module ApplicationHelper
  def full_title(page_title = ' ')
    base_title = 'EXHYBYT'
    if page_title.empty?
      base_title
    else
      page_title + ' | ' + base_title
    end
  end

  def space_categories
    [['Wall Space', 'Wall Space'],
     ['Window Display', 'Window Display'],
     ['Entire Gallery', 'Entire Gallery']]
  end

  def user_currencies
    [%w[AUD aud],
     %w[CAD cad],
     %w[CHF chf],
     %w[EUR eur],
     %w[GBP gbp],
     %w[USD usd]]
  end

  def artwork_categories
    [%w[Drawing Drawing],
     %w[Painting Painting],
     %w[Photography Photography],
     %w[Sculpture Sculpture]]
  end

  def artwork_status
    [['For Sale', 'For Sale'],
     ['Not For Sale', 'Not For Sale'],
     %w[Sold Sold]]
  end
end
