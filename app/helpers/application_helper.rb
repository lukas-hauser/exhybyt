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

  def user_currencies
    [["CHF","chf"],
    ["EUR","eur"],
    ["GBP","gbp"],
    ["USD","usd"]]
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

  def artwork_categories
    [["Advertisement","Advertisement"],
    ["Drawing","Drawing"],
    ["Painting","Painting"],
    ["Photography","Photography"],
    ["Sculpture","Sculpture"]]
  end

  def artwork_status
    [["For Sale","For Sale"],
    ["Not For Sale","Not For Sale"],
    ["Sold","Sold"]]
  end

  def artwork_subjects
    [["Abstract","Abstract"],
    ["Aerial","Aerial"],
    ["Airplane","Airplane"],
    ["Animal","Animal"],
    ["Architecture","Architecture"],
    ["Automobile","Automobile"],
    ["Beach","Beach"],
    ["Bicycle","Bicycle"],
    ["Bike","Bike"],
    ["Boat","Boat"],
    ["Body","Body"],
    ["Botanic","Botanic"],
    ["Business","Business"],
    ["Calligraphy","Calligraphy"],
    ["Car","Car"],
    ["Cartoon","Cartoon"],
    ["Cats","Cats"],
    ["Celebrity","Celebrity"],
    ["Children","Children"],
    ["Cinema","Cinema"],
    ["Cities","Cities"],
    ["Cityscape","Cityscape"],
    ["Classical Mythology","Classical Mythology"],
    ["Comics","Comics"],
    ["Cows","Cows"],
    ["Cuisine","Cuisine"],
    ["Culture","Culture"],
    ["Dogs","Dogs"],
    ["Education","Education"],
    ["Erotic","Erotic"],
    ["Family","Family"],
    ["Fantasy","Fantasy"],
    ["Fashion","Fashion"],
    ["Fish","Fish"],
    ["Floral","Floral"],
    ["Food","Food"],
    ["Food & Drink","Food & Drink"],
    ["Garden","Garden"],
    ["Geometric","Geometric"],
    ["Graffiti","Graffiti"],
    ["Health & Beauty","Health & Beauty"],
    ["Home","Home"],
    ["Horse","Horse"],
    ["Humour","Humour"],
    ["Interiors","Interiors"],
    ["Kids","Kids"],
    ["Kitchen","Kitchen"],
    ["Landscape","Landscape"],
    ["Language","Language"],
    ["Light","Light"],
    ["Love","Love"],
    ["Men","Men"],
    ["Mortality","Mortality"],
    ["Motor","Motor"],
    ["Motorbike","Motorbike"],
    ["Motorcycle","Motorcycle"],
    ["Music","Music"],
    ["Nature","Nature"],
    ["Nude","Nude"],
    ["Outer Space","Outer Space"],
    ["Patterns","Patterns"],
    ["People","People"],
    ["Performing Arts","Performing Arts"],
    ["Places","Places"],
    ["Political","Political"],
    ["Politics","Politics"],
    ["Pop Culture","Pop Culture"],
    ["Portrait","Portrait"],
    ["Religion","Religion"],
    ["Rural Life","Rural Life"],
    ["Sailboat","Sailboat"],
    ["Science","Science"],
    ["Seascape","Seascape"],
    ["Seasons","Seasons"],
    ["Ship","Ship"],
    ["Sports","Sports"],
    ["Still Life","Still Life"],
    ["Technology","Technology"],
    ["Time","Time"],
    ["Train","Train"],
    ["Transportation","Transportation"],
    ["Travel","Travel"],
    ["Tree","Tree"],
    ["Typography","Typography"],
    ["Wall","Wall"],
    ["Water","Water"],
    ["Women","Women"],
    ["World Culture","World Culture"],
    ["Yacht","Yacht"]]
  end
end
