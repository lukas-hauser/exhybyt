module ApplicationHelper
  def full_title(page_title = " ")
    base_title = "EXHYBYT"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def space_categories
    [["Wall Space", "Wall Space"],
      ["Window Display", "Window Display"],
      ["Entire Gallery", "Entire Gallery"]]
  end

  def user_currencies
    [["AUD", "aud"],
      ["CAD", "cad"],
      ["CHF", "chf"],
      ["EUR", "eur"],
      ["GBP", "gbp"],
      ["USD", "usd"]]
  end

  def artwork_categories
    [["Drawing", "Drawing"],
      ["Painting", "Painting"],
      ["Photography", "Photography"],
      ["Sculpture", "Sculpture"]]
  end

  def artwork_status
    [["For Sale", "For Sale"],
      ["Not For Sale", "Not For Sale"],
      ["Sold", "Sold"]]
  end
end
