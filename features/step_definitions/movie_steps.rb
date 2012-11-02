# Add a declarative step here for populating the DB with movies.

Given /the following movies exist/ do |movies_table|
  movies_table.hashes.each do |movie|
    # each returned element will be a hash whose key is the table header.
    # you should arrange to add that movie to the database here.
  Movie.create!(movie)
  end
#  flunk "Unimplemented"
end

Given /I check the following ratings:(.*)/ do |rating_list|
  rating=rating_list.gsub(/\w+/)
# Make sure that one string (regexp) occurs before or after another one
#   on the same page
  rating.each { |r| check("ratings_"+r) }
end

When /I uncheck all of the ratings/ do
  all_ratings=Movie.select('DISTINCT rating').map { |m| m.rating }.join(", ")
  step %{I uncheck the following ratings: #{all_ratings}}
end

Then /I should not see any of the movies/ do
  step %{I should see 0 table row}
end

Then /I should see (\d+) table row[s]?/ do |num_rows|
  actual_number = page.all('#movies tbody tr').size
  debugger
    actual_number.should == num_rows
end

Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
  #  ensure that that e1 occurs before e2.
  #  page.body is the entire content of the page as a string.
  flunk "Unimplemented"
end
# Make it easier to express checking or unchecking several boxes at once
#  "When I uncheck the following ratings: PG, G, R"
#  "When I check the following ratings: G"

When /I uncheck the following ratings: (.*)/ do |rating_list|
  # HINT: use String#split to split up the rating_list, then
  #   iterate over the ratings and reuse the "When I check..." or
  #   "When I uncheck..." steps in lines 89-95 of web_steps.rb
    rating=rating_list.split(",").map { |w| w.gsub(/\s+/,'') }
  rating.each do |r|
    step %{I uncheck "ratings_#{r}"}
  end
end
