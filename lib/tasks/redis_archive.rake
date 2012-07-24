namespace "redis" do
  task :archive => [:environment] do
    Widget.archive_clicks
    Widget.archive_showings
  end
end