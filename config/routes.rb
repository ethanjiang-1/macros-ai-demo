Rails.application.routes.draw do

  get("/blank_form", { :controller => "macros", :action => "display_form" })
  post("/process_input", { :controller => "macros", :action => "do_magic" })

  # Solutions below. Don't peek until you try it yourself and get stuck!

  get("/solutions/blank_form", { :controller => "solutions", :action => "display_form" })
  
  post("/solutions/process_form", { :controller => "solutions", :action => "process_inputs" })
  
end
