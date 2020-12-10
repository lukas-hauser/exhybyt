module ApplicationHelper
  def full_title(page_title = ' ')
    base_title = "EXHYBYT"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  def space_categories
    [["Wall Space","Wall Space"],
    ["Window Display","Window Display"],
    ["Entire Gallery","Entire Gallery"]]
  end

  def venue_types
    [["Airport","Airport"],
    ["Architecture Firm","Architecture Firm"],
    ["Art Gallery","Art Gallery"],
    ["Art Supply Store","Art Supply Store"],
    ["Bank","Bank"],
    ["Bar","Bar"],
    ["Barber","Barber"],
    ["Book Store","Book Store"],
    ["Charity","Charity"],
    ["Church","Church"],
    ["City Office","City Office"],
    ["Coffee Shop","Coffee Shop"],
    ["Convention Center","Convention Center"],
    ["Hair Saloon","Hair Saloon"],
    ["Hospital","Hospital"],
    ["Hotel","Hotel"],
    ["Interior Designer","Interior Designer"],
    ["Law Office","Law Office"],
    ["Library","Library"],
    ["Market Stall","Market Stall"],
    ["PopUp Space","PopUp Space"],
    ["Private Members Club","Private Members Club"],
    ["Restaurant","Restaurant"],
    ["University","University"],
    ["Other","Other"]]
  end

end
